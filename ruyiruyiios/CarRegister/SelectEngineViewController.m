//
//  SelectEngineViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/21.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "SelectEngineViewController.h"
#import "SelectSystemTableViewCell.h"
#import "SelectProductYearViewController.h"
#import "DBRecorder.h"

@interface SelectEngineViewController ()<UITableViewDelegate, UITableViewDataSource>{
    
    CGFloat headH;
}

@property(nonatomic, strong)NSArray *tireInfoArray;
@property(nonatomic, strong)NSMutableArray *pailiangMutableA;
@property(nonatomic, strong)UIView *engineheadView;
@property(nonatomic, strong)NSArray *firstLitter;
@property(nonatomic, strong)UITableView *engineTableV;

@end

@implementation SelectEngineViewController
@synthesize verhicleId;

- (NSArray *)tireInfoArray{
    
    if (_tireInfoArray == nil) {
        
        _tireInfoArray = [[NSArray alloc] init];
    }
    return _tireInfoArray;
}

- (NSMutableArray *)pailiangMutableA{
    
    if (_pailiangMutableA == nil) {
        
        _pailiangMutableA = [[NSMutableArray alloc] init];
    }
    return _pailiangMutableA;
}

- (UIView *)engineheadView{
    
    if (_engineheadView == nil) {
        
        _engineheadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, headH)];
        _engineheadView.backgroundColor = LOGINBACKCOLOR;
        UIImageView *headImageV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 25, MAINSCREEN.width-40, 70)];
        headImageV.image = [UIImage imageNamed:@"ic_jincheng3"];
        [_engineheadView addSubview:headImageV];
    }
    return _engineheadView;
}

- (UITableView *)engineTableV{
    
    if (_engineTableV == nil) {
        
        _engineTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, headH, MAINSCREEN.width, MAINSCREEN.height - headH - SafeDistance) style:UITableViewStylePlain];
        _engineTableV.backgroundColor = [UIColor clearColor];
        _engineTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _engineTableV.delegate = self;
        _engineTableV.dataSource = self;
    }
    return _engineTableV;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"车型选择";
    headH = 120.0;
    _firstLitter = @[@"选择发动机排量"];
    [self.view addSubview:self.engineheadView];
    [self.view addSubview:self.engineTableV];
    [self getDataFromInternet];
    // Do any additional setup after loading the view.
}

- (void)getDataFromInternet{
    
    NSDictionary *postDic = @{@"verhicleId":[NSString stringWithFormat:@"%@", verhicleId]};
    NSString *reqJson = [PublicClass convertToJsonData:postDic];
    [JJRequest postRequest:@"getCarTireInfoByCondition" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
//            NSLog(@"%@", data);
            [self analySize:data];
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"根据verhicleId条件筛选车辆:%@", error);
    }];
}

- (void)analySize:(NSArray *)dataArray{
    
    self.tireInfoArray = dataArray;
    for (int i = 0; i<self.tireInfoArray.count; i++) {

        NSDictionary *dic = [self.tireInfoArray objectAtIndex:i];
        FMDBCarTireInfo *tireInfo = [[FMDBCarTireInfo alloc] init];
        [tireInfo setValuesForKeysWithDictionary:dic];
        if (![self.pailiangMutableA containsObject:tireInfo.pailiang]) {

            [self.pailiangMutableA addObject:tireInfo.pailiang];
        }
    }
    [self.engineTableV reloadData];
}

//delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [_firstLitter count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.pailiangMutableA count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 37.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, 20)];
    headerView.backgroundColor = [UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:0.1];
    
    UILabel *letterLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, MAINSCREEN.width - 20, 20)];
    letterLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
    letterLabel.textColor = [UIColor blackColor];
    letterLabel.text = [_firstLitter objectAtIndex:section];
    [headerView addSubview:letterLabel];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIndentifier = @"cell";
    SelectSystemTableViewCell *systemCell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (systemCell == nil) {
        
        systemCell = [[SelectSystemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        systemCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    systemCell.nameLabel.text = [self.pailiangMutableA objectAtIndex:indexPath.row];
    return systemCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *paiLiang_Str = [self.pailiangMutableA objectAtIndex:indexPath.row];
    SelectProductYearViewController *productYearVC = [[SelectProductYearViewController alloc] init];
    productYearVC.productVerhicleId = verhicleId;
    productYearVC.pailiangStr = paiLiang_Str;
    [self.navigationController pushViewController:productYearVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

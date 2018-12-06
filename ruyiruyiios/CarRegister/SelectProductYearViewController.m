//
//  SelectProductYearViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/21.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "SelectProductYearViewController.h"
#import "SelectSystemTableViewCell.h"
#import "SelectTypeViewController.h"
#import "DBRecorder.h"

@interface SelectProductYearViewController ()<UITableViewDelegate, UITableViewDataSource>{
    
    CGFloat headH, engineW, engineX;
}

@property(nonatomic, strong)NSArray *tireInfoArray;
@property(nonatomic, strong)NSMutableArray *yearMutableA;
@property(nonatomic, strong)UIView *yearheadView;
@property(nonatomic, strong)UILabel *engineLabel;
@property(nonatomic, strong)UILabel *functionLabel;
@property(nonatomic, strong)NSArray *nameArray;
@property(nonatomic, strong)UITableView *yearTableV;

@end

@implementation SelectProductYearViewController
@synthesize productVerhicleId;
@synthesize pailiangStr;

- (NSArray *)tireInfoArray{
    
    if (_tireInfoArray == nil) {
        
        _tireInfoArray = [[NSArray alloc] init];
    }
    return _tireInfoArray;
}

- (NSMutableArray *)yearMutableA{
    
    if (_yearMutableA == nil) {
        
        _yearMutableA = [[NSMutableArray alloc] init];
    }
    return _yearMutableA;
}

- (UIView *)yearheadView{
    
    if (_yearheadView == nil) {
        
        _yearheadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, headH)];
        _yearheadView.backgroundColor = LOGINBACKCOLOR;
        UIImageView *headImageV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 25, MAINSCREEN.width-40, 70)];
        headImageV.image = [UIImage imageNamed:@"ic_jincheng3"];
        [_yearheadView addSubview:headImageV];
    }
    return _yearheadView;
}

- (UILabel *)engineLabel{
    
    if (_engineLabel == nil) {
        
        _engineLabel = [[UILabel alloc] init];
        _engineLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _engineLabel.textColor = [UIColor redColor];
        _engineLabel.text = pailiangStr;
        CGSize engineSize = [PublicClass getLabelSize:_engineLabel fontsize:14.0];
        engineW = engineSize.width;
        _engineLabel.frame = CGRectMake(engineX, 5, engineSize.width, 20);
    }
    return _engineLabel;
}

- (UILabel *)functionLabel{
    
    if (_functionLabel == nil) {
        
        _functionLabel = [[UILabel alloc] initWithFrame:CGRectMake(engineX+engineW+15+20, 5, MAINSCREEN.width - (engineX+engineW+15+20), 20)];
        _functionLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _functionLabel.textColor = [UIColor blackColor];
        _functionLabel.text = @"选择生产年份";
    }
    return _functionLabel;
}

- (UITableView *)yearTableV{
    
    if (_yearTableV == nil) {
        
        _yearTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, headH, MAINSCREEN.width, MAINSCREEN.height - headH - SafeDistance) style:UITableViewStylePlain];
        _yearTableV.backgroundColor = [UIColor clearColor];
        _yearTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _yearTableV.delegate = self;
        _yearTableV.dataSource = self;
    }
    return _yearTableV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"车型选择";
    headH = 120.0;
    engineX = 20.0;
    _nameArray = @[@"1996", @"1997"];
    [self.view addSubview:self.yearheadView];
    [self.view addSubview:self.yearTableV];
    [self getDataFromIntegerNet];
    // Do any additional setup after loading the view.
}

- (void)getDataFromIntegerNet{
    
    NSDictionary *postDic = @{@"verhicleId":[NSString stringWithFormat:@"%@", productVerhicleId], @"pailiang":pailiangStr};
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
        
        NSLog(@"根据verhicleId,排量条件筛选车辆:%@", error);
    }];
}

- (void)analySize:(NSArray *)dataArray{
    
    self.tireInfoArray = dataArray;
    for (int i = 0; i<self.tireInfoArray.count; i++) {

        NSDictionary *tireDic = [self.tireInfoArray objectAtIndex:i];
        FMDBCarTireInfo *carTireInfo = [[FMDBCarTireInfo alloc] init];
        [carTireInfo setValuesForKeysWithDictionary:tireDic];
        NSString *carYearStr = [NSString stringWithFormat:@"%@", carTireInfo.year];
        if (![self.yearMutableA containsObject:carYearStr]) {

            [self.yearMutableA addObject:carYearStr];
        }
    }
    [self.yearTableV reloadData];
}

//UITableViewDelegate and UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.yearMutableA count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 37.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *yeartableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, 30)];
    yeartableHeaderView.backgroundColor = [UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:0.1];
    [yeartableHeaderView addSubview:self.engineLabel];
    UIImageView *jiantouImageV = [[UIImageView alloc] initWithFrame:CGRectMake(engineX+engineW+15, 10, 6, 10)];
    jiantouImageV.image = [UIImage imageNamed:@"下一步"];
    [yeartableHeaderView addSubview:jiantouImageV];
    [yeartableHeaderView addSubview:self.functionLabel];

    return yeartableHeaderView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIndentifier = @"cell";
    SelectSystemTableViewCell *systemCell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (systemCell == nil) {
        
        systemCell = [[SelectSystemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        systemCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    systemCell.nameLabel.text = [self.yearMutableA objectAtIndex:indexPath.row];
    return systemCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SelectTypeViewController *selectTypeVC = [[SelectTypeViewController alloc] init];
    selectTypeVC.typeVerhicleId = productVerhicleId;
    selectTypeVC.typepailiangStr = pailiangStr;
    selectTypeVC.typeyear = [self.yearMutableA objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:selectTypeVC animated:YES];
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

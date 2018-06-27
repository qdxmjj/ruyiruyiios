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
        UIImageView *headImageV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 25, MAINSCREEN.width-40, 50)];
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
    
    [self getDataFromDatabase];
    self.title = @"车型选择";
    headH = 100.0;
    _firstLitter = @[@"选择发动机排量"];
    [self.view addSubview:self.engineheadView];
    [self.view addSubview:self.engineTableV];
    // Do any additional setup after loading the view.
}

- (void)getDataFromDatabase{
    
    self.tireInfoArray = [DBRecorder getTireInfoData:verhicleId];
    for (int i = 0; i<self.tireInfoArray.count; i++) {
        
        FMDBCarTireInfo *tireInfo = [self.tireInfoArray objectAtIndex:i];
        if (![self.pailiangMutableA containsObject:tireInfo.pailiang]) {
            
            [self.pailiangMutableA addObject:tireInfo.pailiang];
        }
    }
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

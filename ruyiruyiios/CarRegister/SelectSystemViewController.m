//
//  SelectSystemViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/21.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "SelectSystemViewController.h"
#import "SelectSystemTableViewCell.h"
#import "SelectEngineViewController.h"
#import "DBRecorder.h"

@interface SelectSystemViewController ()<UITableViewDelegate, UITableViewDataSource>{
    
    CGFloat headH;
}

@property(nonatomic, strong)NSArray *factoryA;
@property(nonatomic, strong)NSMutableDictionary *dataMutableDic;
@property(nonatomic, strong)UIView *systemheadView;
@property(nonatomic, strong)UITableView *systemTableV;

@end

@implementation SelectSystemViewController
@synthesize btosId;

- (NSArray *)factoryA{
    
    if (_factoryA == nil) {
        
        _factoryA = [[NSArray alloc] init];
    }
    return _factoryA;
}

- (NSMutableDictionary *)dataMutableDic{
    
    if (_dataMutableDic == nil) {
        
        _dataMutableDic = [[NSMutableDictionary alloc] init];
    }
    return _dataMutableDic;
}

- (UIView *)systemheadView{
    
    if (_systemheadView  == nil) {
        
        _systemheadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, headH)];
        _systemheadView.backgroundColor = LOGINBACKCOLOR;
        UIImageView *headImageV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 25, MAINSCREEN.width-40, 50)];
        headImageV.image = [UIImage imageNamed:@"ic_jincheng2"];
        [_systemheadView addSubview:headImageV];
    }
    return _systemheadView;
}

- (UITableView *)systemTableV{
    
    if (_systemTableV == nil) {
        
        _systemTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, headH, MAINSCREEN.width, MAINSCREEN.height - headH - 64) style:UITableViewStylePlain];
        _systemTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _systemTableV.backgroundColor = [UIColor clearColor];
        _systemTableV.delegate = self;
        _systemTableV.dataSource = self;
    }
    return _systemTableV;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDataFromDatabase];
    self.title = @"车型选择";
    headH = 100.0;
    [self.view addSubview:self.systemheadView];
    [self.view addSubview:self.systemTableV];
    // Do any additional setup after loading the view.
}

- (void)getDataFromDatabase{
    
    self.factoryA = [DBRecorder getFactoryData:btosId];
    NSLog(@"从数据库中查询到的值:%@", self.factoryA);
    for (int i = 0; i<self.factoryA.count; i++) {
        
        FMDBCarFactory *carFactory = [self.factoryA objectAtIndex:i];
        NSArray *verhicleA = [DBRecorder getVerhicleData:carFactory.factoryId];
        NSNumber *key = [NSNumber numberWithInt:i];
        [self.dataMutableDic setValue:verhicleA forKey:[NSString stringWithFormat:@"%@", key]];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [self.factoryA count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSString *keyStr = [NSString stringWithFormat:@"%@", [NSNumber numberWithInt:(int)section]];
    return [[self.dataMutableDic objectForKey:keyStr] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 37.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    FMDBCarFactory *carFactory = [self.factoryA objectAtIndex:section];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, 20)];
    headerView.backgroundColor = [UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:0.1];
    
    UILabel *letterLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, MAINSCREEN.width - 20, 20)];
    letterLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
    letterLabel.textColor = [UIColor blackColor];
    letterLabel.text = carFactory.factory;
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
    NSString *keyStr = [NSString stringWithFormat:@"%@", [NSNumber numberWithInt:(int)indexPath.section]];
    FMDBCarVerhicle *carVerhicle = [[self.dataMutableDic objectForKey:keyStr] objectAtIndex:indexPath.row];
    systemCell.nameLabel.text = carVerhicle.carVersion;
    return systemCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *keyStr = [NSString stringWithFormat:@"%@", [NSNumber numberWithInt:(int)indexPath.section]];
    FMDBCarVerhicle *carVerhicle = [[self.dataMutableDic objectForKey:keyStr] objectAtIndex:indexPath.row];
    SelectEngineViewController *selectEngineVC = [[SelectEngineViewController alloc] init];
    selectEngineVC.verhicleId = carVerhicle.verhicleId;
    [self.navigationController pushViewController:selectEngineVC animated:YES];
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

//
//  ManageCarViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/25.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "ManageCarViewController.h"
#import "ManageCarTableViewCell.h"
#import "DBRecorder.h"
#import "ManageCar.h"
#import <UIImageView+WebCache.h>
#import "CarInfoViewController.h"
#import "CodeLoginViewController.h"
#import "DelegateConfiguration.h"

@interface ManageCarViewController ()<UITableViewDelegate, UITableViewDataSource, LoginStatusDelegate, UpdateAddCarDelegate>

@property(nonatomic, strong)UIButton *addCarBtn;
@property(nonatomic, strong)UITableView *addCarTableV;
@property(nonatomic, strong)UIImageView *backImageV;
@property(nonatomic, strong)NSMutableArray *carMutableA;

@end

@implementation ManageCarViewController

- (UIButton *)addCarBtn{
    
    if (_addCarBtn == nil) {
        
        _addCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addCarBtn.frame = CGRectMake(10, MAINSCREEN.height - SafeDistance - 40, MAINSCREEN.width- 20, 34);
        _addCarBtn.layer.cornerRadius = 6.0;
        _addCarBtn.layer.masksToBounds = YES;
        [_addCarBtn setTitle:@"添加车辆" forState:UIControlStateNormal];
        [_addCarBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [_addCarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addCarBtn addTarget:self action:@selector(chickAddCarBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addCarBtn;
}

- (UITableView *)addCarTableV{
    
    if (_addCarTableV == nil) {
        
        _addCarTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height - SafeDistance - 40) style:UITableViewStylePlain];
        _addCarTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _addCarTableV.bounces = NO;
        _addCarTableV.delegate = self;
        _addCarTableV.dataSource = self;
    }
    return _addCarTableV;
}

- (UIImageView *)backImageV{
    
    if (_backImageV == nil) {
        
        _backImageV = [[UIImageView alloc] initWithFrame:CGRectMake((MAINSCREEN.width - 227)/2, (MAINSCREEN.height - SafeAreaTopHeight - 144)/2, 227, 144)];
        _backImageV.image = [UIImage imageNamed:@"ic_dakongbai"];
    }
    return _backImageV;
}

- (NSMutableArray *)carMutableA{
    
    if (_carMutableA == nil) {
        
        _carMutableA = [[NSMutableArray alloc] init];
    }
    return _carMutableA;
}

- (void)chickAddCarBtn{
    
    CarInfoViewController *carInfoVC = [[CarInfoViewController alloc] init];
    carInfoVC.is_alter = YES;
    [self.navigationController pushViewController:carInfoVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    DelegateConfiguration *delegateConfiguration = [DelegateConfiguration sharedConfiguration];
    [delegateConfiguration registerLoginStatusChangedListener:self];
    [delegateConfiguration registeraddCarListers:self];
    [self getDataFromInternet];
    self.title = @"管理车辆";
    
    [self addViews];
    // Do any additional setup after loading the view.
}

- (IBAction)backButtonAction:(id)sender{
    
    DelegateConfiguration *delegateConfig = [DelegateConfiguration sharedConfiguration];
    [delegateConfig unregisterLoginStatusChangedListener:self];
    [delegateConfig unregisteraddCarListers:self];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getDataFromInternet{
    
    NSDictionary *managePostDic = @{@"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]]};
    NSString *reqJson = [PublicClass convertToJsonData:managePostDic];
    [JJRequest postRequest:@"getCarListByUserId" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *mesgStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"-1"]) {
            
            [PublicClass showHUD:mesgStr view:self.view];
        }else if ([statusStr isEqualToString:@"-999"]){
            
            [self alertIsequallyTokenView];
        }else{
//            YLog(@"获取得到的车辆信息:%@", data);
            [self analysizeData:data];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"获取车辆列表数据错误:%@", error);
    }];
}

- (void)analysizeData:(NSArray *)dataArray{
    
    if (self.carMutableA.count != 0) {
        
        [self.carMutableA removeAllObjects];
    }
    if ([dataArray isKindOfClass:[NSNull class]]) {
        
        [PublicClass showHUD:@"此账号在别的地方登录" view:self.view];
    }else{
        
        for (int i = 0; i<dataArray.count; i++) {
            
            NSDictionary *dataDic = [dataArray objectAtIndex:i];
            ManageCar *manageCar = [[ManageCar alloc] init];
            [manageCar setValuesForKeysWithDictionary:dataDic];
            if (i == 0) {
                
                [UserConfig userDefaultsSetObject:manageCar.user_car_id key:@"userCarId"];
            }
            [self.carMutableA addObject:manageCar];
        }
    }
    [self.addCarTableV reloadData];
}

- (void)addViews{
    
    [self.view addSubview:self.addCarBtn];
    [self.view addSubview:self.addCarTableV];
    [self.view addSubview:self.backImageV];
    self.backImageV.hidden = YES;
}

//tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.carMutableA.count == 0) {
        
        self.backImageV.hidden = NO;
    }else{
        
        self.backImageV.hidden = YES;
    }
    return self.carMutableA.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIndentifier = @"managerCell";
    ManageCarTableViewCell *manageCell = [tableView cellForRowAtIndexPath:indexPath];
    if (manageCell == nil) {

        manageCell = [[ManageCarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        manageCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    ManageCar *manageCar = [self.carMutableA objectAtIndex:indexPath.row];
    [manageCell.carImageV sd_setImageWithURL:[NSURL URLWithString:manageCar.car_brand]];
    manageCell.carNameLabel.text = manageCar.car_name;
    manageCell.platNumberLabel.text = manageCar.plat_number;
    if ([manageCar.is_default intValue] == 1) {
        
        manageCell.defultImageV.hidden = NO;
    }
    return manageCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ManageCar *managerCar = [self.carMutableA objectAtIndex:indexPath.row];
    CarInfoViewController *carInfoVC = [[CarInfoViewController alloc] init];
    carInfoVC.user_car_idStr = [NSString stringWithFormat:@"%@", managerCar.user_car_id];
    carInfoVC.is_alter = NO;
    [self.navigationController pushViewController:carInfoVC animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        ManageCar *manageCar = [self.carMutableA objectAtIndex:indexPath.row];
        NSDictionary *deleteDic = @{@"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]], @"userCarId":[NSString stringWithFormat:@"%@", manageCar.user_car_id]};
        [self sendInternetUpdate:deleteDic requestStr:@"deleteCar" token:[UserConfig token]];
        NSLog(@"点击了删除");
    }];
    deleteAction.backgroundColor = LOGINBACKCOLOR;
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"设为默认" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        ManageCar *manageCar = [self.carMutableA objectAtIndex:indexPath.row];
        NSDictionary *deleteDic = @{@"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]], @"userCarId":[NSString stringWithFormat:@"%@", manageCar.user_car_id]};
        [self sendInternetUpdate:deleteDic requestStr:@"changeDefaultCar" token:[UserConfig token]];
        NSLog(@"点击了设为默认");
    }];
    return @[editAction, deleteAction];
}

- (void)sendInternetUpdate:(NSDictionary *)sendDic requestStr:(NSString *)questStr token:(NSString *)token{
    
    //typeStr 0for delete, 1for default
    NSString *deleteReqJson = [PublicClass convertToJsonData:sendDic];
    [JJRequest postRequest:questStr params:@{@"reqJson":deleteReqJson, @"token":token} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
            DelegateConfiguration *delegateConfiguration = [DelegateConfiguration sharedConfiguration];
            [delegateConfiguration changedefaultCarNumber];
            [self getDataFromInternet];
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        
    }];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle != UITableViewCellEditingStyleInsert) {
        
        return;
    }
}

//LoginStatusDelegate
- (void)updateLoginStatus{
    
    [self getDataFromInternet];
}

//UpdateAddCarDelegate
- (void)updateAddCarNumber{
    
    [self getDataFromInternet];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSLog(@"滑动的tableview");
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

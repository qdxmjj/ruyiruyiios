//
//  TireRepairViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/26.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "TireRepairViewController.h"
#import "TireRepairHeadView.h"
#import "TireRepairMiddleView.h"
#import "InstallStoreTableViewCell.h"
#import "StoreInfo.h"
#import "NearbyViewController.h"
#import "MyOrderViewController.h"

@interface TireRepairViewController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UIScrollView *mainScrollV;
@property(nonatomic, strong)TireRepairHeadView *tireHeadView;
@property(nonatomic, strong)TireRepairMiddleView *tireMiddleView;
@property(nonatomic, strong)UITableView *tireRepairTableV;
@property(nonatomic, strong)StoreInfo *storeInfo;
@property(nonatomic, strong)NSMutableArray *storeServiceMutableA;
@property(nonatomic, strong)UIButton *submitBtn;
@property(nonatomic, strong)NSString *platNumberStr;

@end

@implementation TireRepairViewController

- (UIScrollView *)mainScrollV{
    
    if (_mainScrollV == nil) {
        
        _mainScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height - SafeDistance - 40)];
        _mainScrollV.showsVerticalScrollIndicator = NO;
        _mainScrollV.showsHorizontalScrollIndicator = NO;
        _mainScrollV.delegate = self;
        _mainScrollV.bounces = NO;
        _mainScrollV.scrollsToTop = NO;
        _mainScrollV.tag = 2;
    }
    return _mainScrollV;
}

- (TireRepairHeadView *)tireHeadView{
    
    if (_tireHeadView == nil) {
        
        _tireHeadView = [[TireRepairHeadView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, 140)];
    }
    return _tireHeadView;
}

- (TireRepairMiddleView *)tireMiddleView{
    
    if (_tireMiddleView == nil) {
        
        _tireMiddleView = [[TireRepairMiddleView alloc] initWithFrame:CGRectMake(0, 141, MAINSCREEN.width, 120)];
    }
    return _tireMiddleView;
}

- (UITableView *)tireRepairTableV{
    
    if (_tireRepairTableV == nil) {
        
        _tireRepairTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 262, MAINSCREEN.width, 180) style:UITableViewStylePlain];
        _tireRepairTableV.delegate = self;
        _tireRepairTableV.dataSource = self;
        _tireRepairTableV.bounces = NO;
        _tireRepairTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tireRepairTableV;
}

- (StoreInfo *)storeInfo{
    
    if (_storeInfo == nil) {
        
        _storeInfo = [[StoreInfo alloc] init];
    }
    return _storeInfo;
}

- (NSMutableArray *)storeServiceMutableA{
    
    if (_storeServiceMutableA == nil) {
        
        _storeServiceMutableA = [[NSMutableArray alloc] init];
    }
    return _storeServiceMutableA;
}

- (UIButton *)submitBtn{
    
    if (_submitBtn == nil) {
        
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.frame = CGRectMake(10, MAINSCREEN.height - SafeDistance - 40, MAINSCREEN.width - 20, 34);
        _submitBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _submitBtn.layer.cornerRadius = 6.0;
        _submitBtn.layer.masksToBounds = YES;
        [_submitBtn setTitle:@"提交订单" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(chickSubmitBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

- (void)chickSubmitBtn:(UIButton *)button{
    
    NSDictionary *tireRepairPostDic = @{@"storeId":[NSString stringWithFormat:@"%@", self.storeInfo.storeId], @"userCarId":[NSString stringWithFormat:@"%@", [UserConfig userCarId]], @"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]]};
    NSString *reqJson = [PublicClass convertToJsonData:tireRepairPostDic];
    [JJRequest postRequest:@"addShoeRepairOrder" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
            MyOrderViewController *myorderVC = [[MyOrderViewController alloc] init];
            [self.navigationController pushViewController:myorderVC animated:YES];
            self.hidesBottomBarWhenPushed = YES;
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"添加轮胎修补订单:%@", error);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"轮胎修补";
    [self addViews];
    [self getCarByUserIdAndCarId];
    // Do any additional setup after loading the view.
}

- (void)addViews{
    
    [self.view addSubview:self.mainScrollV];
    [self.view addSubview:self.submitBtn];
    [_mainScrollV addSubview:self.tireHeadView];
    [_mainScrollV addSubview:self.tireMiddleView];
    [_mainScrollV addSubview:self.tireRepairTableV];
    [_mainScrollV setContentSize:CGSizeMake(MAINSCREEN.width, self.tireRepairTableV.frame.size.height + self.tireRepairTableV.frame.origin.y)];
}

- (void)setdatatoSubviews{
    
    [_tireHeadView setdatatoViews];
    [_tireMiddleView setdatatoViews:self.platNumberStr];
}

- (void)getCarByUserIdAndCarId{
    
    NSDictionary *getCarDic = @{@"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]], @"userCarId":[NSString stringWithFormat:@"%@", [UserConfig userCarId]]};
    NSString *reqJson = [PublicClass convertToJsonData:getCarDic];
    [JJRequest postRequest:@"getCarByUserIdAndCarId" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
//            NSLog(@"%@", data);
            if ([data isEqual:[NSNull null]] ) {
                
                [PublicClass showHUD:@"请先添加车辆！" view:self.view];
                return ;
            }
            self.platNumberStr = [data objectForKey:@"platNumber"];
            [self setdatatoSubviews];
            [self selectStoreByCondition];
        }else if ([statusStr isEqualToString:@"-999"]){
            
            [self alertIsequallyTokenView];
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"轮胎修补获取用户车辆信息错误:%@", error);
    }];
}

- (void)selectStoreByCondition{
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"currentCity"] == NULL) {
        
        [PublicClass showHUD:@"定位失败" view:self.view];
    }else{
        
        NSDictionary *postDic = @{@"page":@"1", @"rows":@"1", @"cityName":[[NSUserDefaults standardUserDefaults] objectForKey:@"currentCity"], @"storeName":@"", @"storeType":@"", @"serviceType":@"5", @"longitude":[[NSUserDefaults standardUserDefaults]objectForKey:@"longitude"], @"latitude":[[NSUserDefaults standardUserDefaults]objectForKey:@"latitude"], @"rankType":@"1"};
        NSString *reqJson = [PublicClass convertToJsonData:postDic];
        [JJRequest postRequest:@"selectStoreByCondition" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
            
            NSString *statusStr = [NSString stringWithFormat:@"%@", code];
            NSString *messageStr = [NSString stringWithFormat:@"%@", message];
            if ([statusStr isEqualToString:@"1"]) {
                
                //            NSLog(@"%@", data);
                [self analysizeDic:data];
            }else{
                
                [PublicClass showHUD:messageStr view:self.view];
            }
        } failure:^(NSError * _Nullable error) {
            
            NSLog(@"获取筛选店铺错误:%@", error);
        }];
    }
}

- (void)analysizeDic:(NSDictionary *)dataDic{
    
    if ([[dataDic objectForKey:@"storeQuaryResVos"] count]<=0) {
        
        [PublicClass showHUD:@"周围没有店铺！" view:self.view];
        return;
    }
    
    NSDictionary *storeInfoDic = [[dataDic objectForKey:@"storeQuaryResVos"] objectAtIndex:0];
    if (storeInfoDic == nil || [storeInfoDic isKindOfClass:[NSNull class]]) {
        
        storeInfoDic = dataDic;
    }
    self.storeInfo.storeId = [storeInfoDic objectForKey:@"storeId"];
    self.storeInfo.storeAddress = [storeInfoDic objectForKey:@"storeAddress"];
    self.storeInfo.distance = [storeInfoDic objectForKey:@"distance"];
    self.storeInfo.storeName = [storeInfoDic objectForKey:@"storeName"];
    self.storeInfo.storeImg = [storeInfoDic objectForKey:@"storeImg"];
    //    NSLog(@"%@----%@----%@----%@", self.storeInfo.storeId, self.storeInfo.storeAddress, self.storeInfo.distance, self.storeInfo.storeName);
    NSArray *storeServiceArray = [storeInfoDic objectForKey:@"storeServcieList"];
    if (self.storeServiceMutableA.count != 0) {
        
        [self.storeServiceMutableA removeAllObjects];
    }
    if (storeServiceArray.count<=0) {
        
        [PublicClass showHUD:@"周围没有店铺！" view:self.view];
        return;
    }
    for (int i = 0; i<storeServiceArray.count; i++) {
        
        NSDictionary *serviceDic = [[storeServiceArray objectAtIndex:i] objectForKey:@"service"];
        StoreServiceInfo *serviceinfo = [[StoreServiceInfo alloc] init];
        [serviceinfo setValuesForKeysWithDictionary:serviceDic];
        [self.storeServiceMutableA addObject:serviceinfo];
    }
    [self.tireRepairTableV reloadData];
}

//UITableViewDelegate and UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 180.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIndentifier = @"cell";
    InstallStoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIndentifier];
    if (cell == nil) {
        
        cell = [[InstallStoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIndentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.functionMutableA = self.storeServiceMutableA;
    [cell setDatatoInstallStoreCellStoreInfo:self.storeInfo];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NearbyViewController *nearbyVC = [[NearbyViewController alloc] init];
    nearbyVC.condition = @"轮胎服务";
    nearbyVC.status = @"1";
    nearbyVC.isLocation = @"1";
    nearbyVC.serviceType = @"5";
    nearbyVC.backBlock = ^(NSDictionary *dataDic) {
        
        [self analysizeDic:dataDic];
    };
    [self.navigationController pushViewController:nearbyVC animated:YES];
    self.hidesBottomBarWhenPushed = YES;
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

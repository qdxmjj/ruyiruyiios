//
//  FirstUpdateViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/11.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "FirstUpdateViewController.h"
#import <SDCycleScrollView.h>
#import "FirstUpdateMiddleView.h"
#import "InstallStoreTableViewCell.h"
#import "ReplacementProcessViewController.h"
#import "FontAndRearInfo.h"
#import "StoreInfo.h"
#import "StoreServiceInfo.h"
#import "NearbyViewController.h"
#import "MyOrderViewController.h"

@interface FirstUpdateViewController ()<SDCycleScrollViewDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>{
    
    NSInteger currentTireNumber;
}

@property(nonatomic, strong)UIScrollView *mainScrollV;
@property(nonatomic, strong)SDCycleScrollView *sdcycleScrollV;
@property(nonatomic, strong)FirstUpdateMiddleView *firstUpdateMiddleV;
@property(nonatomic, strong)UITableView *installStoreTableV;
@property(nonatomic, strong)FontAndRearInfo *fontAndRearInfo;
@property(nonatomic, strong)StoreInfo *storeInfo;
@property(nonatomic, strong)NSMutableArray *storeServiceMutableA;
@property(nonatomic, strong)UIButton *submitBtn;

@end

@implementation FirstUpdateViewController

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
}

- (UIScrollView *)mainScrollV{
    
    if (_mainScrollV == nil) {
        
        _mainScrollV = [[UIScrollView alloc] init];
        _mainScrollV.frame = CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height - 40 - SafeDistance);
        _mainScrollV.showsVerticalScrollIndicator = NO;
        _mainScrollV.showsHorizontalScrollIndicator = NO;
        _mainScrollV.bounces = NO;
        _mainScrollV.delegate = self;
        _mainScrollV.tag = 2;
        _mainScrollV.scrollsToTop = NO;
    }
    return _mainScrollV;
}

- (SDCycleScrollView *)sdcycleScrollV{
    
    if (_sdcycleScrollV == nil) {
        
        _sdcycleScrollV = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, MAINSCREEN.width, 140) delegate:self placeholderImage:nil];
        _sdcycleScrollV.autoScrollTimeInterval = 3.0;
        _sdcycleScrollV.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        [SDCycleScrollView clearImagesCache];
    }
    return _sdcycleScrollV;
}

- (FirstUpdateMiddleView *)firstUpdateMiddleV{
    
    if (_firstUpdateMiddleV == nil) {
        
        _firstUpdateMiddleV = [[FirstUpdateMiddleView alloc] init];
        _firstUpdateMiddleV.frame = CGRectMake(0, 141, MAINSCREEN.width, 200);
        [_firstUpdateMiddleV.updateProcessBtn addTarget:self action:@selector(chickMiddleUpdateBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _firstUpdateMiddleV;
}

- (void)chickMiddleUpdateBtn:(UIButton *)button{
    
    ReplacementProcessViewController *replaceProcessVC = [[ReplacementProcessViewController alloc] init];
    [self.navigationController pushViewController:replaceProcessVC animated:YES];
}

- (UITableView *)installStoreTableV{
    
    if (_installStoreTableV == nil) {
        
        _installStoreTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 342, MAINSCREEN.width, 170) style:UITableViewStylePlain];
        _installStoreTableV.bounces = NO;
        _installStoreTableV.delegate = self;
        _installStoreTableV.dataSource = self;
        _installStoreTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _installStoreTableV;
}

- (FontAndRearInfo *)fontAndRearInfo{
    
    if (_fontAndRearInfo == nil) {
        
        _fontAndRearInfo = [[FontAndRearInfo alloc] init];
    }
    return _fontAndRearInfo;
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
        _submitBtn.frame = CGRectMake(10, MAINSCREEN.height - 40 - SafeDistance, MAINSCREEN.width - 20, 34);
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
    
    NSDictionary *postDic = @{@"storeId":[NSString stringWithFormat:@"%@", self.storeInfo.storeId], @"userCarId":[NSString stringWithFormat:@"%@", [UserConfig userCarId]], @"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]], @"fontAmount":self.firstUpdateMiddleV.fontSelectView.numberLabel.text, @"rearAmount":self.firstUpdateMiddleV.rearSelectView.numberLabel.text, @"fontRearFlag":[NSString stringWithFormat:@"%@", self.fontAndRearInfo.fontRearFlag], @"orderType":@"2"};
    NSString *reqJson = [PublicClass convertToJsonData:postDic];
    [JJRequest postRequest:@"addFirstChangeShoeOrder" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
//            NSLog(@"%@", data);
            MyOrderViewController *myorderVC = [[MyOrderViewController alloc] init];
            myorderVC.statusStr = @"0";
            [self.navigationController pushViewController:myorderVC animated:YES];
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"首次更换订单错误:%@", error);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首次更换";
    [self.view addSubview:self.mainScrollV];
    [self.view addSubview:self.submitBtn];
    [self addViews];
    [self getUserUnusedShoeNum];
    // Do any additional setup after loading the view.
}

- (void)addViews{
    
    [_mainScrollV addSubview:self.sdcycleScrollV];
    [_mainScrollV addSubview:self.firstUpdateMiddleV];
    [_mainScrollV addSubview:self.installStoreTableV];
    [_mainScrollV setContentSize:CGSizeMake(MAINSCREEN.width, self.installStoreTableV.frame.size.height+self.installStoreTableV.frame.origin.y)];
    [self setDatatoView];
}

- (void)setDatatoView{
    
    _sdcycleScrollV.localizationImageNamesGroup = @[@"banner1", @"banner2", @"banner3"];
}

- (void)getUserUnusedShoeNum{
    
//    NSLog(@"获取到的汽车ID:%@", [UserConfig userCarId]);
    NSDictionary *postDic = @{@"userCarId":[NSString stringWithFormat:@"%@", [UserConfig userCarId]], @"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]]};
    NSString *reqJson = [PublicClass convertToJsonData:postDic];
    [JJRequest postRequest:@"getUserUnusedShoeNum" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
//            NSLog(@"%@", data);
            [self.fontAndRearInfo setValuesForKeysWithDictionary:data];
            [self setFontAndRearControlNumber:self.fontAndRearInfo];
            [self selectStoreByCondition];
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"获取可更换轮胎数错误:%@", error);
    }];
}

- (void)setFontAndRearControlNumber:(FontAndRearInfo *)fontAndRearInfo{
    
//    NSLog(@"%@", fontAndRearInfo.fontRearFlag);
    if ([fontAndRearInfo.fontRearFlag isEqualToNumber:[NSNumber numberWithInt:0]]) {
        
        if ([fontAndRearInfo.fontAvaliableAmount integerValue]>4) {
            
            self.firstUpdateMiddleV.fontSelectView.limitNumberStr = @"2";
            self.firstUpdateMiddleV.rearSelectView.limitNumberStr = @"2";
        }else{
            
            self.firstUpdateMiddleV.fontSelectView.limitNumberStr = @"2";
            self.firstUpdateMiddleV.rearSelectView.limitNumberStr = @"2";
            [self.firstUpdateMiddleV.fontSelectView.rightBtn addTarget:self action:@selector(chickFontRightBtn) forControlEvents:UIControlEventTouchUpInside];
            [self.firstUpdateMiddleV.fontSelectView.leftBtn addTarget:self action:@selector(chickFontLeftBtn) forControlEvents:UIControlEventTouchUpInside];
            [self.firstUpdateMiddleV.rearSelectView.rightBtn addTarget:self action:@selector(chickRearRightBtn) forControlEvents:UIControlEventTouchUpInside];
            [self.firstUpdateMiddleV.rearSelectView.leftBtn addTarget:self action:@selector(chickRearLeftBtn) forControlEvents:UIControlEventTouchUpInside];
        }
    }else{
        
        if ([fontAndRearInfo.fontAvaliableAmount intValue]>2) {
            
            self.firstUpdateMiddleV.fontSelectView.limitNumberStr = @"2";
        }else{
            
            self.firstUpdateMiddleV.fontSelectView.limitNumberStr = [NSString stringWithFormat:@"%@", fontAndRearInfo.fontAvaliableAmount];
        }
        if ([fontAndRearInfo.rearAvaliableAmount intValue]>2) {
            
            self.firstUpdateMiddleV.rearSelectView.limitNumberStr = @"2";
        }else{
            
            self.firstUpdateMiddleV.rearSelectView.limitNumberStr = [NSString stringWithFormat:@"%@", fontAndRearInfo.rearAvaliableAmount];
        }
    }
}

- (void)chickFontRightBtn{
    
    [self chickFontBtn];
}

- (void)chickFontLeftBtn{
    
    [self chickFontBtn];
}

- (void)chickFontBtn{
    
    currentTireNumber = [self.firstUpdateMiddleV.fontSelectView.numberLabel.text integerValue];
    NSInteger rearNumber = [self.fontAndRearInfo.fontAvaliableAmount integerValue] - currentTireNumber;
    if (rearNumber>2) {
        
        self.firstUpdateMiddleV.rearSelectView.limitNumberStr = @"2";
    }else{
        
        self.firstUpdateMiddleV.rearSelectView.limitNumberStr = [NSString stringWithFormat:@"%@", [NSNumber numberWithInteger:rearNumber]];
    }
}

- (void)chickRearRightBtn{
    
    [self chickRearBtn];
}

- (void)chickRearLeftBtn{
    
    [self chickRearBtn];
}

- (void)chickRearBtn{
    
    currentTireNumber = [self.firstUpdateMiddleV.rearSelectView.numberLabel.text integerValue];
    NSInteger fontNumber = [self.fontAndRearInfo.fontAvaliableAmount integerValue] - currentTireNumber;
    if (fontNumber>2) {
        
        self.firstUpdateMiddleV.fontSelectView.limitNumberStr = @"2";
    }else{
        
        self.firstUpdateMiddleV.fontSelectView.limitNumberStr = [NSString stringWithFormat:@"%@", [NSNumber numberWithInteger:fontNumber]];
    }
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
    for (int i = 0; i<storeServiceArray.count; i++) {
        
        NSDictionary *serviceDic = [[storeServiceArray objectAtIndex:i] objectForKey:@"service"];
        StoreServiceInfo *serviceinfo = [[StoreServiceInfo alloc] init];
        [serviceinfo setValuesForKeysWithDictionary:serviceDic];
        [self.storeServiceMutableA addObject:serviceinfo];
    }
    [self.installStoreTableV reloadData];
}

#pragma mark UITableViewDelegate and UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 170.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuserIndentifier = @"reuserIndentifier";
    InstallStoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserIndentifier];
    if (cell == nil) {
        
        cell = [[InstallStoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserIndentifier];
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
        
//        NSLog(@"%@", dataDic);
        [self analysizeDic:dataDic];
    };
    [self.navigationController pushViewController:nearbyVC animated:YES];
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

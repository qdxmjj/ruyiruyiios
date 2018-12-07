//
//  HomeViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/8.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//
#import "HomeViewController.h"
#import "BaseNavigation.h"
#import "WelcomeViewController.h"
#import <SDCycleScrollView.h>
#import <UIImageView+WebCache.h>
#import "HomeFirstView.h"
#import "HomeTableViewCell.h"
#import "DBRecorder.h"
#import "Lunbo_infos.h"
#import "Data_cars.h"
#import "CodeLoginViewController.h"
#import "CarInfoViewController.h"
#import "ManageCarViewController.h"
#import "LocationViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "DelegateConfiguration.h"
#import "SelectTirePositionViewController.h"
#import "SmoothJourneyViewController.h"
#import "NearbyViewController.h"
#import "TireRepairViewController.h"
#import "FreeChangeViewController.h"

#import "CycleScrollViewDetailsController.h"
#import "TobeReplacedTiresViewController.h"
#import "NewTirePurchaseViewController.h"
#import "MyWebViewController.h"

#import "EntranceView.h"
#import "FirstStartConfiguration.h"
#import "MBProgressHUD+YYM_category.h"
#import "ADView.h"
#import <Masonry.h>
@interface HomeViewController ()<UIScrollViewDelegate, SDCycleScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, LoginStatusDelegate, CLLocationManagerDelegate,LoginStatusDelegate, CityNameDelegate,UpdateAddCarDelegate,ADActivityDelegate,EntranceViewDelegate>{
    
    CGFloat nameW;
    CGFloat tviewX, tviewY, tviewW, tviewH;
    NSString *userid;
}
@property (nonatomic, strong)UIScrollView *mainScrollV;
@property (nonatomic, strong)SDCycleScrollView *sdcycleScrollV;//上部轮播

@property (nonatomic, strong)UIButton *locationBtn;
@property (nonatomic, strong)UIButton *resetBtn;//重置btn
@property (nonatomic, strong)UITapGestureRecognizer *fTapGR;
@property (nonatomic, strong)UIView *changeView;
@property (nonatomic, strong)HomeFirstView *firstView;
@property (nonatomic, strong)EntranceView *entranceView;
@property (nonatomic, strong)UITableView *homeTableV;

@property (nonatomic, strong)NSMutableArray *imgMutableA;
@property (nonatomic, strong)NSString *user_token;
@property (nonatomic, strong)NSDictionary *data_carDic;
@property (nonatomic, strong)Data_cars *dataCars;
@property (nonatomic, strong)CLLocationManager *locationManager;
@property (nonatomic, copy)NSString *currentCity;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![[NSUserDefaults standardUserDefaults] valueForKey:@"isFirst"]) {
        
        WelcomeViewController *welcomeVC = [[WelcomeViewController alloc] init];
        [self.navigationController presentViewController:[[BaseNavigation alloc]initWithRootViewController:welcomeVC] animated:YES completion:nil];
    }
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeAll;
    }
    
    _currentCity = @"定位中";
    
    //去掉了 添加车辆代理方法 修改默认车辆代理方法  剩下一个 修改默认城市代理方法  日后再改
    DelegateConfiguration *delegateCF = [DelegateConfiguration sharedConfiguration];
    [delegateCF registercityNameListers:self];
    [delegateCF registerLoginStatusChangedListener:self];
    [delegateCF registeraddCarListers:self];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mainScrollV];
    [self.mainScrollV addSubview:self.sdcycleScrollV];

    [self.sdcycleScrollV addSubview:self.locationBtn];
    [self.sdcycleScrollV addSubview:self.resetBtn];
    [self.mainScrollV addSubview:self.changeView];
    UIImageView *backImageview = [[UIImageView alloc] init];
    backImageview.image = [UIImage imageNamed:@"注册框"];
    [self.changeView addSubview:backImageview];
    [self.changeView addSubview:self.firstView];
    [self.mainScrollV addSubview:self.entranceView];

    [self.mainScrollV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.mas_equalTo(self.view);
    }];
    
    [self.sdcycleScrollV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.view.mas_top);
        make.left.and.right.mas_equalTo(self.view);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(.35);
    }];
    
    [self.locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.sdcycleScrollV.mas_top).inset(getRectStatusHight);
        make.left.mas_equalTo(self.view.mas_left).inset(16);
        make.height.mas_equalTo(25);
    }];
    
    [self.resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.locationBtn.mas_top);
        make.right.mas_equalTo(self.view.mas_right).inset(16);
        make.width.height.mas_equalTo(CGSizeMake(40, 30));
    }];
    
    [self.changeView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.sdcycleScrollV.mas_bottom).offset(-20);
        make.left.right.mas_equalTo(16);
        make.height.mas_equalTo(self.sdcycleScrollV.mas_height).multipliedBy(0.25);
    }];
    
    [backImageview mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.mas_equalTo(self.changeView);
    }];
    
    [self.firstView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.mas_equalTo(self.changeView);
    }];
    
    [self.entranceView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.changeView.mas_bottom);
        make.height.mas_equalTo((MAINSCREEN.width-50)/4 * 1.2);
    }];
    
//        [_mainScrollV addSubview:self.homeTableV];
    [_mainScrollV setContentSize:CGSizeMake(MAINSCREEN.width, (tviewY+tviewH+82))];

     //定位成功后再请求主页数据 因为 新接口需要传入位置信息  日后更改定位方式
//    [self getAndroidHomeDate];
    //获取弹窗广告
    [self getActivityInfo];
    //定位
    [self locateMap];

    //生成购买轮胎订单的时候 的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(generateTireOrderNoticeEvent) name:GenerateTireOrderNotice object:nil];
    //设置默认车辆的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(generateTireOrderNoticeEvent) name:ModifyDefaultCarNotification object:nil];
}

#pragma mark setData
- (void)getAndroidHomeDate{
    
    if (![[NSUserDefaults standardUserDefaults] valueForKey:@"isFirst"]) {
        
        userid = @"0";
        [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:@"isFirst"];
    }else{
        
        _user_token = [UserConfig token];
        if (_user_token.length == 0) {
            
            userid =@"0";
        }else{
            
            userid = [NSString stringWithFormat:@"%@", [UserConfig user_id]];
        }
    }
    
    NSString *currentCity = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentCity"];
    if (currentCity.length<=0) {
        
         currentCity = @"定位失败";
    }
    
    NSDictionary *androidHomeDic = @{@"userId":userid,@"position":currentCity};
    NSString *adroidHomereqJson = [PublicClass convertToJsonData:androidHomeDic];
    [MBProgressHUD showWaitMessage:@"正在获取首页数据.." showView:self.view];
    
    [JJRequest postRequest:@"getAndroidHomeDate" params:@{@"reqJson":adroidHomereqJson} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"-1"]) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [PublicClass showHUD:messageStr view:self.view];
            });
        }else{
            
            self.data_carDic = [data objectForKey:@"androidHomeData_cars"];
            NSArray *imgArray = [data objectForKey:@"lunbo_infos"];
            if (self.data_carDic == nil || [self.data_carDic isKindOfClass:[NSNull class]]) {
                
                [UserConfig userDefaultsSetObject:@"0" key:@"userCarId"];
            }else{
                
                [self setuserDatacarData:self.data_carDic];
            }
            [self setImageurlData:imgArray];
            [self setElementOffirstView];
            
//                        [self.homeTableV reloadData];
            
        }
        [MBProgressHUD hideWaitViewAnimated:self.view];
        
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"获取主页信息错误:%@", error);
        [MBProgressHUD hideWaitViewAnimated:self.view];
    }];
}

- (void)setuserDatacarData:(NSDictionary *)carDic{
    
    if (carDic.count != 0) {
        
        Data_cars *data_car = [[Data_cars alloc] init];
        [data_car setValuesForKeysWithDictionary:carDic];
        self.dataCars = data_car;
        [UserConfig userDefaultsSetObject:data_car.user_car_id key:@"userCarId"];
    }
}

- (void)setImageurlData:(NSArray *)dataArray{
    
    if (self.imgMutableA.count != 0) {
        
        [self.imgMutableA removeAllObjects];
    }
    for (NSDictionary *imgDic in dataArray) {
        
        Lunbo_infos *lun_info = [[Lunbo_infos alloc] init];
        [lun_info setValuesForKeysWithDictionary:imgDic];

        [self.imgMutableA addObject:lun_info.contentImageUrl];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        _sdcycleScrollV.imageURLStringsGroup = self.imgMutableA;
    });
}

-(void)getActivityInfo{
    
    [JJRequest postRequest:@"getAppActivity" params:nil success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
       
        NSLog(@"%@ %@ %@",code,message,data);
        
        if ([data count]>0) {
            ADView *adView = [[ADView alloc] initWithFrame:self.view.frame];
            adView.delegate = self;
            [adView setActivityInfo:data];
            [adView show:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}
#pragma mark 点击事件
- (void)selectLocationBtn{
    
    LocationViewController *locationVC = [[LocationViewController alloc] init];
    locationVC.current_cityName = self.locationBtn.titleLabel.text;
    [self.navigationController pushViewController:locationVC animated:YES];
}

-(void)resetHomeInfoWithCarInfo{
    [self getAndroidHomeDate];
}

- (UITapGestureRecognizer *)fTapGR{
    
    if (_fTapGR == nil) {
        
        _fTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGRAction)];
    }
    return _fTapGR;
}

- (void)tapGRAction{
    
    if (_user_token.length == 0) {
        
        CodeLoginViewController *codeLVC = [[CodeLoginViewController alloc] init];
        codeLVC.homeTologinStr = @"1";
        [self.navigationController pushViewController:codeLVC animated:YES];
    }else{
        
        if ([_data_carDic isKindOfClass:[NSNull class]] || _data_carDic == nil) {
            
            CarInfoViewController *carinfoVC = [[CarInfoViewController alloc] init];
            carinfoVC.is_alter = YES;
            [self.navigationController pushViewController:carinfoVC animated:YES];
        }else{
            
            ManageCarViewController *manageCarVC = [[ManageCarViewController alloc] init];
            [self.navigationController pushViewController:manageCarVC animated:YES];
        }
    }
    NSLog(@"给changeView添加的手势");
}

- (void)locateMap{
    
    if ([CLLocationManager locationServicesEnabled]) {
        
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        [_locationManager requestAlwaysAuthorization];
        _currentCity = [[NSString alloc] init];
        [_locationManager requestWhenInUseAuthorization];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 5.0;
        [_locationManager startUpdatingLocation];
    }
}

#pragma mark - TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIndentifier = @"homeCell";
    HomeTableViewCell *homeCell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (homeCell == nil) {
        
        homeCell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        homeCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    homeCell.backImageV.image = [UIImage imageNamed:@"一元洗车"];
    return homeCell;
}

#pragma mark cycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    CycleScrollViewDetailsController *cycleViewDetails = [[CycleScrollViewDetailsController alloc] init];
    cycleViewDetails.index = index;
    cycleViewDetails.tireSize = self.dataCars.font;
    cycleViewDetails.dataCars = self.dataCars;
    [self.navigationController pushViewController:cycleViewDetails animated:YES];
}
#pragma mark ADViewDelegate
-(void)adview:(ADView *)adview didSelectItemAtShareType:(shareType)type shareText:(nonnull NSString *)text shareURL:(nonnull NSString *)url{
    
    MyWebViewController *myWebVC = [[MyWebViewController alloc] init];
    NSString *newURL;
    if ([url rangeOfString:@"http://"].location == NSNotFound) {
        
        newURL = [NSString stringWithFormat:@"http://%@", [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    }else{
        newURL = [NSString stringWithFormat:@"%@", [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    }
    myWebVC.url = newURL;
    [myWebVC activityInfoWithShareType:type shareText:text shareUrl:url];
    [self.navigationController pushViewController:myWebVC animated:YES];
}
#pragma mark EntranceViewDelegate
-(void)EntranceView:(EntranceView *)view didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //1000轮胎购买，1001免费更换，1002免费修补，1003待更换轮胎
    //2000畅行无忧，2001汽车保养，2002美容清洗
    if ([UserConfig user_id] == NULL) {
        
        [self alertIsloginView];
        return;
    }
    
    switch (indexPath.item) {
        case 0:{
            [self chickBuytyreBtn:[UIButton new]];
        }
            break;
        case 1:{
            FreeChangeViewController *tireRepairVC = [[FreeChangeViewController alloc] init];
            [self.navigationController pushViewController:tireRepairVC animated:YES];
        }
            break;
        case 2:{
            TireRepairViewController *tireRepairVC = [[TireRepairViewController alloc] init];
            [self.navigationController pushViewController:tireRepairVC animated:YES];
        }
            break;
        case 3:{
            TobeReplacedTiresViewController *tobeReplacedVC = [[TobeReplacedTiresViewController alloc] init];
            [self.navigationController pushViewController:tobeReplacedVC animated:YES];
        }
            break;
            
        default:
            break;
    }
//            NearbyViewController *nearbyVC = [[NearbyViewController alloc] init];
//            nearbyVC.status = @"0";
//            nearbyVC.isLocation = @"1";
//            if (1 == 2001) {
//
//                nearbyVC.serviceType = @"2";
//                nearbyVC.condition = @"汽车保养";
//            }else{
//
//                nearbyVC.serviceType = @"3";
//                nearbyVC.condition = @"美容清洗";
//            }
//            [self.navigationController pushViewController:nearbyVC animated:YES];

    
}

#pragma mark 跳转轮胎购买页面事件
- (void)chickBuytyreBtn:(UIButton *)btn{
    
    if ([self.dataCars isEqual:[NSNull null]] || self.dataCars == nil || !self.dataCars || [UserConfig userCarId].intValue == 0) {
        
        CarInfoViewController *carinfoVC = [[CarInfoViewController alloc] init];
        carinfoVC.is_alter = YES;
        [self.navigationController pushViewController:carinfoVC animated:YES];
        
        return;
    }
    //前后轮一致 直接进入轮胎购买页面 不一致先进入选择前后轮界面 再进入轮胎购买
    if ([self.dataCars.font isEqualToString:self.dataCars.rear]) {
        
        NewTirePurchaseViewController *newTireVC = [[NewTirePurchaseViewController alloc] init];

        newTireVC.fontRearFlag = @"0";
        newTireVC.tireSize = self.dataCars.font;
        newTireVC.service_end_date = self.dataCars.service_end_date;
        newTireVC.service_year = self.dataCars.service_year;
        newTireVC.service_year_length = self.dataCars.service_year_length;

        [self.navigationController pushViewController:newTireVC animated:YES];
        
    }else{

        SelectTirePositionViewController *selectTPVC = [[SelectTirePositionViewController alloc] init];
        selectTPVC.dataCars = self.dataCars;
        [self.navigationController pushViewController:selectTPVC animated:YES];
    }
}



#pragma mark - 定位失败
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSURL *settingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:settingURL options:@{} completionHandler:nil];
        } else {
            // Fallback on earlier versions
        }
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    [alert addAction:cancel];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 定位成功
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    [_locationManager stopUpdatingLocation];
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f", currentLocation.coordinate.longitude] forKey:@"longitude"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f", currentLocation.coordinate.latitude] forKey:@"latitude"];
//    NSTimeInterval locationAge = -[currentLocation.timestamp timeIntervalSinceNow];
//    if (locationAge > 1.0) {
//
//        return;
//    }
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (placemarks.count >0) {
            
            CLPlacemark *placeMark = placemarks[0];
            _currentCity = placeMark.subLocality;//2018.10.24 改为默认显示县 之前默认为市
            NSString *currentStr = placeMark.locality;
            if (!_currentCity) {
                
                _currentCity = @"无法定位当前城市";
            }
            [[NSUserDefaults standardUserDefaults] setObject:_currentCity forKey:@"currentCity"];//存储 当前定位的信息 县
            [[NSUserDefaults standardUserDefaults] setObject:_currentCity forKey:@"positionCounty"];//存储 当前定位的信息 县
            [UserConfig userDefaultsSetObject:currentStr key:@"selectCityName"];//当前的城市
            [self.locationBtn setTitle:_currentCity forState:UIControlStateNormal];
            
            [self getAndroidHomeDate];//定位成功后请求主页数据  定位结果返回会执行多次  重复网络请求 不合理 暂未处理
            
        }else if (error == nil && placemarks.count){
            
            NSLog(@"NO location and error return");
        }else if (error){
            
            NSLog(@"location error:%@", error);
        }
    }];
}


#pragma mark 懒加载
- (NSMutableArray *)imgMutableA{
    
    if (_imgMutableA == nil) {
        
        _imgMutableA = [[NSMutableArray alloc] init];
    }
    return _imgMutableA;
}

- (UIScrollView *)mainScrollV{
    
    if (_mainScrollV == nil) {
        
        _mainScrollV = [[UIScrollView alloc] init];
//        _mainScrollV.frame = CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height - Height_TabBar);
        _mainScrollV.backgroundColor = [UIColor clearColor];
        _mainScrollV.showsHorizontalScrollIndicator = NO;
        _mainScrollV.showsVerticalScrollIndicator = NO;
        _mainScrollV.bounces = NO;
        _mainScrollV.delegate = self;
        _mainScrollV.tag = 2;
        _mainScrollV.scrollsToTop = NO;
    }
    return _mainScrollV;
}

- (SDCycleScrollView *)sdcycleScrollV{
    
    if (_sdcycleScrollV == nil) {
        
        _sdcycleScrollV = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
        _sdcycleScrollV.autoScrollTimeInterval = 3.0;
        _sdcycleScrollV.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _sdcycleScrollV.backgroundColor = [UIColor whiteColor];
        [SDCycleScrollView clearImagesCache];
    }
    return _sdcycleScrollV;
}


- (UIButton *)locationBtn{
    
    if (_locationBtn == nil) {
        
        _locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _locationBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        [_locationBtn setTitle:_currentCity forState:UIControlStateNormal];
//        [_locationBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [_locationBtn setImage:[UIImage imageNamed:@"定位"] forState:UIControlStateNormal];
        [_locationBtn addTarget:self action:@selector(selectLocationBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _locationBtn;
}

- (UIButton *)resetBtn{
    
    if (_resetBtn == nil) {
        
        _resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_resetBtn setImage:[UIImage imageNamed:@"ic_shuaxin"] forState:UIControlStateNormal];
        [_resetBtn addTarget:self action:@selector(resetHomeInfoWithCarInfo) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetBtn;
}

- (UIView *)changeView{
    
    if (_changeView == nil) {
        
        _changeView = [[UIView alloc] init];
        _changeView.backgroundColor = [UIColor clearColor];
        _changeView.layer.cornerRadius = 8.0;
        _changeView.layer.masksToBounds = YES;
        [_changeView addGestureRecognizer:self.fTapGR];
    }
    return _changeView;
}

- (HomeFirstView *)firstView{
    
    if (_firstView == nil) {
        
        _firstView = [[HomeFirstView alloc] init];
        _firstView.backgroundColor = [UIColor clearColor];
        _firstView.layer.cornerRadius = 8.0;
        _firstView.layer.masksToBounds = YES;
    }
    return _firstView;
}

-(EntranceView *)entranceView{
    
    if (!_entranceView) {
        
        _entranceView = [[EntranceView alloc] init];
        _entranceView.delegate = self;
    }
    return _entranceView;
}

- (void)setElementOffirstView{
    
    if (_user_token == 0 || [[NSString stringWithFormat:@"%@", [UserConfig user_id]] isEqualToString:@""]) {
        
        self.firstView.iconImageV.image = [UIImage imageNamed:@"注册"];
        self.firstView.topLabel.text = @"新人注册享好礼";
        self.firstView.bottomLabel.text = @"注册享受价值xx元礼包";
    }else{
        
        if ([_data_carDic isKindOfClass:[NSNull class]] || _data_carDic == nil) {
            
            self.firstView.iconImageV.image = [UIImage imageNamed:@"添加"];
            self.firstView.topLabel.text = @"添加我的宝驹";
            self.firstView.bottomLabel.text = @"邀请好友绑定车辆可免费洗车";
        }else{
            
            [self.firstView.iconImageV sd_setImageWithURL:[NSURL URLWithString:self.dataCars.car_brand_url]];
            self.firstView.topLabel.text = self.dataCars.car_verhicle;
            self.firstView.bottomLabel.text = @"一次性购买四条轮胎送洗车券";
        }
    }
}
- (UITableView *)homeTableV{
    
    if (_homeTableV == nil) {
        
        _homeTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, tviewY + tviewH + 2, MAINSCREEN.width, 80) style:UITableViewStylePlain];
        _homeTableV.dataSource = self;
        _homeTableV.delegate = self;
        _homeTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _homeTableV.bounces = NO;
    }
    return _homeTableV;
}


#pragma mark notice
-(void)generateTireOrderNoticeEvent{
    
    [self getAndroidHomeDate];
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:GenerateTireOrderNotice object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ModifyDefaultCarNotification object:nil];
}

#pragma mark CityNameDelegate
- (void)updateCityName:(NSString *)cityNameStr{
    
    [self.locationBtn setTitle:cityNameStr forState:UIControlStateNormal];
    [self getAndroidHomeDate];

}

//#pragma mark UpdateAddCarDelegate
- (void)updateAddCarNumber{

    [self getAndroidHomeDate];
}

//#pragma mark SetDefaultCarDelegate
//- (void)updateDefaultCar{
//
//    [self getAndroidHomeDate];
//}

- (void)updateLoginStatus{
    
    _user_token = [UserConfig token];
    [self getAndroidHomeDate];
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

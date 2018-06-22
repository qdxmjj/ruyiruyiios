//
//  HomeViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/8.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//
#import "HomeViewController.h"
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
#import "ChoicePatternViewController.h"
#import "PassImpededViewController.h"
#import "NearbyViewController.h"

@interface HomeViewController ()<UIScrollViewDelegate, SDCycleScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, LoginStatusDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate, CityNameDelegate>{
    
    CGFloat nameW;
    CGFloat tviewX, tviewY, tviewW, tviewH;
    NSString *userid;
}
@property (nonatomic, strong)UIScrollView *mainScrollV;
@property (nonatomic, strong)SDCycleScrollView *sdcycleScrollV;
@property (nonatomic, strong)UILabel *centerLabel;
@property (nonatomic, strong)UIButton *locationBtn;
@property (nonatomic, strong)UITapGestureRecognizer *fTapGR;
@property (nonatomic, strong)UIView *changeView;
@property (nonatomic, strong)HomeFirstView *firstView;
@property (nonatomic, strong)UIView *threeBtnView;
@property (nonatomic, strong)UITableView *homeTableV;
@property (nonatomic, strong)NSMutableArray *imgMutableA;
@property (nonatomic, strong)NSString *user_token;
@property (nonatomic, strong)NSDictionary *data_carDic;
@property (nonatomic, strong)Data_cars *dataCars;
@property (nonatomic, strong)CLLocationManager *locationManager;
@property (nonatomic, copy)NSString *currentCity;

@end

@implementation HomeViewController

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.hidesBottomBarWhenPushed = NO;
    self.navigationController.navigationBar.hidden = YES;
}

- (void)getAndroidHomeDate{
    
    if (![[NSUserDefaults standardUserDefaults] valueForKey:@"isFirst"]) {
        
        userid = @"0";
        [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:@"isFirst"];
    }else{
        
        //userInfo
        _user_token = [UserConfig token];
        if (_user_token.length == 0) {
            
            userid =@"0";
        }else{
            
            userid = [NSString stringWithFormat:@"%@", [UserConfig user_id]];
        }
    }
    
    NSDictionary *androidHomeDic = @{@"userId":userid};
    NSString *adroidHomereqJson = [PublicClass convertToJsonData:androidHomeDic];
  
    [JJRequest postRequest:@"getAndroidHomeDate" params:@{@"reqJson":adroidHomereqJson} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"-1"]) {
            
            [PublicClass showHUD:messageStr view:self.view];
        }else{
            
//            NSLog(@"%@", data);
            _data_carDic = [data objectForKey:@"androidHomeData_cars"];
            NSArray *imgArray = [data objectForKey:@"lunbo_infos"];
            if (_data_carDic == nil || [_data_carDic isKindOfClass:[NSNull class]]) {
                
            }else{
                
                [self setuserDatacarData:_data_carDic];
            }
            [self setImageurlData:imgArray];
            [self setElementOffirstView];
            [self.homeTableV reloadData];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"获取主页信息错误:%@", error);
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
//        NSLog(@"%@", lun_info.contentImageUrl);
        [self.imgMutableA addObject:lun_info.contentImageUrl];
    }
    _sdcycleScrollV.imageURLStringsGroup = self.imgMutableA;
}

- (NSMutableArray *)imgMutableA{
    
    if (_imgMutableA == nil) {
        
        _imgMutableA = [[NSMutableArray alloc] init];
    }
    return _imgMutableA;
}

- (UIScrollView *)mainScrollV{

    if (_mainScrollV == nil) {

        _mainScrollV = [[UIScrollView alloc] init];
        _mainScrollV.frame = CGRectMake(0, -20, MAINSCREEN.width, MAINSCREEN.height - 20);
        _mainScrollV.showsHorizontalScrollIndicator = NO;
        _mainScrollV.showsVerticalScrollIndicator = NO;
        _mainScrollV.bounces = NO;
        _mainScrollV.delegate = self;
        _mainScrollV.tag = 2;
        _mainScrollV.scrollsToTop = NO;
//        if (@available(iOS 11.0, *)) {
//            _mainScrollV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
//        } else {
//            // Fallback on earlier versions
//        }
    }
    return _mainScrollV;
}

- (SDCycleScrollView *)sdcycleScrollV{
    
    if (_sdcycleScrollV == nil) {
        
        _sdcycleScrollV = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, MAINSCREEN.width, 180) delegate:self placeholderImage:nil];
        _sdcycleScrollV.autoScrollTimeInterval = 3.0;
        _sdcycleScrollV.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        [SDCycleScrollView clearImagesCache];
    }
    return _sdcycleScrollV;
}

- (UILabel *)centerLabel{

    if (_centerLabel == nil) {

        _centerLabel = [[UILabel alloc] init];
        _centerLabel.textColor = [UIColor whiteColor];
        _centerLabel.text = @"如驿如意";
        CGSize size = [PublicClass getLabelSize:_centerLabel fontsize:18.0];
        nameW = size.width;
        _centerLabel.frame = CGRectMake((MAINSCREEN.width - nameW)/2, 30, nameW, size.height);
    }
    return _centerLabel;
}

- (UIButton *)locationBtn{
    
    if (_locationBtn == nil) {
        
        _locationBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 27, MAINSCREEN.width/2 - nameW, 25)];
        _locationBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        [_locationBtn setTitle:_currentCity forState:UIControlStateNormal];
        [_locationBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
        [_locationBtn setImage:[UIImage imageNamed:@"定位"] forState:UIControlStateNormal];
        [_locationBtn addTarget:self action:@selector(selectLocationBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _locationBtn;
}

- (void)selectLocationBtn{
    
    LocationViewController *locationVC = [[LocationViewController alloc] init];
    locationVC.current_cityName = self.locationBtn.titleLabel.text;
    [self.navigationController pushViewController:locationVC animated:YES];
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
            carinfoVC.updateViewBlock = ^(NSString *text) {

//                NSLog(@"%@", text);
                [self getAndroidHomeDate];
            };
            [self.navigationController pushViewController:carinfoVC animated:YES];
        }else{
            
            ManageCarViewController *manageCarVC = [[ManageCarViewController alloc] init];
            manageCarVC.updateDefaultBlock = ^(NSString *text) {
                
                [self getAndroidHomeDate];
            };
            [self.navigationController pushViewController:manageCarVC animated:YES];
        }
    }
    NSLog(@"给changeView添加的手势");
}

- (void)updateLoginStatus{
    
    _user_token = [UserConfig token];
    [self getAndroidHomeDate];
}

- (UIView *)changeView{
    
    if (_changeView == nil) {
        
        _changeView = [[UIView alloc] initWithFrame:CGRectMake(10, 168, MAINSCREEN.width-20, 60)];
        _changeView.backgroundColor = [UIColor clearColor];
        _changeView.layer.cornerRadius = 8.0;
        _changeView.layer.masksToBounds = YES;
        UIImageView *backImageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width - 20, 60)];
        backImageview.image = [UIImage imageNamed:@"注册框"];
        [_changeView addSubview:backImageview];
        [_changeView addGestureRecognizer:self.fTapGR];
        [_changeView addSubview:self.firstView];
    }
    return _changeView;
}

- (HomeFirstView *)firstView{
    
    if (_firstView == nil) {
        
        _firstView = [[HomeFirstView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width-20, 80)];
        _firstView.backgroundColor = [UIColor clearColor];
        _firstView.layer.cornerRadius = 8.0;
        _firstView.layer.masksToBounds = YES;
    }
    return _firstView;
}

- (void)setElementOffirstView{
    
    if (_user_token == 0) {
        
        _firstView.iconImageV.image = [UIImage imageNamed:@"注册"];
        _firstView.topLabel.text = @"新人注册享好礼";
        _firstView.bottomLabel.text = @"注册享受价值xx元礼包";
    }else{
        
        if ([_data_carDic isKindOfClass:[NSNull class]] || _data_carDic == nil) {
            
            _firstView.iconImageV.image = [UIImage imageNamed:@"添加"];
            _firstView.topLabel.text = @"添加我的宝驹";
            _firstView.bottomLabel.text = @"邀请好友绑定车辆可免费洗车";
        }else{
            
            [_firstView.iconImageV sd_setImageWithURL:[NSURL URLWithString:self.dataCars.car_brand_url]];
            _firstView.topLabel.text = self.dataCars.car_verhicle;
            _firstView.bottomLabel.text = @"一次性购买四条轮胎送洗车卷";
        }
    }
}

- (UIView *)threeBtnView{
    
    if (_threeBtnView == nil) {
        
        tviewX = 0.0;
        tviewY = MAINSCREEN.width/4 + 240 + 15 + 20;
        tviewW = MAINSCREEN.width;
        tviewH = MAINSCREEN.width/4 + 15 + 60;
        _threeBtnView = [[UIView alloc] initWithFrame:CGRectMake(tviewX, tviewY, tviewW, tviewH)];
        _threeBtnView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
    }
    return _threeBtnView;
}

- (UITableView *)homeTableV{
    
    if (_homeTableV == nil) {
        
        _homeTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, tviewY + tviewH + 2, MAINSCREEN.width, 80) style:UITableViewStylePlain];
        _homeTableV.dataSource = self;
        _homeTableV.delegate = self;
        _homeTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _homeTableV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _currentCity = @"定位中";
    DelegateConfiguration *delegateCF = [DelegateConfiguration sharedConfiguration];
    [delegateCF registercityNameListers:self];
    [delegateCF registerLoginStatusChangedListener:self];
    [self locateMap];
    self.navigationController.delegate = self;
    //消除iOS7自带侧翻的效果
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mainScrollV];
    [_mainScrollV addSubview:self.sdcycleScrollV];
    [_sdcycleScrollV addSubview:self.centerLabel];
    [_sdcycleScrollV addSubview:self.locationBtn];
    [_mainScrollV addSubview:self.changeView];
    [_mainScrollV addSubview:self.threeBtnView];
    [self addFourButtons];
    [self addThreeButtons];
    [_mainScrollV addSubview:self.homeTableV];
    [_mainScrollV setContentSize:CGSizeMake(MAINSCREEN.width, (tviewY+tviewH+82))];
    [self getAndroidHomeDate];
    // Do any additional setup after loading the view.
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

- (void)addFourButtons{
    
    NSArray *nameArray = @[@"轮胎购买", @"免费更换", @"免费修补", @"商品分类"];
    NSArray *imgArray = @[@"轮胎购买", @"免费更换", @"免费修补", @"ic_icon4"];
    for (int i = 0; i<4; i++) {
        
        CGFloat btnW = MAINSCREEN.width/4;
        CGFloat btnH = btnW + 15;
        CGFloat btnX = i*btnW;
        CGFloat btnY = 240;
        UIButton *midBtn = [[UIButton alloc] initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
        midBtn.tag = 1000+i;
        [midBtn setTitle:[nameArray objectAtIndex:i] forState:UIControlStateNormal];
        [midBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        midBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        midBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [midBtn setImage:[UIImage imageNamed:[imgArray objectAtIndex:i]] forState:UIControlStateNormal];
        midBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        midBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [midBtn setImageEdgeInsets:UIEdgeInsetsMake(-20, 8, 0, 0)];
        [midBtn setTitleEdgeInsets:UIEdgeInsetsMake(midBtn.frame.size.height, -btnW + 12, 25, 0)];
        [midBtn addTarget:self action:@selector(chickMidBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_mainScrollV addSubview:midBtn];
    }
}

- (void)addThreeButtons{
    
    NSArray *threeNameArray = @[@"畅行无忧", @"汽车保养", @"美容清洗"];
    for (int t = 0; t<3; t++) {
        
        UIButton *button = [[UIButton alloc] init];
        button.tag = 2000+t;
        [button setImage:[UIImage imageNamed:[threeNameArray objectAtIndex:t]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(chickMidBtn:) forControlEvents:UIControlEventTouchUpInside];
        if (t == 0) {
            
            button.frame = CGRectMake(0, 1, tviewW/3, tviewH-2);
        }else if (t == 1){
            
            button.frame = CGRectMake(tviewW/3, 1, tviewW*2/3, tviewH/2-2.0);
        }else{
            
            button.frame = CGRectMake(tviewW/3, tviewH/2, tviewW*2/3, tviewH/2-1);
        }
        [_threeBtnView addSubview:button];
    }
}

- (void)chickMidBtn:(UIButton *)btn{
    
    //1000轮胎购买，1001免费更换，1002免费修补，1003商品分类
    //2000畅行无忧，2001汽车保养，2002美容清洗
    if ([UserConfig user_id] == NULL) {
        
        [self alertIsloginView];
    }else{
        
        if (btn.tag == 1000) {
            
            [self chickBuytyreBtn:btn];
        }else if (btn.tag == 1001){
            
            
        }else if (btn.tag == 1002){
            
            
        }else if (btn.tag == 1003){
            
            self.tabBarController.selectedIndex = 2;
        }else if (btn.tag == 2000){
            
            PassImpededViewController *passImpededVC = [[PassImpededViewController alloc] init];
            [self.navigationController pushViewController:passImpededVC animated:YES];
        }else{
            
            NearbyViewController *nearbyVC = [[NearbyViewController alloc] init];
            nearbyVC.status = @"0";
            nearbyVC.isLocation = @"1";
            if (btn.tag == 2001) {
                
                nearbyVC.serviceType = @"2";
                nearbyVC.condition = @"汽车保养";
            }else{
                
                nearbyVC.serviceType = @"3";
                nearbyVC.condition = @"美容清洗";
            }
            [self.navigationController pushViewController:nearbyVC animated:YES];
        }
    }
}

- (void)chickBuytyreBtn:(UIButton *)btn{
    
    if ([self.dataCars.font isEqualToString:self.dataCars.rear]) {
        
        ChoicePatternViewController *choicePVC = [[ChoicePatternViewController alloc] init];
        choicePVC.tireSize = self.dataCars.font;
        choicePVC.fontRearFlag = @"0";
        [self.navigationController pushViewController:choicePVC animated:YES];
    }else{
        
        SelectTirePositionViewController *selectTPVC = [[SelectTirePositionViewController alloc] init];
        selectTPVC.dataCars = self.dataCars;
        [self.navigationController pushViewController:selectTPVC animated:YES];
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
            _currentCity = placeMark.locality;
            if (!_currentCity) {
                
                _currentCity = @"无法定位当前城市";
            }
            [[NSUserDefaults standardUserDefaults] setObject:_currentCity forKey:@"currentCity"];
            [self.locationBtn setTitle:_currentCity forState:UIControlStateNormal];
        }else if (error == nil && placemarks.count){
            
            NSLog(@"NO location and error return");
        }else if (error){
            
            NSLog(@"location error:%@", error);
        }
    }];
}

#pragma mark CityNameDelegate
- (void)updateCityName:(NSString *)cityNameStr{
    
    [[NSUserDefaults standardUserDefaults] setObject:cityNameStr forKey:@"currentCity"];
    [self.locationBtn setTitle:cityNameStr forState:UIControlStateNormal];
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

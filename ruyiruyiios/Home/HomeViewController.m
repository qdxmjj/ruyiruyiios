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
//#import "PassImpededViewController.h"
#import "SmoothJourneyViewController.h"
#import "NearbyViewController.h"
#import "TireRepairViewController.h"
#import "FreeChangeViewController.h"

#import "CycleScrollViewDetailsController.h"
#import "TobeReplacedTiresViewController.h"
#import "NewTirePurchaseViewController.h"
#import "MyWebViewController.h"

#import "FirstStartConfiguration.h"
#import "MBProgressHUD+YYM_category.h"
@interface HomeViewController ()<UIScrollViewDelegate, SDCycleScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, LoginStatusDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate,LoginStatusDelegate, CityNameDelegate,UpdateAddCarDelegate>{
    
    CGFloat nameW;
    CGFloat tviewX, tviewY, tviewW, tviewH;
    NSString *userid;
}
@property (nonatomic, strong)UIScrollView *mainScrollV;
@property (nonatomic, strong)SDCycleScrollView *sdcycleScrollV;//上部轮播
@property (nonatomic, strong)SDCycleScrollView *webAdvertisingView;//底部广告轮播
@property (nonatomic, strong)UILabel *centerLabel;//title
@property (nonatomic, strong)UIButton *locationBtn;
@property (nonatomic, strong)UIButton *resetBtn;//重置btn
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

@property (nonatomic, strong)NSMutableArray *AdvertisingImgURLArr;//底部广告图片数组
@property (nonatomic, strong)NSMutableArray *AdvertisingWebURLArr;//底部广告URL数组

@end

@implementation HomeViewController

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {

    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];

    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.hidesBottomBarWhenPushed = NO;
    self.tabBarController.tabBar.hidden = NO;
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
            
            [PublicClass showHUD:messageStr view:self.view];
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
//            [self.homeTableV reloadData];
            
            NSArray *arr = [data objectForKey:@"activityList"];
            
            if (self.AdvertisingImgURLArr.count>0) {
                
                [self.AdvertisingImgURLArr removeAllObjects];
            }
            if (self.AdvertisingWebURLArr.count>0) {
                [self.AdvertisingWebURLArr removeAllObjects];
            }
            
            for (NSDictionary *dic in arr) {
                
                [self.AdvertisingImgURLArr addObject:[dic objectForKey:@"imageUrl"]];
                [self.AdvertisingWebURLArr addObject:[dic objectForKey:@"webUrl"]];
            }
            
            NSLog(@"%@",self.AdvertisingWebURLArr);
            if (self.AdvertisingWebURLArr.count<=0) {
                self.webAdvertisingView.imageURLStringsGroup = nil;
            }else{
                self.webAdvertisingView.imageURLStringsGroup = self.AdvertisingImgURLArr;
            }
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
    _sdcycleScrollV.imageURLStringsGroup = self.imgMutableA;
}

- (NSMutableArray *)imgMutableA{
    
    if (_imgMutableA == nil) {
        
        _imgMutableA = [[NSMutableArray alloc] init];
    }
    return _imgMutableA;
}

-(NSMutableArray *)AdvertisingImgURLArr{
    
    if (!_AdvertisingImgURLArr) {
        
        _AdvertisingImgURLArr = [NSMutableArray array];
    }
    return _AdvertisingImgURLArr;
}

-(NSMutableArray *)AdvertisingWebURLArr{
    
    if (!_AdvertisingWebURLArr) {
        
        _AdvertisingWebURLArr = [NSMutableArray array];
    }
    return _AdvertisingWebURLArr;
}

- (UIScrollView *)mainScrollV{

    if (_mainScrollV == nil) {

        _mainScrollV = [[UIScrollView alloc] init];
        _mainScrollV.frame = CGRectMake(0, (SafeAreaTopHeight - 64)+20, MAINSCREEN.width, MAINSCREEN.height - 20 - (SafeAreaTopHeight - 64) - Height_TabBar);
        _mainScrollV.backgroundColor = [UIColor clearColor];
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
        _sdcycleScrollV.backgroundColor = [UIColor whiteColor];
        [SDCycleScrollView clearImagesCache];
    }
    return _sdcycleScrollV;
}

-(SDCycleScrollView *)webAdvertisingView{
    
    if (!_webAdvertisingView) {
        
        _webAdvertisingView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, tviewY + tviewH + 2, MAINSCREEN.width, 120) delegate:self placeholderImage:nil];
        _webAdvertisingView.autoScrollTimeInterval = 3.0;
        _webAdvertisingView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _webAdvertisingView.backgroundColor = [UIColor whiteColor];
        [SDCycleScrollView clearImagesCache];
    }
    return _webAdvertisingView;
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

- (UIButton *)resetBtn{
    
    if (_resetBtn == nil) {
        
        _resetBtn = [[UIButton alloc] initWithFrame:CGRectMake( MAINSCREEN.width-40-16, 27, 40 , 30)];
        [_resetBtn setImage:[UIImage imageNamed:@"ic_shuaxin"] forState:UIControlStateNormal];
        [_resetBtn addTarget:self action:@selector(resetHomeInfoWithCarInfo) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetBtn;
}

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
    
    if (_user_token == 0 || [[NSString stringWithFormat:@"%@", [UserConfig user_id]] isEqualToString:@""]) {
        
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
            _firstView.bottomLabel.text = @"一次性购买四条轮胎送洗车券";
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
        _homeTableV.bounces = NO;
    }
    return _homeTableV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _currentCity = @"定位中";
    
    //去掉了 添加车辆代理方法 修改默认车辆代理方法  剩下一个 修改默认城市代理方法  日后再改
    DelegateConfiguration *delegateCF = [DelegateConfiguration sharedConfiguration];
    [delegateCF registercityNameListers:self];
    [delegateCF registerLoginStatusChangedListener:self];
    [delegateCF registeraddCarListers:self];
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20+(SafeAreaTopHeight - 64))];
    statusBarView.backgroundColor = LOGINBACKCOLOR;
    
    [self locateMap];
    self.navigationController.delegate = self;

    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:statusBarView];
    [self.view addSubview:self.mainScrollV];
    [_mainScrollV addSubview:self.sdcycleScrollV];
    [_sdcycleScrollV addSubview:self.centerLabel];
    [_sdcycleScrollV addSubview:self.locationBtn];
    [_sdcycleScrollV addSubview:self.resetBtn];
    [_mainScrollV addSubview:self.changeView];
    [_mainScrollV addSubview:self.threeBtnView];
    [self addFourButtons];
    [self addThreeButtons];
//    [_mainScrollV addSubview:self.homeTableV];
    [_mainScrollV addSubview:self.webAdvertisingView];
    [_mainScrollV setContentSize:CGSizeMake(MAINSCREEN.width, (tviewY+tviewH+82))];
    
//    [self getAndroidHomeDate];  //定位成功后再请求主页数据 因为 新接口需要传入位置信息

    //生成购买轮胎订单的时候 的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(generateTireOrderNoticeEvent) name:GenerateTireOrderNotice object:nil];
    //设置默认车辆的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(generateTireOrderNoticeEvent) name:ModifyDefaultCarNotification object:nil];
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
    
    NSArray *nameArray = @[@"轮胎购买", @"免费更换", @"免费修补", @"待更换轮胎"];
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
        [midBtn setTitleEdgeInsets:UIEdgeInsetsMake(midBtn.frame.size.height, -btnW + btnW*0.30, 25, 0)];
        [midBtn addTarget:self action:@selector(chickMidBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_mainScrollV addSubview:midBtn];
    }
}

- (void)addThreeButtons{
    
    NSArray *threeNameArray = @[@"畅行无忧", @"汽车保养", @"美容清洗"];
    for (int t = 0; t<threeNameArray.count; t++) {
        
        UIButton *button = [[UIButton alloc] init];
        button.tag = 2000+t;
        [button setBackgroundImage:[UIImage imageNamed:[threeNameArray objectAtIndex:t]] forState:UIControlStateNormal];
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
    
    //1000轮胎购买，1001免费更换，1002免费修补，1003待更换轮胎
    //2000畅行无忧，2001汽车保养，2002美容清洗
    if ([UserConfig user_id] == NULL) {
        
        [self alertIsloginView];
    }else{
        
        if (btn.tag == 1000) {
            
            [self chickBuytyreBtn:btn];
        }else if (btn.tag == 1001){
            
            FreeChangeViewController *tireRepairVC = [[FreeChangeViewController alloc] init];
            [self.navigationController pushViewController:tireRepairVC animated:YES];
            
        }else if (btn.tag == 1002){
            
            TireRepairViewController *tireRepairVC = [[TireRepairViewController alloc] init];
            [self.navigationController pushViewController:tireRepairVC animated:YES];
        }else if (btn.tag == 1003){
            
//            self.tabBarController.selectedIndex = 2;
            //待更换轮胎
            TobeReplacedTiresViewController *tobeReplacedVC = [[TobeReplacedTiresViewController alloc] init];
            [self.navigationController pushViewController:tobeReplacedVC animated:YES];
            
        }else if (btn.tag == 2000){
            
            SmoothJourneyViewController *SmoothJourneyVC = [[SmoothJourneyViewController alloc] init];
            [self.navigationController pushViewController:SmoothJourneyVC animated:YES];
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
    
//    NSLog(@"点击了第%ld张图片",(long)index);
    if ([cycleScrollView isEqual:self.webAdvertisingView]) {
        
        if (self.AdvertisingWebURLArr.count <= 0) {
            
            return;
        }
        MyWebViewController *myWebVC = [[MyWebViewController alloc] init];
        myWebVC.url = [NSString stringWithFormat:@"%@?userId=%@&userCarId=%@",self.AdvertisingWebURLArr[index],[UserConfig user_id],[UserConfig userCarId]];
        [self.navigationController pushViewController:myWebVC animated:YES];
    }else{
        
        if (index == 2) {
            
            if ([UserConfig user_id] == NULL) {
                
                [self alertIsloginView];
            }else{
                
                [self chickBuytyreBtn:[UIButton new]];
            }
        }else{
            
            CycleScrollViewDetailsController *cycleViewDetails = [[CycleScrollViewDetailsController alloc] init];
            cycleViewDetails.index = index;
            cycleViewDetails.tireSize = self.dataCars.font;
            cycleViewDetails.dataCars = self.dataCars;
            [self.navigationController pushViewController:cycleViewDetails animated:YES];
        }
    }
}

#pragma mark 跳转轮胎购买页面事件
- (void)chickBuytyreBtn:(UIButton *)btn{
    

    
    if ([self.dataCars isEqual:[NSNull null]] || self.dataCars == nil || !self.dataCars || [UserConfig userCarId].intValue == 0) {

//        [PublicClass showHUD:@"轮胎信息获取失败！" view:self.view];
        
        CarInfoViewController *carinfoVC = [[CarInfoViewController alloc] init];
        carinfoVC.is_alter = YES;
        [self.navigationController pushViewController:carinfoVC animated:YES];
        
        return;
    }

    
    //    if ([self.dataCars.service_end_date isEqualToString:@""]) {
//
//        NSLog(@"进入选择年限界面");
//
//        YearSelectViewController *yearsVC = [[YearSelectViewController alloc] init];
//
//        yearsVC.maximumYears = [NSString stringWithFormat:@"%@",self.dataCars.service_year];
//        yearsVC.data_cars = self.dataCars;
//        [self.navigationController pushViewController:yearsVC animated:YES];
//
//        return;
//    }
//
    
    //前后轮一致 直接进入轮胎购买页面 不一致先进入选择前后轮界面 再进入轮胎购买
    if ([self.dataCars.font isEqualToString:self.dataCars.rear]) {

//        ChoicePatternViewController *choicePVC = [[ChoicePatternViewController alloc] init];
//        choicePVC.tireSize = self.dataCars.font;
//        choicePVC.fontRearFlag = @"0";
//        [self.navigationController pushViewController:choicePVC animated:YES];
        
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
            NSString *currentStr = placeMark.locality;//2018.10.24 改为默认显示县 之前默认为市
            if (!_currentCity) {
                
                _currentCity = @"无法定位当前城市";
            }
            [[NSUserDefaults standardUserDefaults] setObject:_currentCity forKey:@"currentCity"];//存储 当前定位的信息 县
            [[NSUserDefaults standardUserDefaults] setObject:_currentCity forKey:@"positionCounty"];//存储 当前定位的信息 县
            [UserConfig userDefaultsSetObject:currentStr key:@"selectCityName"];//初始化 默认选择的城市
            [self.locationBtn setTitle:_currentCity forState:UIControlStateNormal];
            
            [self getAndroidHomeDate];//定位成功后请求主页数据  定位结果返回会执行多次  重复网络请求 不合理 暂未处理
            
        }else if (error == nil && placemarks.count){
            
            NSLog(@"NO location and error return");
        }else if (error){
            
            NSLog(@"location error:%@", error);
        }
    }];
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

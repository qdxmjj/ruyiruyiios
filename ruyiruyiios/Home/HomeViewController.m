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
#import "MyCarInfoViewController.h"

#import "ManageCarViewController.h"
#import "LocationViewController.h"
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

#import "SignInObject.h"

#import "EntranceView.h"
#import "MBProgressHUD+YYM_category.h"
#import "ADView.h"
#import "HomeActivityModel.h"
#import "ActivityCell.h"
#import <UIButton+WebCache.h>
#import "StoreDetailsRequest.h"
#import "CommdoityDetailsViewController.h"
#import "YMDetailedServiceViewController.h"

#import "MyInterestsViewController.h"

static CGFloat const cellOneHeigh = 90;
static CGFloat const cellTwoHeigh = 100;
static CGFloat const cellThreeHeigh = 130;

@interface HomeViewController ()<UIScrollViewDelegate, SDCycleScrollViewDelegate, UITableViewDelegate, UITableViewDataSource,LoginStatusDelegate,LoginStatusDelegate, CityNameDelegate,UpdateAddCarDelegate,ADActivityDelegate,EntranceViewDelegate>{
    
    CGFloat nameW;
    CGFloat tviewX, tviewY, tviewW, tviewH;
    NSString *userid;
}
@property (nonatomic, strong)UIScrollView *mainScrollV;
@property (nonatomic, strong)SDCycleScrollView *sdcycleScrollV;//上部轮播

@property (nonatomic, strong)UIButton *locationBtn; //位置button
@property (nonatomic, strong)UIButton *resetBtn;//重置btn
@property (nonatomic, strong)UIView *changeView; //登录状态 车辆状态 显示视图
@property (nonatomic, strong)UITapGestureRecognizer *fTapGR;// changeView 点击手势
@property (nonatomic, strong)HomeFirstView *firstView; //changeView子视图
@property (nonatomic, strong)EntranceView *entranceView; //导引入口视图 四个大按钮
@property (nonatomic, strong)UITableView *activityTableView;//底部广告视图

@property (nonatomic, strong)NSMutableArray *imgMutableA;
@property (nonatomic, strong)NSString *user_token;
@property (nonatomic, strong)NSDictionary *data_carDic;
@property (nonatomic, strong)Data_cars *dataCars;

@property (nonatomic, strong)NSMutableArray *activityArr;//底部广告数组
@property (nonatomic, assign)CGFloat tableViewHeigh;//tableview高度
@property (nonatomic, assign)NSString *homeShareURL; //分享用URL
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![[NSUserDefaults standardUserDefaults] valueForKey:@"isFirst"]) {
        
        WelcomeViewController *welcomeVC = [[WelcomeViewController alloc] init];
        [self.navigationController presentViewController:[[BaseNavigation alloc]initWithRootViewController:welcomeVC] animated:YES completion:nil];
    }
    ///使用代码 约束布局 需要设置为NO
    self.mainScrollV.translatesAutoresizingMaskIntoConstraints = NO;

    self.view.backgroundColor = [UIColor whiteColor];
    
    //开始签到并显示
    [SignInObject startSignInAndshowView:self.view];
        
    DelegateConfiguration *delegateCF = [DelegateConfiguration sharedConfiguration];
    [delegateCF registercityNameListers:self];
    [delegateCF registerLoginStatusChangedListener:self];
    [delegateCF registeraddCarListers:self];
    
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
    [self.mainScrollV addSubview:self.activityTableView];

    [self.mainScrollV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.activityTableView.mas_bottom);
    }];
    
//    [self.view layoutIfNeeded];
    
    [self.sdcycleScrollV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.mainScrollV.mas_top);
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
        make.left.right.mas_equalTo(self.view).inset(16);
        make.height.mas_equalTo(self.sdcycleScrollV.mas_height).multipliedBy(0.3);
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
        make.height.mas_equalTo((MAINSCREEN.width-50)/4 * 1.1);
    }];
    
    [self.activityTableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.entranceView.mas_bottom).inset(5);
        make.height.mas_equalTo(10);
    }];
    
    //获取弹窗广告
    [self getActivityInfo];
    //获取主页信息
    [self getAndroidHomeDate];
    
    //生成购买轮胎订单的时候 的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(generateTireOrderNoticeEvent) name:GenerateTireOrderNotice object:nil];
    //设置默认车辆的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(generateTireOrderNoticeEvent) name:ModifyDefaultCarNotification object:nil];

    self.mainScrollV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        [self getAndroidHomeDate];
    }];
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
    
    NSString *currentCity = [UserConfig currentCity];
    
    [self.locationBtn setTitle:currentCity forState:UIControlStateNormal];

    if (currentCity.length<=0) {
        
         currentCity = @"定位失败";
    }
    
    NSDictionary *androidHomeDic = @{@"userId":userid,@"position":currentCity};
    NSString *adroidHomereqJson = [PublicClass convertToJsonData:androidHomeDic];
    [MBProgressHUD showWaitMessage:@"正在获取首页数据.." showView:self.view];
    
    [JJRequest postRequest:@"getAndroidHomeDate" params:@{@"reqJson":adroidHomereqJson} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        [MBProgressHUD hideWaitViewAnimated:self.view];
        
        [self.mainScrollV.mj_header endRefreshing];

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
                
                ///数据model
                [self setuserDatacarData:self.data_carDic];
            }
            
            [self setImageurlData:imgArray];
            [self setElementOffirstView];
            
            self.tableViewHeigh = 0.f;
            
            self.activityArr = [data objectForKey:@"activityList"];
            
            dispatch_async(dispatch_queue_create("homeADViewQueue", NULL), ^{
                
                //遍历重新处理 底部广告页面数据
                NSMutableArray *newArr = [NSMutableArray array];
                
                for (int i = 0; i<self.activityArr.count; i++) {
                    
                    NSInteger type = [self.activityArr[i][@"type"] integerValue];
                    
                    if (type == 0) {
                        
                        [newArr addObject:[self oneDicWith:self.activityArr[i] type:type]];
                        self.tableViewHeigh += 45;
                    }else if (type == 1) {
                        
                        [newArr addObject:[self oneDicWith:self.activityArr[i] type:type]];
                        self.tableViewHeigh += cellOneHeigh+2.01;
                    }else if (type == 2){
                        
                        [newArr addObject:[self twoDicWith:self.activityArr[i] two:self.activityArr[i+1]]];
                        i += 1;
                        self.tableViewHeigh += cellTwoHeigh+2.01;
                    }else if (type == 3){
                        
                        [newArr addObject:[self threeDicWith:self.activityArr[i] three:self.activityArr[i+1] three:self.activityArr[i+2]]];
                        self.tableViewHeigh += cellThreeHeigh;
                        i += 2;
                    }else{
                    }
                }
                
                NSDictionary *dic = @{@"content":@[@"此条必须放到最上层"],
                                      @"id":@[],
                                      @"imageUrl":@[@"http://180.76.243.205:8111/images-new/activity/activity/ic_quanyi.png"],
                                      @"positionIdList":@[],
                                      @"positionNameList":@[],
                                      @"serviceId":@[],
                                      @"skip":@[@"4"],
                                      @"storeIdList":@[],
                                      @"type":@[],
                                      @"webUrl":@[],
                                      @"stockId":@[],
                                      @"setType":@"1"
                                      };
                
                [newArr insertObject:dic atIndex:0];
                
                self.activityArr = newArr;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                   
                    //更新tableview 高度
                    [self.activityTableView mas_updateConstraints:^(MASConstraintMaker *make) {
                        
                        make.height.mas_equalTo(self.tableViewHeigh);
                    }];
                    [self.activityTableView reloadData];
                });
            });
        }
        
    } failure:^(NSError * _Nullable error) {
        
//        NSLog(@"获取主页信息错误:%@", error);
        [MBProgressHUD hideWaitViewAnimated:self.view];

        [self.mainScrollV.mj_header endRefreshing];
    }];
}

#pragma mark 数据二次处理--底部广告页面数据
//随时可能废弃此功能
-(NSMutableDictionary *)oneDicWith:(NSDictionary *)dic1 type:(NSInteger )type{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setObject:@[[dic1 objectForKey:@"content"]] forKey:@"content"];
    [dic setObject:@[[dic1 objectForKey:@"id"]] forKey:@"id"];
    [dic setObject:@[[dic1 objectForKey:@"imageUrl"]] forKey:@"imageUrl"];
    [dic setObject:@[[dic1 objectForKey:@"positionIdList"]] forKey:@"positionIdList"];
    [dic setObject:@[[dic1 objectForKey:@"positionNameList"]] forKey:@"positionNameList"];
    [dic setObject:@[[dic1 objectForKey:@"serviceId"]] forKey:@"serviceId"];
    [dic setObject:@[[dic1 objectForKey:@"skip"]] forKey:@"skip"];
    [dic setObject:@[[dic1 objectForKey:@"storeIdList"]] forKey:@"storeIdList"];
    [dic setObject:@[[dic1 objectForKey:@"type"]] forKey:@"type"];
    [dic setObject:@[[dic1 objectForKey:@"webUrl"]] forKey:@"webUrl"];
    [dic setObject:@[[dic1 objectForKey:@"stockId"]] forKey:@"stockId"];

    [dic setObject:[NSString stringWithFormat:@"%ld",(long)type] forKey:@"setType"];

    return dic;
}

-(NSMutableDictionary *)twoDicWith:(NSDictionary *)dic1 two:(NSDictionary *)dic2{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setObject:@[[dic1 objectForKey:@"content"],[dic2 objectForKey:@"content"]] forKey:@"content"];
    [dic setObject:@[[dic1 objectForKey:@"id"],[dic2 objectForKey:@"id"]] forKey:@"id"];
    [dic setObject:@[[dic1 objectForKey:@"imageUrl"],[dic2 objectForKey:@"imageUrl"]] forKey:@"imageUrl"];
    [dic setObject:@[[dic1 objectForKey:@"positionIdList"],[dic2 objectForKey:@"positionIdList"]] forKey:@"positionIdList"];
    [dic setObject:@[[dic1 objectForKey:@"positionNameList"],[dic2 objectForKey:@"positionNameList"]] forKey:@"positionNameList"];
    [dic setObject:@[[dic1 objectForKey:@"serviceId"],[dic2 objectForKey:@"serviceId"]] forKey:@"serviceId"];
    [dic setObject:@[[dic1 objectForKey:@"skip"],[dic2 objectForKey:@"skip"]] forKey:@"skip"];
    [dic setObject:@[[dic1 objectForKey:@"storeIdList"],[dic2 objectForKey:@"storeIdList"]] forKey:@"storeIdList"];
    [dic setObject:@[[dic1 objectForKey:@"type"],[dic2 objectForKey:@"type"]] forKey:@"type"];
    [dic setObject:@[[dic1 objectForKey:@"webUrl"],[dic2 objectForKey:@"webUrl"]] forKey:@"webUrl"];
    [dic setObject:@[[dic1 objectForKey:@"stockId"],[dic2 objectForKey:@"stockId"]] forKey:@"stockId"];

    [dic setObject:@"2" forKey:@"setType"];

    return dic;
}

-(NSMutableDictionary *)threeDicWith:(NSDictionary *)dic1 three:(NSDictionary *)dic2 three:(NSDictionary *)dic3{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setObject:@[[dic1 objectForKey:@"content"],[dic2 objectForKey:@"content"],[dic3 objectForKey:@"content"]] forKey:@"content"];
    
    [dic setObject:@[[dic1 objectForKey:@"id"],[dic2 objectForKey:@"id"],[dic3 objectForKey:@"id"]] forKey:@"id"];
    
    [dic setObject:@[[dic1 objectForKey:@"imageUrl"],[dic2 objectForKey:@"imageUrl"],[dic3 objectForKey:@"imageUrl"]] forKey:@"imageUrl"];
    
    [dic setObject:@[[dic1 objectForKey:@"positionIdList"],[dic2 objectForKey:@"positionIdList"],[dic3 objectForKey:@"positionIdList"]] forKey:@"positionIdList"];
    
    [dic setObject:@[[dic1 objectForKey:@"positionNameList"],[dic2 objectForKey:@"positionNameList"],[dic3 objectForKey:@"positionNameList"]] forKey:@"positionNameList"];
    
    [dic setObject:@[[dic1 objectForKey:@"serviceId"],[dic2 objectForKey:@"serviceId"],[dic3 objectForKey:@"serviceId"]] forKey:@"serviceId"];
    
    [dic setObject:@[[dic1 objectForKey:@"skip"],[dic2 objectForKey:@"skip"],[dic3 objectForKey:@"skip"]] forKey:@"skip"];
    
    [dic setObject:@[[dic1 objectForKey:@"storeIdList"],[dic2 objectForKey:@"storeIdList"],[dic3 objectForKey:@"storeIdList"]] forKey:@"storeIdList"];
    
    [dic setObject:@[[dic1 objectForKey:@"type"],[dic2 objectForKey:@"type"],[dic3 objectForKey:@"type"]] forKey:@"type"];
    
    [dic setObject:@[[dic1 objectForKey:@"webUrl"],[dic2 objectForKey:@"webUrl"],[dic3 objectForKey:@"webUrl"]] forKey:@"webUrl"];
    
    [dic setObject:@[[dic1 objectForKey:@"stockId"],[dic2 objectForKey:@"stockId"],[dic3 objectForKey:@"stockId"]] forKey:@"stockId"];

    [dic setObject:@"3" forKey:@"setType"];

    return dic;
}

- (void)setuserDatacarData:(NSDictionary *)carDic{
    
    if (carDic.count != 0) {
        
        Data_cars *data_car = [[Data_cars alloc] init];
        [data_car setValuesForKeysWithDictionary:carDic];
        self.dataCars = data_car;
        
        ///存储当前的默认车辆id
        [UserConfig userDefaultsSetObject:data_car.user_car_id key:@"userCarId"];
        //存储当前默认车辆的认证状态
        [UserConfig userDefaultsSetObject:data_car.authenticatedState key:@"kAuthenticatedState"];
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
//    dispatch_async(dispatch_get_main_queue(), ^{
        _sdcycleScrollV.imageURLStringsGroup = self.imgMutableA;
//    });
}
#pragma mark 获取广告信息
-(void)getActivityInfo{
    
    [JJRequest postRequest:@"getAppActivity" params:nil success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
       
//        NSLog(@"主页广告弹窗：%@ %@ %@",code,message,data);
        
        if ([code integerValue] == 1) {
            
            if ([data count]>0) {
                ADView *adView = [[ADView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height)];
                adView.delegate = self;
                [adView setActivityInfo:data];
                [adView show:self.view];
            }
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
#pragma mark 城市选择点击事件
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
            
            MyCarInfoViewController *carinfoVC = [[MyCarInfoViewController alloc] init];
            carinfoVC.is_alter = YES;
            [self.navigationController pushViewController:carinfoVC animated:YES];
        }else{
            
            ManageCarViewController *manageCarVC = [[ManageCarViewController alloc] init];
            [self.navigationController pushViewController:manageCarVC animated:YES];
        }
    }
//    NSLog(@"给changeView添加的手势");
}


#pragma mark - TableViewDelegate  广告页面数据处理
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NSInteger type = [self.activityArr[indexPath.section][@"setType"] integerValue];
    
    NSString *identifier = @"";//对应xib中设置的identifier
    NSInteger index = 0; //xib中第几个Cell
    switch (type) {
        case 0:
            identifier = @"ActivityCellFourID";
            index = 3;
            break;
        case 1:
            identifier = @"ActivityCellOneID";
            index = 0;
            break;
        case 2:
            identifier = @"ActivityCellTwoID";
            index = 1;
            break;
        default:
            
            identifier = @"ActivityCellThreeID";
            index = 2;
            
            break;
    }
    
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ActivityCell" owner:self options:nil] objectAtIndex:index];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    switch (type) {
        case 0:{
            
            NSArray *urlArr  = self.activityArr[indexPath.section][@"imageUrl"];

            [cell.titleImageView sd_setImageWithURL:urlArr[0]];
        }
            break;
        case 1:{
         
            NSArray *urlArr  = self.activityArr[indexPath.section][@"imageUrl"];
            [cell.OneBtn1 sd_setImageWithURL:urlArr[0] forState:UIControlStateNormal];
            [cell.OneBtn1 addTarget:self action:@selector(pushActivityDetailsView:) forControlEvents:UIControlEventTouchUpInside];
            cell.OneBtn1.tag = indexPath.section + 1000;
        }
            break;
        case 2:{
            
            NSArray *urlArr  = self.activityArr[indexPath.section][@"imageUrl"];
            [cell.TwoBtn1 sd_setImageWithURL:urlArr[0] forState:UIControlStateNormal];
            [cell.TwoBtn2 sd_setImageWithURL:urlArr[1] forState:UIControlStateNormal];
            [cell.TwoBtn1 addTarget:self action:@selector(pushActivityDetailsView:) forControlEvents:UIControlEventTouchUpInside];
            [cell.TwoBtn2 addTarget:self action:@selector(pushActivityDetailsView:) forControlEvents:UIControlEventTouchUpInside];

            cell.TwoBtn1.tag = indexPath.section + 1001;
            cell.TwoBtn2.tag = indexPath.section + 1002;

        }
            break;
        case 3:{
            
            NSArray *urlArr  = self.activityArr[indexPath.section][@"imageUrl"];
            [cell.ThreeBtn1 sd_setImageWithURL:urlArr[0] forState:UIControlStateNormal];
            [cell.ThreeBtn2 sd_setImageWithURL:urlArr[1] forState:UIControlStateNormal];
            [cell.ThreeBtn3 sd_setImageWithURL:urlArr[2] forState:UIControlStateNormal];
            
            [cell.ThreeBtn1 addTarget:self action:@selector(pushActivityDetailsView:) forControlEvents:UIControlEventTouchUpInside];
            [cell.ThreeBtn2 addTarget:self action:@selector(pushActivityDetailsView:) forControlEvents:UIControlEventTouchUpInside];
            [cell.ThreeBtn3 addTarget:self action:@selector(pushActivityDetailsView:) forControlEvents:UIControlEventTouchUpInside];

            cell.ThreeBtn1.tag = indexPath.section + 2001;
            cell.ThreeBtn2.tag = indexPath.section + 2002;
            cell.ThreeBtn3.tag = indexPath.section + 2003;
            
        }
            break;
        default:
            
            break;
    }
    
    return cell;
}

//首页底部广告数据处理
-(void)pushActivityDetailsView:(UIButton *)sender{
    
    if (_user_token == 0 || [[NSString stringWithFormat:@"%@", [UserConfig user_id]] isEqualToString:@""]) {

        [MBProgressHUD showTextMessage:@"请先登录！"];
        return;
    }
    
    NSIndexPath *indexPath = [self.activityTableView indexPathForCell:(ActivityCell *)sender.superview.superview];
    
    NSInteger type = [self.activityArr[indexPath.section][@"setType"] integerValue];
    NSArray *skipArr = self.activityArr[indexPath.section][@"skip"];
    NSArray *webUrlArr = self.activityArr[indexPath.section][@"webUrl"];
    NSArray *contentArr = self.activityArr[indexPath.section][@"content"];
    NSArray *stockIdArr = self.activityArr[indexPath.section][@"stockId"];
    NSArray *serviceIdArr = self.activityArr[indexPath.section][@"serviceId"];

    switch (type) {
        case 1:{
            
            [self pushActivityViewControllerWithUrl:webUrlArr content:contentArr stockId:stockIdArr skip:[skipArr[0] integerValue] serviceId:serviceIdArr index:0];
        }
            break;
        case 2:{
            
            if (sender.tag == indexPath.section + 1001) {
                
                [self pushActivityViewControllerWithUrl:webUrlArr content:contentArr stockId:stockIdArr skip:[skipArr[0] integerValue] serviceId:serviceIdArr index:0];
            }else{
                
                [self pushActivityViewControllerWithUrl:webUrlArr content:contentArr stockId:stockIdArr skip:[skipArr[1] integerValue] serviceId:serviceIdArr index:1];
            }
        }
            break;
        case 3:{
            if (sender.tag == indexPath.section + 2001) {
                
                [self pushActivityViewControllerWithUrl:webUrlArr content:contentArr stockId:stockIdArr skip:[skipArr[0] integerValue] serviceId:serviceIdArr index:0];
            }else if (sender.tag == indexPath.section + 2002){
                
                [self pushActivityViewControllerWithUrl:webUrlArr content:contentArr stockId:stockIdArr skip:[skipArr[1] integerValue] serviceId:serviceIdArr index:1];
            }else{
                
                [self pushActivityViewControllerWithUrl:webUrlArr content:contentArr stockId:stockIdArr skip:[skipArr[2] integerValue] serviceId:serviceIdArr index:2];
            }
        }
            break;
        case 4:{
            
            
            
        }
        default:
            
            break;
    }
}

- (void)pushActivityViewControllerWithUrl:(NSArray *)urls content:(NSArray *)contents stockId:(NSArray *)stockIDArr skip:(NSInteger )skip serviceId:(NSArray *)serviceIds index:(NSInteger )index{
    
    switch (skip) {
        case 0:{
            //无分享webView
            MyWebViewController *webView = [[MyWebViewController alloc] init];
            webView.url = urls[index];
            
            [self.navigationController pushViewController:webView animated:YES];
        }
            break;
        case 1:{
            //有分享
            MyWebViewController *webView = [[MyWebViewController alloc] init];
            webView.url = urls[index];
            [webView activityInfoWithShareType:shareStatusAble shareText:contents[index] shareUrl:@"1"];
            [self.navigationController pushViewController:webView animated:YES];
        }
            break;
        case 2:{
            //跳转分类
            YMDetailedServiceViewController *commdoityDetailedVC = [[YMDetailedServiceViewController alloc] init];
            commdoityDetailedVC.serviceID = serviceIds[index];
            commdoityDetailedVC.serviceName = @"";
            [self.navigationController pushViewController:commdoityDetailedVC animated:YES];
        }
            break;
        case 3:{
            
            //跳转对应门店 商品 页面
            NSString *stockid = [NSString stringWithFormat:@"%@",stockIDArr[index]];
            NSString *reqJson = [PublicClass convertToJsonData:@{@"stockId":stockid,@"page":@"1",@"rows":@"5"}];
            
            [JJRequest postRequest:@"getStockByCondition" params:@{@"reqJson":reqJson} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
                
                if ([code integerValue] == 1) {
                    
                    NSDictionary *storeInfo = data[@"rows"][0];
                    
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    hud.label.text = @"正在查询...";
                    hud.mode = MBProgressHUDModeText;
                    [hud showAnimated:YES];
                    
                    NSString *longitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"longitude"];
                    NSString *latitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"latitude"];
                    
                    NSString *storeID = [storeInfo objectForKey:@"storeId"];
                    
                    [StoreDetailsRequest getStoreInfoByStoreIdWithInfo:@{@"storeId":storeID,@"longitude":longitude,@"latitude":latitude} succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
                        
                        [hud hideAnimated:YES];
                        
                        CommdoityDetailsViewController *storeDetails = [[CommdoityDetailsViewController alloc]init];
                        storeDetails.commodityInfo = data;
                        
                        //服务大类ID 从2开始  2汽车保养3美容清洗4安装改装5轮胎服务  button tag 从0开始 所以-2
                        storeDetails.clickButtonTag = [[storeInfo objectForKey:@"serviceTypeId"] integerValue]-2;
                        
                        //如果崩溃 那就是有商品ID 但是没有对应的商品
                        
                        //查询对应的商品错误！！！
                        storeDetails.directoryVC.defaultSelectedIndex = [[storeInfo objectForKey:@"serviceId"] integerValue];
                        
                        [self.navigationController pushViewController:storeDetails animated:YES];
                        
                    } failure:^(NSError * _Nullable error) {
                        
                    }];
                }
                NSLog(@"%@",data);
            } failure:^(NSError * _Nullable error) {
                
            }];
            
        }
            break;
        case 4:{
            
            MyInterestsViewController *interestsVC = [[MyInterestsViewController alloc] init];
            
            
            [self.navigationController pushViewController:interestsVC animated:YES];

            NSLog(@"新页面!");
        }
        default:
            break;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.activityArr.count>0) {
        
        return self.activityArr.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
 
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
 
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
 
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
 
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger type = [self.activityArr[indexPath.section][@"setType"] integerValue];

    switch (type) {
        case 0:
            
            return 45;
            break;
        case 1:
            
            return cellOneHeigh;
            break;
        case 2:
            
            return cellTwoHeigh;
            break;
        case 3:
            
            return cellThreeHeigh;
            break;
            
        default:
            break;
    }
    return 0.01;
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
-(void)adview:(ADView *)adview didSelectItemAtShareType:(shareType)type webUrl:(nonnull NSString *)webURL shareText:(nonnull NSString *)text shareURL:(nonnull NSString *)url{
    
    MyWebViewController *myWebVC = [[MyWebViewController alloc] init];

    myWebVC.url = webURL;
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
    
    if ([self.dataCars isEqual:[NSNull null]] || self.dataCars == nil || !self.dataCars || [UserConfig userCarId].intValue == 0) {
        
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"请先添加车辆" message:@"是否前往添加车辆界面" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"前往" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            MyCarInfoViewController *carinfoVC = [[MyCarInfoViewController alloc] init];
            carinfoVC.is_alter = YES;
            [self.navigationController pushViewController:carinfoVC animated:YES];
        }];
        [alertC addAction:action];
        [alertC addAction:action1];
        [self presentViewController:alertC animated:YES completion:nil];
        return;
    }
    
    if ([self.dataCars.car_id longLongValue] == 0) {
        
        ///弹出提示 跳转到车辆管理页面
        
        /* 请完善车辆信息
         是否前往完善信息界面
         */
        [self perfectCaiInfoAlert];
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
}

#pragma mark 跳转轮胎购买页面事件
- (void)chickBuytyreBtn:(UIButton *)btn{
    
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

#pragma mark 懒加载
-(NSMutableArray *)activityArr{
    
    if (!_activityArr) {
        
        _activityArr = [NSMutableArray array];

    }
    return _activityArr;
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
        _mainScrollV.backgroundColor = [UIColor clearColor];
        _mainScrollV.showsHorizontalScrollIndicator = NO;
        _mainScrollV.showsVerticalScrollIndicator = NO;
//        _mainScrollV.bounces = NO;
        _mainScrollV.delegate = self;
        _mainScrollV.scrollsToTop = NO;
        if (@available(iOS 11.0, *)) {
            
            _mainScrollV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            
        }
    }
    return _mainScrollV;
}

- (SDCycleScrollView *)sdcycleScrollV{
    
    if (_sdcycleScrollV == nil) {
        
        _sdcycleScrollV = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
        _sdcycleScrollV.autoScrollTimeInterval = 3.0;
        _sdcycleScrollV.showPageControl = NO;
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
        [_locationBtn setTitle:[UserConfig currentCity] forState:UIControlStateNormal];
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
    
//    dispatch_async(dispatch_get_main_queue(), ^{
    
        
        if (_user_token == 0 || [[NSString stringWithFormat:@"%@", [UserConfig user_id]] isEqualToString:@""]) {
            
            self.firstView.iconImageV.image = [UIImage imageNamed:@"注册"];
            self.firstView.topLabel.text = @"新人注册享好礼";
            self.firstView.bottomLabel.text = @"购买轮胎即送畅行无忧";
        }else{
            
            if ([_data_carDic isKindOfClass:[NSNull class]] || _data_carDic == nil) {
                
                self.firstView.iconImageV.image = [UIImage imageNamed:@"添加"];
                self.firstView.topLabel.text = @"添加我的宝驹";
                self.firstView.bottomLabel.text = @"邀请好友绑定车辆可得现金券";
            }else{
                
                if ([self.dataCars.car_id longLongValue] == 0) {
                    
                    self.firstView.iconImageV.image = [UIImage imageNamed:@"ic_dairenzheng"];
                    self.firstView.topLabel.text = @"请完善车辆信息";
                    self.firstView.bottomLabel.text = @"完善车辆信息后可享受特色服务";
                }else{
                    
                    [self.firstView.iconImageV sd_setImageWithURL:[NSURL URLWithString:self.dataCars.car_brand_url]];
                    self.firstView.topLabel.text = self.dataCars.car_verhicle;
                    self.firstView.bottomLabel.text = @"买轮胎即送畅行无忧";
                }
            }
        }
//    });
}
- (UITableView *)activityTableView{
    
    if (_activityTableView == nil) {

        _activityTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _activityTableView.backgroundColor = [UIColor whiteColor];
        _activityTableView.dataSource = self;
        _activityTableView.delegate = self;
        _activityTableView.scrollEnabled = NO;
    }
    return _activityTableView;
}


#pragma mark Notice AND Delegate
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

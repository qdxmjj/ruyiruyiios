//
//  FreeChangeViewController.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/7/4.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "FreeChangeViewController.h"
#import "FreeChangHeaderView.h"
#import "FreeChangeFooterView.h"
#import "FreeChangUserInfoCell.h"
#import "FreeChangeSeleceNumberCell.h"
#import "FreeChangeSelectPhotoCell.h"

#import "InstallStoreTableViewCell.h"
#import "NearbyViewController.h"

#import "MyOrderViewController.h"
@interface FreeChangeViewController ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic, strong)StoreInfo *storeInfo;
@property(nonatomic, strong)NSMutableArray *storeServiceMutableA;

//---------------------------------------------------
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)FreeChangHeaderView *headerView;

@property(nonatomic,strong)FreeChangeFooterView *footerView;
//轮胎图片cell的数量
@property(nonatomic,assign)NSInteger freeChangeSelectTirePhotoCellNumber;

@property(nonatomic,strong)NSMutableArray *titleArr;

@property(nonatomic,strong)NSMutableArray *contentArr;

//前轮最大数 ？ 如果fontRearFlag is 0   没有后轮数量 前后轮一致
@property(nonatomic,assign)NSInteger frontTotal;

//后轮最大数
@property(nonatomic,assign)NSInteger rearTotal;


//获取的参数
@property(nonatomic,copy)NSString *fontAmount;

@property(nonatomic,copy)NSString *fontRearFlag;

@property(nonatomic,copy)NSString *rearAmount;

@property(nonatomic,copy)NSString *platNumber;

@end

@implementation FreeChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"免费再换";
    [self getFreeChangeTireInfo];
    [self getBarCodeInfo];
    [self selectStoreByCondition];
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
}

- (IBAction)backButtonAction:(id)sender{
    
    if (self.popStatus) {
        
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[MyOrderViewController class]]) {
                
                MyOrderViewController *A =(MyOrderViewController *)controller;
                
                [self.navigationController popToViewController:A animated:YES];
            }
        }
    
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)getBarCodeInfo{
    
    NSDictionary *getCarDic = @{@"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]], @"userCarId":[NSString stringWithFormat:@"%@", [UserConfig userCarId]]};
    NSString *reqJson = [PublicClass convertToJsonData:getCarDic];
    
    [JJRequest postRequest:@"getCarByUserIdAndCarId" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        
        if ([statusStr isEqualToString:@"1"]) {
            
//            NSLog(@"车牌号信息：%@",data);
           
            self.platNumber = [NSString stringWithFormat:@"%@",[data objectForKey:@"platNumber"]];
            
            [self.contentArr replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%@",[data objectForKey:@"platNumber"]]];
            
            [self.tableView reloadData];
            
        }else if ([statusStr isEqualToString:@"-999"]){
            
            [self alertIsequallyTokenView];
            
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"车牌号信息错误:%@", error);
    }];
}

//复制粘贴
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
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:(UITableViewRowAnimationNone)];
}
//复制粘贴结束

-(void)getFreeChangeTireInfo{
    
    NSDictionary *getCarDic = @{@"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]], @"userCarId":[NSString stringWithFormat:@"%@", [UserConfig userCarId]]};
    NSString *reqJson = [PublicClass convertToJsonData:getCarDic];
    
    [JJRequest postRequest:@"getUserChangedShoeNumAnd5Year" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        
        if ([statusStr isEqualToString:@"1"]) {
            
//            NSLog(@"免费再换轮胎信息：%@",data);
            if (data == NULL || data == nil || [data isEqual:[NSNull null]]) {
                [PublicClass showHUD:@"无可更换轮胎！" view:self.view];
                return ;
            }
            
            self.fontAmount    = [NSString stringWithFormat:@"%@",[data objectForKey:@"fontAmount"]];
            
            self.fontRearFlag  = [NSString stringWithFormat:@"%@",[data objectForKey:@"fontRearFlag"]];
            
            self.rearAmount    = [NSString stringWithFormat:@"%@",[data objectForKey:@"rearAmount"]];

            if ([self.fontRearFlag isEqualToString:@"0"]) {
                //前后轮一致
                [self.titleArr addObject:@"当前轮胎数量"];
                [self.contentArr addObject:self.fontAmount];
                
                //设置总数 前后轮一致：只有前轮有数量 前后轮不一致：两者都有数量
                self.frontTotal = [_fontAmount integerValue];
                
            }else{
                
                //前后轮不一致
                [self.titleArr addObject:@"前胎数量"];
                [self.titleArr addObject:@"后胎数量"];
                
                [self.contentArr addObject:self.fontAmount];
                [self.contentArr addObject:self.rearAmount];
                
                //设置总数 前后轮一致：只有前轮有数量 前后轮不一致：两者都有数量
                self.frontTotal = [_fontAmount integerValue];
                self.rearTotal  = [_rearAmount integerValue];
            }

            [self.tableView reloadData];
            
        }else if ([statusStr isEqualToString:@"-999"]){
            
            [self alertIsequallyTokenView];
            
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"免费再换轮胎获取信息错误:%@", error);
    }];
}

-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), MAINSCREEN.height - SafeDistance) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = self.footerView;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FreeChangUserInfoCell class]) bundle:nil] forCellReuseIdentifier:@"FreeChangUserInfoCellID"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FreeChangeSeleceNumberCell class]) bundle:nil] forCellReuseIdentifier:@"FreeChangeSeleceNumberCellID"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FreeChangeSelectPhotoCell class]) bundle:nil] forCellReuseIdentifier:@"FreeChangeSelectPhotoCellID"];
        [_tableView registerClass:[InstallStoreTableViewCell class] forCellReuseIdentifier:@"FreeChangeInstallStoreTableViewCellID"];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"YMFreeChangeCellID"];
    }
    return _tableView;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            if (self.fontRearFlag) {
                
                if ([self.fontRearFlag isEqualToString:@"0"]) {
                    return 4;
                }else{
                    
                    return 5;
                }
            }
            
            return 3;
            break;
        case 1:
            
            return 2;
            break;
        case 2:
            if (self.freeChangeSelectTirePhotoCellNumber) {
                
                return self.freeChangeSelectTirePhotoCellNumber;
            }
            return 0;
            break;
            
        default:
            break;
    }
    
    return 1;
}

-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 4;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:{
            
            FreeChangUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FreeChangUserInfoCellID" forIndexPath:indexPath];

            cell.titleLab.text =self.titleArr[indexPath.row];
            
            cell.contentLab.text = self.contentArr[indexPath.row];
            
            return cell;
        }
            break;
        case 1:{
            
            FreeChangeSeleceNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FreeChangeSeleceNumberCellID" forIndexPath:indexPath];
            
            cell.tireNumberLab.text = @[@"前轮数量",@"后轮数量"][indexPath.row];
            
            [cell.lessBtn addTarget:self action:@selector(numberChangeEvent:) forControlEvents:UIControlEventTouchUpInside];
            [cell.plusbtn addTarget:self action:@selector(numberChangeEvent:) forControlEvents:UIControlEventTouchUpInside];

            return cell;
        }
            break;
        case 2:{
            
            FreeChangeSelectPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FreeChangeSelectPhotoCellID" forIndexPath:indexPath];
            return cell;
        }
            break;
        default:
            break;
    }
    
    InstallStoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FreeChangeInstallStoreTableViewCellID" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.functionMutableA = self.storeServiceMutableA;
    [cell setDatatoInstallStoreCellStoreInfo:self.storeInfo];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 3) {
        
        //参数未确定,开机继续
        NearbyViewController *nearbyVC = [[NearbyViewController alloc] init];
        nearbyVC.condition = @"轮胎服务";
        nearbyVC.status = @"1";
        nearbyVC.isLocation = @"1";
        nearbyVC.serviceType = @"5";
        nearbyVC.backBlock = ^(NSDictionary *dataDic) {
            
            [self analysizeDic:dataDic];
        };
        [self.navigationController pushViewController:nearbyVC animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
            
            return 44.f;
            break;
        case 1:
            
            return 44.f;
            break;
        case 2:
            
            return 110.f;
            break;
            
        default:
            break;
    }
    
    return 188.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            
            return 0.1f;
            break;
        case 1:
            
            return 0.1f;
            break;
        case 3:
            
            return 0.1f;
            break;
            
        default:
            break;
    }
    
    return 44.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    return 0.1f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    CGFloat h = [self tableView:tableView heightForHeaderInSection:section];

    switch (section) {
            break;
        case 2:{
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), h)];
            view.backgroundColor = [UIColor whiteColor];
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 150, h)];
            lab.text = @"轮胎图片";
            [view addSubview:lab];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            [btn setTitle:@"拍照示例>" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(pushPhotoExampleVC) forControlEvents:UIControlEventTouchUpInside];
            [btn setFrame:CGRectMake(self.view.frame.size.width-100-16, 0, 100, h)];
            [view addSubview:btn];
            return view;
        }
            
            break;
        default:
            break;
    }
    return [UIView new];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}

#pragma mark button click event
-(void)pushPhotoExampleVC{
    
    
    
}

-(void)submitFreeChangeInfo{
    
    if(!self.fontRearFlag){
        
        
        [PublicClass showHUD:@"没有可更换的轮胎！" view:self.view];
        return;
    }
    
    if (self.freeChangeSelectTirePhotoCellNumber <= 0||!self.freeChangeSelectTirePhotoCellNumber) {
        
        [PublicClass showHUD:@"请选择更换的轮胎！" view:self.view];
        return;
    }
    
    if (self.storeInfo.storeId == nil) {

        [PublicClass showHUD:@"没有选择安装门店！" view:self.view];
        return;
    }
    
    FreeChangeSeleceNumberCell *fountTireCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        FreeChangeSeleceNumberCell *rearTireCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    NSMutableDictionary *tireInfoDic = [NSMutableDictionary dictionary];

    [tireInfoDic setObject:self.storeInfo.storeId forKey:@"storeId"];
    [tireInfoDic setObject:[UserConfig userCarId] forKey:@"userCarId"];
    [tireInfoDic setObject:[UserConfig user_id] forKey:@"userId"];
        
    if ([self.fontRearFlag isEqualToString:@"0"]) {

        NSInteger total = [fountTireCell.numberLab.text integerValue] + [rearTireCell.numberLab.text integerValue];
            [tireInfoDic setObject:[NSString stringWithFormat:@"%ld",total] forKey:@"fontAmount"];
            [tireInfoDic setObject:@"0" forKey:@"rearAmount"];
            
    }else{
            
        [tireInfoDic setObject:fountTireCell.numberLab.text forKey:@"fontAmount"];
        [tireInfoDic setObject:rearTireCell.numberLab.text forKey:@"rearAmount"];
    }
    [tireInfoDic setObject:self.fontRearFlag forKey:@"fontRearFlag"];
    [tireInfoDic setObject:@"3" forKey:@"orderType"];
        
    
    
    NSMutableArray <JJFileParam *> *photoArr = [NSMutableArray array];

    float imgCompressionQuality = 0.3;

    for (int i = 0; i< self.freeChangeSelectTirePhotoCellNumber; i++) {
        
        FreeChangeSelectPhotoCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:2]];


        if (cell.selectBarCodePhotoBtn.imageView.image == nil) {
            
            [PublicClass showHUD:@"有轮胎条形码照片未选择！" view:self.view];
            return;
        }
        
        if (cell.selectWearLinePhotoBtn.imageView.image == nil) {
            
            [PublicClass showHUD:@"有轮胎磨损线照片未选择！" view:self.view];
            return;
        }
        
        NSData *frontData = UIImageJPEGRepresentation(cell.selectBarCodePhotoBtn.imageView.image, imgCompressionQuality);
        NSData *rearData = UIImageJPEGRepresentation(cell.selectWearLinePhotoBtn.imageView.image, imgCompressionQuality);

        [photoArr addObject:[JJFileParam fileConfigWithfileData:frontData name:[NSString stringWithFormat:@"shoe%dBarCodeImg",i+1] fileName:[NSString stringWithFormat:@"tire%d.png",i+1] mimeType:@"image/jpg/png/jpeg"]];
        
        [photoArr addObject:[JJFileParam fileConfigWithfileData:rearData name:[NSString stringWithFormat:@"shoe%dImg",i+1] fileName:[NSString stringWithFormat:@"code%d.png",i+1] mimeType:@"image/jpg/png/jpeg"]];
    }
    

    [JJRequest updateRequest:@"addUserFreeChangeOrder" params:@{@"reqJson":[PublicClass convertToJsonData:tireInfoDic],@"token":[UserConfig token]} fileConfig:photoArr progress:^(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        
        
        
    } success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {

        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        
        if ([statusStr isEqualToString:@"1"]) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else if ([statusStr isEqualToString:@"-999"]){
            
            [self alertIsequallyTokenView];
            
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
        
    } complete:^(id  _Nullable dataObj, NSError * _Nullable error) {
    }];
}

- (IBAction)numberChangeEvent:(UIButton *)sender {
    
    if (!self.fontRearFlag) {
        
        return;
    }
    
    FreeChangeSeleceNumberCell *cell = (FreeChangeSeleceNumberCell *) [[[sender superview] superview]superview];
    
    //加
    if ([sender isEqual:cell.plusbtn]) {
        
        if ([self.fontRearFlag isEqualToString:@"0"]) {
            
            //前后轮一致 状态
            
            if (self.frontTotal==0) {
                //有3个轮胎情况，所以需要判断总数,总数为0了 则不允许在增加
                //优先判断总数，在判断最大数（2）
                return;
            }
            
            if (cell.total == 2) {
                //判断最大数（2）
                return;
            }
            
            cell.total  += 1;
            self.frontTotal --;
            self.freeChangeSelectTirePhotoCellNumber ++;
            
        }else{
            
            //前后轮不一致 状态
            
            NSIndexPath *indexPath= [self.tableView indexPathForCell:cell];
            NSInteger maximum = 0;
            
            if (indexPath.row==0) {
                
                maximum = self.frontTotal;
                
            }else{
                
                maximum = self.rearTotal;
            }
            
            if (cell.total == maximum) {
                //最大数为获取的，
                return;
            }
            cell.total  += 1;
            self.freeChangeSelectTirePhotoCellNumber ++;
        }
    }
    
    //减
    if ([sender isEqual:cell.lessBtn]) {
        
        if (cell.total == 0) {
            return ;
        }
        
        cell.total -= 1;
        self.freeChangeSelectTirePhotoCellNumber --;
        
        if ([self.fontRearFlag isEqualToString:@"0"]) {
            
            self.frontTotal ++;
        }
        
    }
    
    cell.numberLab.text = [NSString stringWithFormat:@"%ld",cell.total];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:(UITableViewRowAnimationNone)];
}

-(NSMutableArray *)titleArr{
    
    if (!_titleArr) {
        
        _titleArr = [NSMutableArray array];
        
        [_titleArr addObject:@"联系人"];
        [_titleArr addObject:@"联系电话"];
        [_titleArr addObject:@"车牌号码"];
    }
    return _titleArr;
}

-(NSMutableArray *)contentArr{
    
    if (!_contentArr) {
        
        _contentArr = [NSMutableArray array];
        [_contentArr addObject:[UserConfig nick]];
        [_contentArr addObject:[UserConfig phone]];
        [_contentArr addObject:@" "];
    }
    return _contentArr;
}

-(FreeChangHeaderView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [[FreeChangHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 150)];
    }
    return _headerView;
}

-(FreeChangeFooterView *)footerView{
    
    if (!_footerView) {
        
        _footerView = [[FreeChangeFooterView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 40)];
        [_footerView.submitBtn addTarget:self action:@selector(submitFreeChangeInfo) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footerView;
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

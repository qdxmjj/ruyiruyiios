//
//  NearbyViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/8.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "NearbyViewController.h"
#import "FJStoreTableViewCell.h"
#import "SearchViewController.h"
#import "CommdoityDetailsViewController.h"
#import "TopBarView.h"
#import "JJMenuView.h"
#import "FJStoreToppingView.h"
#import <MJRefresh.h>
#import "FJStoreReqeust.h"
#import "LocationViewController.h"
#import "DelegateConfiguration.h"
#import "MBProgressHUD+YYM_category.h"

#import <Masonry.h>
@interface NearbyViewController ()<UITableViewDelegate,UITableViewDataSource,JJDropdownViewDelegate,JJClickExpandDelegate, CityNameDelegate, LoginStatusDelegate,ToppingDidSelectDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)JJMenuView *menuView;
@property(nonatomic,strong)TopBarView *topBarView;
@property(nonatomic,strong)FJStoreToppingView *toppingView;

@property(nonatomic,assign)NSInteger pageNumber;
@property(nonatomic,strong)NSMutableArray *dataArr;//商店列表数据
@property(nonatomic,strong)NSArray *topingDataArr;//指定商店列表数据
@property(nonatomic, strong)UIButton *leftBtn;

@property(nonatomic,strong)UIImageView *backgroundImgView;
@property(nonatomic,copy)NSString *rankType;
@property(nonatomic,copy)NSString *storeType;

@end

@implementation NearbyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DelegateConfiguration *delegateCF = [DelegateConfiguration sharedConfiguration];
    [delegateCF registercityNameListers:self];
    [delegateCF registerLoginStatusChangedListener:self];
    
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if ([self.isLocation isEqualToString: @"1"]) {
        [_leftBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    }else{
        [_leftBtn setImage:[UIImage imageNamed:@"定位"] forState:UIControlStateNormal];
    }
    
    [_leftBtn setFrame:CGRectMake(20, 0, 60, 30)];
    [_leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -10, 0.0, 0.0)];
    [_leftBtn addTarget:self action:@selector(chickLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn setTitle:[[NSUserDefaults standardUserDefaults] objectForKey:@"currentCity"] forState:UIControlStateNormal];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"ic_search"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(pushSearchVC) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"附近的门店";
    
    [self.view addSubview:self.topBarView];
    [self.view addSubview:self.tableView];
    
    if ([self.isLocation isEqualToString:@"1"]) {
        
        self.rankType = @"0";
        if (self.serviceType.length<=0||self.condition.length<=0) {
            
            self.serviceType = @"";
            self.condition = @"条件筛选";
        }
        self.storeType = @"";
        self.topBarView.conditionArr = @[@{@"全部门店":@[@"全部门店",@"4S店",@"快修店",@"维修厂",@"美容店",]},@{@"默认排序":@[@"默认排序",@"附近优先"]},@{self.condition:@[self.condition]}];
    }else{
        
        self.rankType = @"0";
        self.storeType = @"";
        self.serviceType = @"";
        self.topBarView.conditionArr = @[@{@"全部门店":@[@"全部门店",@"4S店",@"快修店",@"维修厂",@"美容店",]},@{@"默认排序":@[@"默认排序",@"附近优先"]},@{@"条件筛选":@[@"全部",@"汽车保养",@"美容清洗",@"安装改装",@"轮胎服务"]}];
    }
    
    //上拉更多
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self loadMoreData];
    }];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self loadNewData];
    }];
    [self.tableView.mj_header beginRefreshing];
}

- (void)chickLeftBtn:(UIButton *)button{
    
    if ([self.isLocation isEqualToString:@"1"]) {
        
        DelegateConfiguration *delegateConfiguration = [DelegateConfiguration sharedConfiguration];
        [delegateConfiguration unregisterLoginStatusChangedListener:self];
        [delegateConfiguration unregistercityNameListers:self];
        
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        
        LocationViewController *locationVC = [[LocationViewController alloc] init];
        locationVC.current_cityName = button.titleLabel.text;
        [self.navigationController pushViewController:locationVC animated:YES];
        if ([self.isLocation isEqualToString:@"1"]) {
            self.hidesBottomBarWhenPushed = YES;
        }
    }
}  

//下拉刷新
-(void)loadNewData{
    
    JJWeakSelf
    weakSelf.pageNumber=1;
    weakSelf.tableView.mj_footer.hidden = NO;
    
    [weakSelf getFJStoreInfo:[NSString stringWithFormat:@"%ld",(long)weakSelf.pageNumber] ];
    
    [weakSelf.tableView.mj_header endRefreshing];
}

//上拉加载
-(void)loadMoreData{
    
    JJWeakSelf
    weakSelf.pageNumber +=1;
    
    [weakSelf getFJStoreInfo:[NSString stringWithFormat:@"%ld",(long)weakSelf.pageNumber]];
    
    [weakSelf.tableView.mj_footer endRefreshing];
}

-(void)getFJStoreInfo:(NSString *)number{
    
    JJWeakSelf
    NSString *cityName = self.leftBtn.titleLabel.text.length <=0?@"定位失败":self.leftBtn.titleLabel.text;
    
    if (cityName == NULL || !cityName ||cityName==nil ||cityName.length<=0) {
        
        [MBProgressHUD showTextMessage:@"定位失败，请选择位置"];
        return;
    }
    
    if ([UserConfig user_id] == NULL) {
        
        [self alertIsloginView];
        return;
    }
    
    NSString *longitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"longitude"];
    NSString *latitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"latitude"];
    
    [FJStoreReqeust getFJStoreByConditionWithInfo:@{@"page":number,@"rows":@"10",@"cityName":cityName,@"storeName":@"",@"storeType":self.storeType,@"serviceType":self.serviceType,@"longitude":longitude,@"latitude":latitude,@"rankType":self.rankType} succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if (weakSelf.pageNumber==1) {
            
            [self.dataArr removeAllObjects];
        }
        
        [self.dataArr addObjectsFromArray:[data objectForKey:@"storeQuaryResVos"]];
        
        if ([[data objectForKey:@"storeQuaryResVos"] count]<10 ||data == nil) {
            
            [weakSelf.tableView.mj_footer setHidden:YES];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"附近：%@",error);
    }];
    
    NSDictionary *params = @{@"rankType":self.rankType,@"cityName":cityName,@"longitude":longitude,@"latitude":latitude};
    
    [JJRequest postRequest:@"/getStoreByIndex" params:@{@"reqJson":[PublicClass convertToJsonData:params]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if ([code longLongValue] == 1) {
            
            self.topingDataArr = [data objectForKey:@"storeQuaryResVos"];
            
            if (self.topingDataArr.count>0) {
                
                self.toppingView.delegate = self;
                self.toppingView.toppingStoreArr = [data objectForKey:@"storeQuaryResVos"];
                weakSelf.tableView.tableHeaderView = self.toppingView;
                [weakSelf.tableView reloadData];
            }else{
                
                self.toppingView.delegate = nil;
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.01)];
                weakSelf.tableView.tableHeaderView = view;
            }
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}

-(void)RefreshData{
    
    [self.tableView.mj_header beginRefreshing];
}

-(void)pushSearchVC{
    
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    searchVC.searchBlock = ^(NSArray *searchContent) {
        
        if (self.dataArr.count>0) {
            [self.dataArr removeAllObjects];
        }
        [self.dataArr addObjectsFromArray:searchContent];
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:searchVC animated:YES];
    if ([self.isLocation isEqualToString:@"1"]) {
        self.hidesBottomBarWhenPushed = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark toppingDelegate
-(void)toppingDidSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.topingDataArr.count>0) {
        
        CommdoityDetailsViewController *storeDetails = [[CommdoityDetailsViewController alloc]init];
        
        storeDetails.commodityInfo = self.topingDataArr[indexPath.item];
        
        [self.navigationController pushViewController:storeDetails animated:YES];
        if ([self.isLocation isEqualToString:@"1"]) {
            self.hidesBottomBarWhenPushed = YES;
        }
    }
}

#pragma mark - topView delegate
-(void)dropdownView:(JJMenuView *)dropdownView didSelectTitle:(NSString *)title didSelectIndex:(NSInteger)index whereGroup:(NSInteger)group{
    
    //group 点击的哪一组 全部门店 默认排序 条件筛选
    self.topBarView.textBlock(title);
    switch (group) {
        case 0:
            if (index==0) {
                
                self.storeType = @"";
            }else{
                
                self.storeType = [NSString stringWithFormat:@"%ld",(long)index];
            }
            break;
        case 1:
            
            self.rankType = [NSString stringWithFormat:@"%ld",(long)index];
            break;
        case 2:
            if (index == 0) {
                
                self.serviceType = @"";
            }else{
                
                self.serviceType = [NSString stringWithFormat:@"%ld",(long)index+1];
            }
            break;
        default:
            break;
    }
    [self.tableView.mj_header beginRefreshing];
}


-(void)dropdownViewDidShow:(JJMenuView *)dropdownView{
    
    NSLog(@"箭头乡下");
}

-(void)dropdownViewDidDismiss:(JJMenuView *)dropdownView{
    
    NSLog(@"箭头向上");
}

#pragma mark - topBarView delegate
-(void)clickExpandView:(TopBarView *)topBarView menuData:(NSArray *)dataArr didSelectIndex:(NSInteger)index{
    
    if (!self.menuView.status){
        
        [self.menuView showViewWithSuperView:self.view titleArr:dataArr];
        self.menuView.whereGroup = index;
    }else{
        
        [self.menuView disView];
    }
}

#pragma mark 更新城市 delegate
- (void)updateCityName:(NSString *)cityNameStr{
    
    //首次启动app 直接从主页跳转到切换城市页面 此代理无效 因为 那时当前页面还没生成 delegate还未签订
    //后续整顿废弃使用代理用法
    if ([self.isLocation isEqualToString:@"1"]) {
        
    }else{
        
        [self.leftBtn setTitle:cityNameStr forState:UIControlStateNormal];
        [self.tableView.mj_header beginRefreshing];
    }
}

#pragma mark loginStatus delegate
- (void)updateLoginStatus{
    
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.dataArr.count>0) {
        
        self.backgroundImgView.hidden = YES;
        return self.dataArr.count;
    }
    self.backgroundImgView.hidden = NO;
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.dataArr.count>0) {
        
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FJStoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fjStoreCellID" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    YM_FjStoreModel *model= [[YM_FjStoreModel alloc] init];
    [model setValuesForKeysWithDictionary:self.dataArr[indexPath.section]];
    [cell setCellDataModel:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.status isEqualToString:@"1"]) {
        
        //状态为1  pop回掉
        DelegateConfiguration *delegateConfiguration = [DelegateConfiguration sharedConfiguration];
        [delegateConfiguration unregistercityNameListers:self];
        [delegateConfiguration unregisterLoginStatusChangedListener:self];
        NSDictionary *backDic = [self.dataArr objectAtIndex:indexPath.section];
        
        self.backBlock(backDic);
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        
        CommdoityDetailsViewController *storeDetails = [[CommdoityDetailsViewController alloc]init];
        storeDetails.commodityInfo = self.dataArr[indexPath.section];
        [self.navigationController pushViewController:storeDetails animated:YES];
        if ([self.isLocation isEqualToString:@"1"]) {
            self.hidesBottomBarWhenPushed = YES;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 125.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 2.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 2.f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}

-(TopBarView *)topBarView{
    
    if (!_topBarView) {
        
        _topBarView = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
        _topBarView.delegate = self;
    }
    return _topBarView;
}

-(NSMutableArray *)dataArr{
    
    if (!_dataArr) {
        
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

-(NSArray *)topingDataArr{
    
    if (!_topingDataArr) {
        
        _topingDataArr = [NSArray array];
    }
    return _topingDataArr;
}

-(JJMenuView *)menuView{
    
    if (!_menuView) {
        
        _menuView = [[JJMenuView alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height-40)];
        _menuView.delegate = self;
    }
    return _menuView;
}

-(FJStoreToppingView *)toppingView{
    
    if (!_toppingView) {
        
        _toppingView = [[FJStoreToppingView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, 120)];
    }
    return _toppingView;
}

-(UITableView *)tableView{
    
    if (!_tableView) {
        
        CGRect frame;
        
        if ([self.isLocation isEqualToString: @"1"]) {
            
            frame = CGRectMake(0, 45, self.view.frame.size.width, self.view.frame.size.height-45-SafeAreaTopHeight);
        }else{
            
            frame = CGRectMake(0, 45, self.view.frame.size.width, self.view.frame.size.height-45-SafeAreaTopHeight-Height_TabBar);
        }
        
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FJStoreTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"fjStoreCellID"];
        [_tableView addSubview:self.backgroundImgView];
    }
    return _tableView;
}

-(UIImageView *)backgroundImgView{
    
    if (!_backgroundImgView) {
        
        _backgroundImgView = [[UIImageView alloc] initWithFrame:self.tableView.bounds];
        _backgroundImgView.backgroundColor = [UIColor whiteColor];
        [_backgroundImgView setImage:[UIImage imageNamed:@"ic_dakongbai"]];
        _backgroundImgView.contentMode = UIViewContentModeCenter;
    }
    return _backgroundImgView;
}

-(void)dealloc{
    
    NSLog(@"%@释放",[self class]);
}

@end

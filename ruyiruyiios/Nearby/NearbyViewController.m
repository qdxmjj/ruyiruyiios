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
#import <MJRefresh.h>
#import "FJStoreReqeust.h"
#import "LocationViewController.h"
#import "DelegateConfiguration.h"
#import "MBProgressHUD+YYM_category.h"
@interface NearbyViewController ()<UITableViewDelegate,UITableViewDataSource,JJDropdownViewDelegate,JJClickExpandDelegate, CityNameDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)JJMenuView *menuView;
@property(nonatomic,strong)TopBarView *topBarView;
@property(nonatomic,assign)NSInteger pageNumber;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic, strong)UIButton *leftBtn;

@property(nonatomic,copy)NSString *rankType;
@property(nonatomic,copy)NSString *storeType;
@property(nonatomic,copy)NSString *serviceType;

@end

@implementation NearbyViewController

- (void)viewWillAppear:(BOOL)animated{
    
    NSString *cityName = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentCity"];
    [self.leftBtn setTitle:cityName forState:UIControlStateNormal];
    

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DelegateConfiguration *delegateCF = [DelegateConfiguration sharedConfiguration];
    [delegateCF registercityNameListers:self];
    
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftBtn setImage:[UIImage imageNamed:@"定位"] forState:UIControlStateNormal];
    [_leftBtn setFrame:CGRectMake(20, 0, 50, 44)];
    [_leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -10, 0.0, 0.0)];
    [_leftBtn addTarget:self action:@selector(chickLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_leftBtn];
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"附近的门店";
    
    [self.view addSubview:self.topBarView];
    
    [self.view addSubview:self.tableView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_search"] style:UIBarButtonItemStylePlain target:self action:@selector(pushSearchVC)];
    
    self.rankType = @"0";
    self.storeType = @"";
    self.serviceType = @"";
    
    //上拉更多
    self.tableView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self loadMoreData];
        
    }];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self loadNewData];
        
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)chickLeftBtn:(UIButton *)button{
    
    LocationViewController *locationVC = [[LocationViewController alloc] init];
    locationVC.current_cityName = button.titleLabel.text;
    [self.navigationController pushViewController:locationVC animated:YES];
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
    
    NSLog(@"%@ ",self.leftBtn.titleLabel.text);
    
    if ([self.leftBtn.titleLabel.text isEqualToString:@""]) {
        
        [MBProgressHUD showTextMessage:@"定位失败，请选择位置"];
        return;
    }
    
    
    [FJStoreReqeust getFJStoreByConditionWithInfo:@{@"page":number,@"rows":@"10",@"cityName":self.leftBtn.titleLabel.text,@"storeName":@"",@"storeType":self.storeType,@"serviceType":self.serviceType,@"longitude":@"120.44407513056112",@"latitude":@"36.3206963164126",@"rankType":self.rankType} succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if (weakSelf.pageNumber==1) {
            
            [self.dataArr removeAllObjects];
        }
       
        [self.dataArr addObjectsFromArray:[data objectForKey:@"storeQuaryResVos"]];
        
        if ([[data objectForKey:@"storeQuaryResVos"] count]<10 ||data == nil) {
            
            [weakSelf.tableView.mj_footer setHidden:YES];
        }
        
        if (weakSelf.dataArr.count>0) {
            
            [weakSelf.tableView reloadData];
        }
        
    } failure:^(NSError * _Nullable error) {
        
        
    }];
}

-(void)RefreshData{
    
    [self.tableView.mj_header beginRefreshing];
    
}

-(void)pushSearchVC{
    
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - topView delegate
-(void)dropdownView:(JJMenuView *)dropdownView didSelectTitle:(NSString *)title didSelectIndex:(NSInteger)index whereGroup:(NSInteger)group{
    
    
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
    
    [self.leftBtn setTitle:cityNameStr forState:UIControlStateNormal];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.dataArr.count>0) {
        
        return self.dataArr.count;
    }
    
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
    
    CommdoityDetailsViewController *storeDetails = [[CommdoityDetailsViewController alloc]init];
    storeDetails.commodityInfo = self.dataArr[indexPath.section];
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:storeDetails animated:YES];
    self.hidesBottomBarWhenPushed = NO;
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
        
        _topBarView = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 45) data:@[@{@"全部门店":@[@"全部门店",@"4S店",@"快修店",@"维修厂",@"美容店",]},@{@"默认排序":@[@"默认排序",@"附近优先"]},@{@"条件筛选":@[@"全部",@"汽车保养",@"美容清洗",@"安装",@"轮胎服务"]}]];
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

-(JJMenuView *)menuView{
    
    if (!_menuView) {
        
        _menuView = [[JJMenuView alloc] initWithFrame:CGRectMake(0, 45, self.view.frame.size.width, self.view.frame.size.height-45)];
        _menuView.delegate = self;
    }
    
    return _menuView;
}

-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-45-64) style:UITableViewStyleGrouped];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FJStoreTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"fjStoreCellID"];
    }
    
    return _tableView;
}


-(void)dealloc{
    
    NSLog(@"%@释放",[self class]);
}

@end

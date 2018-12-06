//
//  YMDetailedServiceViewController.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/14.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "YMDetailedServiceViewController.h"
#import "YMDetailedServiceCell.h"
#import "WinterTyreRequeset.h"
#import "WinterTyreStockModel.h"
#import <MJRefresh.h>
#import "MBProgressHUD+YYM_category.h"
#import "StoreDetailsRequest.h"

#import "CommdoityDetailsViewController.h"
@interface YMDetailedServiceViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger pageNumber;
}
@property (strong, nonatomic) UITableView *tableView;

@property(nonatomic,strong)UIImageView *backgroundImgView;

@property(strong,nonatomic)NSMutableArray *dataArr;

/**sort 排序字段 值为 "distance" 或"price"  不传 传 "" (综合排序不传,默认按销量排序)
*order: 排序规则(倒序/正序): 当sort 为price 时传值值为 "desc"或 "asc" 其他排序传""
 
 */
@property(copy,nonatomic)NSString *sort;

@property(copy,nonatomic)NSString *order;
@end

@implementation YMDetailedServiceViewController

-(instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        //设置默认值
        self.sort = @"";
        self.order = @"";
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor colorWithRed:230.f/255.f green:230.f/255.f blue:230.f/255.f alpha:1.f];
    NSArray *topBtnTitleArr = @[@"综合",@"价格",@"距离"];
    
    for (int i = 0; i<3; i++) {
        
        UIButton *topBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [topBtn setFrame:CGRectMake(self.view.frame.size.width/3 * i, 0, self.view.frame.size.width/3, 40)];
        [topBtn setTitle:topBtnTitleArr[i] forState:UIControlStateNormal];
        
        [topBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [topBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
        
        [topBtn addTarget:self action:@selector(filterCommodityEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        [topBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.view addSubview:topBtn];
    }
    
    
    [self.view addSubview:self.tableView];

    //上拉更多
    self.tableView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self loadMoreData];
        
    }];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self loadNewData];
    }];
    
    [self.tableView.mj_header beginRefreshing];
}


-(void)loadNewData{
    
    pageNumber=1;
    self.tableView.mj_footer.hidden = NO;
    
    [self getStockListInfo:pageNumber];
    
    [self.tableView.mj_header endRefreshing];
    
}

-(void)loadMoreData{
    
    JJWeakSelf
    
    pageNumber +=1;
    
    [self getStockListInfo:pageNumber];
    
    [weakSelf.tableView.mj_footer endRefreshing];
}

-(void)getStockListInfo:(NSInteger )number{
    
    NSString *longitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"longitude"];
    NSString *latitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"latitude"];
    NSString *cityName = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentCity"];
    NSInteger serviceid = [self.serviceID integerValue];
    
    if (cityName == NULL ||!cityName ||cityName==nil) {
        
        [MBProgressHUD showTextMessage:@"定位异常!"];
        return;
    }
    
    [WinterTyreRequeset getStockListByServiceWithInfo:@{@"serviceId":@(serviceid),@"serviceName":self.serviceName,@"cityName":cityName,@"longi":longitude,@"lati":latitude,@"sort":self.sort,@"order":self.order,@"page":@(number),@"rows":@(10)} succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
       
        if ( self->pageNumber==1) {
            [self.dataArr removeAllObjects];
        }
        
        [self.dataArr addObjectsFromArray:[data objectForKey:@"rows"]];
        
        if ([[data objectForKey:@"rows"] count]<10 ||data == nil) {
            
            [self.tableView.mj_footer setHidden:YES];
        }
        
        if (self.dataArr.count>0 ){
            
            self.backgroundImgView.hidden = YES;
        }
        
        [self.tableView reloadData];
        
    } failure:^(NSError * _Nullable error) {
        
        
    }];
    
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    YMDetailedServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YMDetailedServiceCellID" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    WinterTyreStockModel *model = [[WinterTyreStockModel alloc] init];
    
    [model setValuesForKeysWithDictionary:self.dataArr[indexPath.row]];
    
    [cell setStockModel:model];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.dataArr.count>0) {
        
        return self.dataArr.count;
    }
    
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 109;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"正在查询商品...";
    hud.mode = MBProgressHUDModeText;
    [hud showAnimated:YES];
    
    NSString *longitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"longitude"];
    NSString *latitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"latitude"];
    
    NSString *storeID = [self.dataArr[indexPath.row] objectForKey:@"storeId"];
    
    [StoreDetailsRequest getStoreInfoByStoreIdWithInfo:@{@"storeId":storeID,@"longitude":longitude,@"latitude":latitude} succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        [hud hideAnimated:YES];
        
        CommdoityDetailsViewController *storeDetails = [[CommdoityDetailsViewController alloc]init];
        storeDetails.commodityInfo = data;
        
        storeDetails.clickButtonTag = [[self.dataArr[indexPath.row] objectForKey:@"serviceTypeId"] integerValue]-2;
        
        //查询对应的商品错误！！！
        storeDetails.directoryVC.defaultSelectedIndex = [[self.dataArr[indexPath.row] objectForKey:@"serviceId"] integerValue];
        
        [self.navigationController pushViewController:storeDetails animated:YES];
        self.hidesBottomBarWhenPushed = YES;
        
    } failure:^(NSError * _Nullable error) {
        
    }];
    
    
}

- (void)filterCommodityEvent:(UIButton *)sender {
    
    if ([sender.titleLabel.text isEqualToString:@"综合"]) {
        
        self.sort = @"";
        self.order = @"";
        
        
    }else if ([sender.titleLabel.text isEqualToString: @"价格"]){
        
        self.sort = @"price";
        
        if ([self.order isEqualToString:@"desc"]) {
            
            self.order = @"asc";
        }else{
            self.order = @"desc";
        }
    }else{
        
        self.sort = @"distance";
        self.order = @"";
    }
    
    [self.tableView.mj_header beginRefreshing];
}


-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 41, CGRectGetWidth(self.view.frame), MAINSCREEN.height-SafeDistance) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YMDetailedServiceCell class]) bundle:nil] forCellReuseIdentifier:@"YMDetailedServiceCellID"];
        _tableView.tableFooterView = [UIView new];
        [_tableView addSubview:self.backgroundImgView];
    }
    
    
    return _tableView;
}

-(NSMutableArray *)dataArr{
    
    if (!_dataArr) {
        
        _dataArr = [NSMutableArray array];
    }

    return _dataArr;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

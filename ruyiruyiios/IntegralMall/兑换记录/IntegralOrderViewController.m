//
//  IntegralOrderViewController.m
//  ruyiruyiios
//
//  Created by 姚永敏 on 2019/1/15.
//  Copyright © 2019 ruyiruyi. All rights reserved.
//

#import "IntegralOrderViewController.h"
#import "LogisticsViewController.h"
#import "IntegralOrderCell.h"

@interface IntegralOrderViewController ()<UITableViewDelegate,UITableViewDataSource,integralOrderCellDelegate>
{
    NSInteger pageNumber;
}
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation IntegralOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单列表";
    
    [self.view addSubview:self.tableView];
    
    self.rootTableView = self.tableView;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.mas_equalTo(self.view);
    }];
    
    [self addRefreshControl];
    
    [self.rootTableView.mj_header beginRefreshing];
}

//下拉刷新
-(void)loadNewData{
    
    JJWeakSelf
    pageNumber = 1;
    weakSelf.tableView.mj_footer.hidden = NO;
    
    [weakSelf getIntegralOrderInfo:[NSString stringWithFormat:@"%ld",(long)pageNumber] ];
    
    [weakSelf.tableView.mj_header endRefreshing];
}

//上拉加载
-(void)loadMoreData{
    
    JJWeakSelf
    pageNumber +=1;
    
    [weakSelf getIntegralOrderInfo:[NSString stringWithFormat:@"%ld",(long)pageNumber]];
    
    [weakSelf.tableView.mj_footer endRefreshing];
}

- (void)getIntegralOrderInfo:(NSString *)page{
    
    [JJRequest getRequest:[NSString stringWithFormat:@"%@/score/order",INTEGRAL_IP] params:@{@"userId":[UserConfig user_id],@"page":page,@"rows":@"5"} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if (pageNumber == 1) {
            
            [self.dataArr removeAllObjects];
        }
        
        [self.dataArr addObjectsFromArray:[data objectForKey:@"items"]];
        
        if ([[data objectForKey:@"items"] count]<5 ||data == nil) {
            
            [self.tableView.mj_footer setHidden:YES];
        }
        
        [self.tableView reloadData];
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

- (void)IntegeralOrderCell:(IntegralOrderCell *)cell orderInfo:(nonnull NSDictionary *)info{
    
    LogisticsModel *model = [[LogisticsModel alloc] init];
    [model setValuesForKeysWithDictionary:info];
    
    LogisticsViewController *logisticsVC = [[LogisticsViewController alloc] initWithOrderLogisticsModel:model];
    [self.navigationController pushViewController:logisticsVC animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    IntegralOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IntegralOrderCellID" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    
    IntegralOrderModel *model = [[IntegralOrderModel alloc] init];
    [model setValuesForKeysWithDictionary:self.dataArr[indexPath.section]];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath{
 
    IntegralOrderCell *integralOrderCell = (IntegralOrderCell *)cell;
    
    integralOrderCell.delegate = nil;

}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.dataArr.count>0) {
        return self.dataArr.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 175;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
  
    return 2.5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        
        return 5;
    }
    return 2.5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
}

- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([IntegralOrderCell class]) bundle:nil] forCellReuseIdentifier:@"IntegralOrderCellID"];
    }
    return _tableView;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
@end

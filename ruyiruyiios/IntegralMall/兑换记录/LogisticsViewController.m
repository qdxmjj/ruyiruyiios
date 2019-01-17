//
//  LogisticsViewController.m
//  ruyiruyiios
//
//  Created by 姚永敏 on 2019/1/15.
//  Copyright © 2019 ruyiruyi. All rights reserved.
//

#import "LogisticsViewController.h"
#import "LogisticsHeaderView.h"
#import "LogisticsCell.h"
#import "MBProgressHUD+YYM_category.h"
@interface LogisticsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *dataArr;

@property (strong, nonatomic) LogisticsHeaderView *tableviewHeaderView;

@property (nonatomic, strong) LogisticsModel *orderLogisticsModel;

@end

@implementation LogisticsViewController

- (instancetype)initWithOrderLogisticsModel:(LogisticsModel *)model{
    self = [super init];
    if (self) {
     
        self.orderLogisticsModel = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"物流信息";
    
    self.tableView.estimatedRowHeight = 50.f;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LogisticsCell class]) bundle:nil] forCellReuseIdentifier:@"LogisticsCellID"];
    
    LogisticsHeaderView *logisticsHeaderView = [[LogisticsHeaderView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, 140)];
    self.tableView.tableHeaderView = logisticsHeaderView;
    self.tableviewHeaderView = logisticsHeaderView;
    self.tableView.tableFooterView = [UIView new];
    
    [self setData];
}

- (void)setData{
    NSString *orderNo = [NSString stringWithFormat:@"%@",self.orderLogisticsModel.orderNo];
    NSString *orderReceivingAddressId = [NSString stringWithFormat:@"%@",self.orderLogisticsModel.orderReceivingAddressId];

    if (orderNo.length>0) {
        
        [self getLogisticsInfo:orderNo];
    }
    
    if (orderReceivingAddressId.length>0) {
        
        [self getAddressID:orderReceivingAddressId];
    }
    
    self.tableviewHeaderView.goodsName = self.orderLogisticsModel.goodsName;
    self.tableviewHeaderView.goodsImg = self.orderLogisticsModel.imgUrl;
}

- (void)getAddressID:(NSString *)addressID{
    
    [JJRequest getRequest:[NSString stringWithFormat:@"http://192.168.0.60:10008/score/address/%@?userId=1",addressID] params:nil success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        if ([code integerValue] == 1) {
            self.tableviewHeaderView.address = data[@"address"];
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}
- (void)getLogisticsInfo:(NSString *)orderNo{
    
    [JJRequest interchangeableGetRequest:[NSString stringWithFormat:@"%@/express",SERVERPREFIX] params:@{@"orderNo":orderNo} success:^(id  _Nullable data) {
        NSInteger state = [data[@"state"] integerValue];
        switch (state) {
            case -1:
                
                [MBProgressHUD showTextMessage:@"单号或代码错误!"];
                break;
            case 0:
                
                [MBProgressHUD showTextMessage:@"暂无轨迹!"];
                break;
            case 4:
                
                [MBProgressHUD showTextMessage:@"快递异常!"];
                break;
            case 1:  case 2:  case 3:
                
                self.dataArr = data[@"list"];
                self.tableviewHeaderView.logisticsNO = data[@"no"];
                self.tableviewHeaderView.logisticsName = data[@"name"];
                self.tableviewHeaderView.logisticsPhone = data[@"phone"];
                [self.tableView reloadData];
                
            default:
                break;
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    LogisticsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LogisticsCellID" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        
        cell.topLineView.hidden = YES;
    }else if (indexPath.row == self.dataArr.count-1){
        
        cell.bottomLineView.hidden = YES;
    }else{
        
        cell.topLineView.hidden = NO;
        cell.bottomLineView.hidden = NO;
    }
    NSString *date = self.dataArr[indexPath.row][@"time"];
    date = [date substringWithRange:NSMakeRange(5, 5)];
    
    NSString *time = self.dataArr[indexPath.row][@"time"];
    time = [time substringWithRange:NSMakeRange(11, 5)];
    cell.dateLab.text = date;
    cell.timeLab.text = time;
    cell.contentLab.text = self.dataArr[indexPath.row][@"content"];

    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataArr.count>0) {
        
       return self.dataArr.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    return UITableViewAutomaticDimension;
}

- (NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}
- (LogisticsModel *)orderLogisticsModel{
    if (!_orderLogisticsModel) {
        
        _orderLogisticsModel = [[LogisticsModel alloc] init];
    }
    return _orderLogisticsModel;
}
@end

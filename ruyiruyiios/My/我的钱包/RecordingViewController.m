//
//  RecordingViewController.m
//  ruyiRuyi
//
//  Created by 姚永敏 on 2018/10/17.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "RecordingViewController.h"
#import "RecordingDetailsView.h"
#import "WithdrawModel.h"
#import "RecordingCell.h"
@interface RecordingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArr;

@property(nonatomic,strong)UIImageView *backGroundView;
@end

@implementation RecordingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现明细";
    
    [self.view addSubview:self.backGroundView];
    

    [JJRequest GL_PostRequest:@"/incomeInfo/queryUserIncomeAndExpensesInfo" params:@{@"userId":[UserConfig user_id]} success:^(id _Nullable rows, id  _Nullable total) {
        
        [self.dataArr addObjectsFromArray:rows];
        
        if (self.dataArr.count>0) {
            
            [self.backGroundView removeFromSuperview];
            [self.view addSubview:self.tableView];
            self.tableView.tableFooterView = [UIView new];
            
            [self.tableView reloadData];
        }

    } failure:^(NSError * _Nullable error) {
        
    }];
}

-(NSMutableArray *)dataArr{
    
    if (!_dataArr) {
        
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

-(UIImageView *)backGroundView{
    
    if (!_backGroundView) {
     
        _backGroundView = [[UIImageView alloc] initWithFrame:self.view.frame];
        _backGroundView.image = [UIImage imageNamed:@"ic_dakongbai"];
        _backGroundView.contentMode = UIViewContentModeCenter;
    }
    return _backGroundView;
}
-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RecordingCell class]) bundle:nil] forCellReuseIdentifier:@"recordingCellID"];
    }
    
    return _tableView;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    RecordingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recordingCellID" forIndexPath:indexPath];
    
    WithdrawModel *model = [[WithdrawModel alloc] init];
    
    [model setValuesForKeysWithDictionary:self.dataArr[indexPath.row]];
    
    [cell setWithdrawRecordingModel:model];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.dataArr.count>0) {
        
        return self.dataArr.count;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WithdrawModel *model = [[WithdrawModel alloc] init];

    [model setValuesForKeysWithDictionary:self.dataArr[indexPath.row]];
    
    RecordingDetailsView *rdView = [[RecordingDetailsView alloc] init];
    
    rdView.isPayStatus = [NSString stringWithFormat:@"%@",model.expensesType];
    rdView.withdrawAmount = [NSString stringWithFormat:@"%@",model.money];
    rdView.withdrawStatus = [NSString stringWithFormat:@"%@",model.status];
    rdView.receiptInfo = model.remark;
    rdView.date = [PublicClass getTimestampFromTime:[NSString stringWithFormat:@"%@",model.time] formatter:nil];
    rdView.orderNO = model.orderNo;
    rdView.type = [NSString stringWithFormat:@"%@",model.type];
    [rdView show];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

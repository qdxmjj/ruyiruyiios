//
//  FriendListController.m
//  ruyiruyiios
//
//  Created by 姚永敏 on 2018/12/4.
//  Copyright © 2018 ruyiruyi. All rights reserved.
//

#import "FriendListController.h"
#import "FriendCell.h"
@interface FriendListController ()
{
    NSString *cellID;
    NSString *status;
    NSInteger page;
}

@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation FriendListController

-(instancetype)initWithStyle:(UITableViewStyle)style withCellIdentifier:(NSString *)identifier withState:(nonnull NSString *)state{
    
    if (self = [super initWithStyle:style]) {
        
        cellID = identifier;
        status = state;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FriendCell class]) bundle:nil] forCellReuseIdentifier:cellID];
    
    [self addRefreshControl];
    
    [self.tableView.mj_header beginRefreshing];

}

-(void)loadNewData{
    
    JJWeakSelf
    page = 1;
    weakSelf.tableView.mj_footer.hidden = NO;
    
    [weakSelf getInfo:[NSString stringWithFormat:@"%ld",page]];
    
    [weakSelf.tableView.mj_header endRefreshing];
}

-(void)loadMoreData{
    JJWeakSelf
 
    page +=1;
    
    [weakSelf getInfo:[NSString stringWithFormat:@"%ld",page]];
    
    [weakSelf.tableView.mj_footer endRefreshing];
}

-(void)getInfo:(NSString *)number{
    
    NSString *reqJson = [PublicClass convertToJsonData:@{@"userId":[NSString stringWithFormat:@"%@",[UserConfig user_id]],@"state":status,@"page":number,@"rows":@"10"}];
    
    [JJRequest postRequest:@"preferentialInfo/getUserShareRelationList" params:@{@"reqJson":reqJson} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        [self.tableView.mj_footer endRefreshing];
        
        if ([code integerValue] == 1) {
            
            if (page==1) {
                
                [self.dataArr removeAllObjects];
            }
            
            [self.dataArr addObjectsFromArray:[data objectForKey:@"rows"]];
            
            if ([[data objectForKey:@"rows"] count]<10 ||data == nil) {
                
                [self.tableView.mj_footer setHidden:YES];
            }
            
            [self.tableView reloadData];
        }
        
    } failure:^(NSError * _Nullable error) {
        [self.tableView.mj_footer endRefreshing];
        
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.dataArr.count>0) {
        
        return self.dataArr.count;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 60.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 2.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.phoneLab.text = [self.dataArr[indexPath.row] objectForKey:@"phone"];
    
    cell.timeLab.text = [PublicClass getTimestampFromTime:[NSString stringWithFormat:@"%@",[self.dataArr[indexPath.row] objectForKey:@"createdTime"]] formatter:@"yyyy-MM-dd"];
    
    NSString *status = [NSString stringWithFormat:@"%@",[self.dataArr[indexPath.row] objectForKey:@"status"]];
    
    cell.statusLab.text = [status isEqualToString:@"1"] == YES ? @"已邀请": [status isEqualToString:@"2"]?@"已注册app":[status isEqualToString:@"3"]?@"已注册车辆信息":@"已安装轮胎" ;

    return cell;
}

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
@end

//
//  InvitedPrizeViewController.m
//  ruyiruyiios
//
//  Created by 姚永敏 on 2018/12/4.
//  Copyright © 2018 ruyiruyi. All rights reserved.
//

#import "InvitedPrizeViewController.h"
#import "FriendCell.h"
#import <Masonry.h>
@interface InvitedPrizeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger page;
}

@property(nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation InvitedPrizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的奖品";
  
    self.rootTableView.delegate = self;
    
    self.rootTableView.dataSource = self;
    
    self.rootTableView.tableFooterView = [UIView new];
    
    [self.rootTableView registerNib:[UINib nibWithNibName:NSStringFromClass([FriendCell class]) bundle:nil] forCellReuseIdentifier:@"PrizeCellID"];
    
    [self.view addSubview:self.rootTableView];
    
    [self.rootTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.view.mas_bottom);
        }
    }];
    
    [self addRefreshControl];
    [self.rootTableView.mj_header beginRefreshing];
}

-(void)loadNewData{
    
    JJWeakSelf
    page = 1;
    weakSelf.rootTableView.mj_footer.hidden = NO;
    
    [weakSelf getInfo:[NSString stringWithFormat:@"%ld",page]];
    
    [weakSelf.rootTableView.mj_header endRefreshing];
}

-(void)loadMoreData{
    JJWeakSelf
    
    page +=1;
    
    [weakSelf getInfo:[NSString stringWithFormat:@"%ld",page]];
    
    [weakSelf.rootTableView.mj_footer endRefreshing];
}

-(void)getInfo:(NSString *)number{
    NSString  *userID = [NSString stringWithFormat:@"%@",[UserConfig user_id]];
    NSString *reqJson = [PublicClass convertToJsonData:@{@"userId":userID,@"page":number,@"rows":@"10"}];
    
    [JJRequest postRequest:@"preferentialInfo/getUserCouponAndRewardList" params:@{@"reqJson":reqJson,@"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        [self.rootTableView.mj_footer endRefreshing];
        
        if ([code integerValue] == 1) {
            
            if ( page==1) {
                
                [self.dataArr removeAllObjects];
            }
            
            [self.dataArr addObjectsFromArray:[data objectForKey:@"rows"]];
            
            if ([[data objectForKey:@"rows"] count]<10 ||data == nil) {
                
                [self.rootTableView.mj_footer setHidden:YES];
            }
            
            [self.rootTableView reloadData];
        }
        
    } failure:^(NSError * _Nullable error) {
        [self.rootTableView.mj_footer endRefreshing];
        
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PrizeCellID" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    
    cell.phoneLab.text = [self.dataArr[indexPath.row] objectForKey:@"title"];
    
    cell.timeLab.text = [PublicClass getTimestampFromTime:[NSString stringWithFormat:@"%@",[self.dataArr[indexPath.row] objectForKey:@"time"]] formatter:@"yyyy-MM-dd"];
        
    cell.statusLab.text = [self.dataArr[indexPath.row] objectForKey:@"type"];
    
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 60.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
@end

//
//  IntergralTypeViewController.m
//  ruyiruyiios
//
//  Created by 姚永敏 on 2018/12/27.
//  Copyright © 2018 ruyiruyi. All rights reserved.
//

#import "IntergralTypeViewController.h"
#import "IntegralDetailsCell.h"
#import "IntegralModel.h"
#import <Masonry.h>
@interface IntergralTypeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger page;
    NSString *type;//积分类型
}

@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation IntergralTypeViewController
- (instancetype)initWithType:(NSString *)intergralType{
    
    self = [super init];
    if (self) {
        
        type = intergralType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rootTableView.delegate = self;
    
    self.rootTableView.dataSource = self;
    
    self.rootTableView.tableFooterView = [UIView new];
    
    [self.rootTableView registerNib:[UINib nibWithNibName:NSStringFromClass([IntegralDetailsCell class]) bundle:nil] forCellReuseIdentifier:@"IntegralDetailsCellID"];
    
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
    
    [self getInfo:@"1"];
    
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
    
    [JJRequest getRequest:[NSString stringWithFormat:@"%@/score/record",INTEGRAL_IP] params:@{@"userId":userID,@"type":type,@"page":number,@"rows":@"5"} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        [self.rootTableView.mj_footer endRefreshing];
        
        if ([code integerValue] == 1) {
            
            if ( page == 1) {
                
                [self.dataArr removeAllObjects];
            }
            
            NSArray *items = data[@"items"];
            
            for (NSDictionary *dic in items) {
                
                IntegralModel *model = [[IntegralModel alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [self.dataArr addObject:model];
            }
            
            
            if ([[data objectForKey:@"total"] integerValue] <10 || data == nil) {
                
                [self.rootTableView.mj_footer setHidden:YES];
            }
            
            [self.rootTableView reloadData];
        }
        
    } failure:^(NSError * _Nullable error) {
        [self.rootTableView.mj_footer endRefreshing];
        
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    IntegralDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IntegralDetailsCellID" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    IntegralModel *model = self.dataArr[indexPath.row];
    cell.titleLab.text = model.title;
    cell.dateLab.text = model.time;
    cell.amountLab.text = [NSString stringWithFormat:@"+%@",model.score];
    return cell;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.dataArr.count>0) {
        
        return self.dataArr.count;
    }
    return 0;
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

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
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation InvitedPrizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"邀请有礼";
  
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FriendCell class]) bundle:nil] forCellReuseIdentifier:@"PrizeCellID"];
    }
    return _tableView;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PrizeCellID"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    
    return cell;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 60.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    
}

@end

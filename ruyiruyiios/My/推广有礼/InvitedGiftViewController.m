//
//  InvitedGiftViewController.m
//  ruyiruyiios
//
//  Created by 姚永敏 on 2018/12/4.
//  Copyright © 2018 ruyiruyi. All rights reserved.
//

#import "InvitedGiftViewController.h"
#import "InvitedFriendViewController.h"
#import "InvitedPrizeViewController.h"
#import "InvitedGiftCell.h"
#import <Masonry.h>
@interface InvitedGiftViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *backgroundImages;
    NSArray *pathImages;
    NSArray *titles;
    NSArray *subTitles;
}
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation InvitedGiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"邀请有礼";
    backgroundImages = @[@"ic_one",@"ic_two",@"ic_three",@"ic_four"];
    pathImages = @[@"ic_youjiantou",@"ic_youtwo",@"ic_youthree",@"ic_youone@2x"];
    titles = @[@"邀请好友注册如驿如意",@"邀请车友购买轮胎",@"我推荐的人",@"我的奖品"];
    subTitles = @[@"获得免费洗车券，戳开领洗车券",@"可得百元红包，多邀多得上不封顶，戳开领红包",@"戳开查看帮助我助力的好友",@"戳开查看我已获得的奖励"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([InvitedGiftCell class]) bundle:nil] forCellReuseIdentifier:@"InvitedGiftCellID"];
    }
    return _tableView;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    InvitedGiftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InvitedGiftCellID"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backGrounpImgView.image = [UIImage imageNamed:backgroundImages[indexPath.section]];
    cell.pathImgView.image = [UIImage imageNamed:pathImages[indexPath.section]];
    cell.title.text = titles[indexPath.section];
    cell.subTitle.text = subTitles[indexPath.section];

    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 100.5f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 2:{
            InvitedFriendViewController *invitedFriendVC = [[InvitedFriendViewController alloc] init];
            [self.navigationController pushViewController:invitedFriendVC animated:YES];
            self.hidesBottomBarWhenPushed = YES;
        }
            break;
        case 3:{
            
            InvitedPrizeViewController *invitedPrizeVC = [[InvitedPrizeViewController alloc] init];
            [self.navigationController pushViewController:invitedPrizeVC animated:YES];
            self.hidesBottomBarWhenPushed = YES;
        }
            break;
            
        default:
            break;
    }
    
}

@end

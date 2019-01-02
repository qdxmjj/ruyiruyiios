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
#import "MyWebViewController.h"
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

@property(nonatomic,strong)NSDictionary *webInfo;
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
    
    [JJRequest interchangeablePostRequestWithIP:SHAREIP path:@"invite/Url" params:nil success:^(id  _Nullable data) {
        
        if (data == NULL || [data isEqual:[NSNull null]] || !data || data == nil) {
            
            return ;
        }
        self.webInfo = data;
    } failure:^(NSError * _Nullable error) {
        
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
        case 0: case 1:{
            if (self.webInfo.count <=0) {
                
                return;
            }
            NSDictionary *dic;
            NSString *shareURL;
            shareType type;
            if (indexPath.section == 0) {
                
                dic = self.webInfo[@"inviteRegister"];
                type = shareStatusAble;
                shareURL = [NSString stringWithFormat:@"%@?userId=%@",dic[@"shareUrl"],[UserConfig user_id]];
            }else{
                dic = self.webInfo[@"inviteBuy"];
                type = shareStatusNotAble;
                shareURL = dic[@"shareUrl"];
            }
            
            MyWebViewController *webview = [[MyWebViewController alloc] init];
            
            webview.url = [NSString stringWithFormat:@"%@?userId=%@",dic[@"url"],[UserConfig user_id]];
            
            [webview activityInfoWithShareType:type shareText:dic[@"shareTitle"] shareUrl:shareURL];
            
            [self.navigationController pushViewController:webview animated:YES];
            self.hidesBottomBarWhenPushed = YES;
        }
            break;
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

-(NSDictionary *)webInfo{
    
    if (!_webInfo) {
        
        _webInfo = [NSDictionary dictionary];
    }
    return _webInfo;
}

@end

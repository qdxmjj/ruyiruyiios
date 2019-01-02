//
//  IntegralViewController.m
//  Menu
//
//  Created by 姚永敏 on 2018/12/19.
//  Copyright © 2018 YYM. All rights reserved.
//

#import "IntegralViewController.h"
#import "RealThingViewController.h"
#import "ChangeCouponViewController.h"
#import "IntergralDetailsViewController.h"


#import <Masonry.h>
#import "IntegralNavigationView.h"
#import "GuideView.h"
#import "integralActivityCell.h"

static CGFloat const cellHeight = 110;

@interface IntegralViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,GuideViewDelegate,IntegralNavigationViewDelegate>
{
    NSInteger cellCount;
}

@property(nonatomic,strong)UIScrollView *mainView;
@property(nonatomic,strong)IntegralNavigationView *navView;
@property(nonatomic,strong)GuideView *guideView;

@property(nonatomic,strong)UITableView *tableView;
@end

@implementation IntegralViewController
- (void)viewWillAppear:(BOOL)animated{
    
    UIView * barBackground = self.navigationController.navigationBar.subviews.firstObject;
    if (@available(iOS 11.0, *))
    {
        barBackground.alpha = 0;
        [barBackground.subviews setValue:@(0) forKeyPath:@"alpha"];
    } else {
        barBackground.alpha = 0;
    }
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    UIView * barBackground = self.navigationController.navigationBar.subviews.firstObject;
    if (@available(iOS 11.0, *))
    {
        barBackground.alpha = 1;
        [barBackground.subviews setValue:@(1) forKeyPath:@"alpha"];
    } else {
        barBackground.alpha = 1;
    }
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"积分兑换";
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeAll;
    }
    
    cellCount = 10;

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.mainView];
    [self.mainView addSubview:self.navView];
    [self.mainView addSubview:self.guideView];
    [self.mainView addSubview:self.tableView];
    
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.view.mas_top);
        make.left.right.mas_equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.view.mas_bottom);
        }
        make.bottom.mas_equalTo(self.tableView.mas_bottom);
    }];
    
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.mainView.mas_top);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(200);
    }];
    
    [self.guideView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.navView.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(180);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.guideView.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(40+cellHeight*self->cellCount+0.01);
    }];
    

    [JJRequest getRequest:[NSString stringWithFormat:@"%@/score/info",SERVERPREFIX] params:@{@"userId":[NSString stringWithFormat:@"%@",[UserConfig user_id]]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
       
        if ([code integerValue] == 1) {
            
            if ([data[@"signState"] integerValue] == 0) {
                
                NSLog(@"未签到");
                
                [JJRequest postRequest:@"score/get/sign" params:@{@"userId":[NSString stringWithFormat:@"%@",[UserConfig user_id]]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
                    
                    NSLog(@"%@",data);
                } failure:^(NSError * _Nullable error) {
                    
                }];
            }
            
            self.navView.numberLab.text = data[@"totalScore"];
            NSLog(@"积分：%@",data[@"totalScore"]);
            NSLog(@"总签到次数：%@",data[@"currentMonthSignAmount"]);
        }
        
       
       
    } failure:^(NSError * _Nullable error) {
        
    }];
    
    

}

- (void)integralNavigationView:(IntegralNavigationView *)view didSelectMyIntegral:(NSString *)userId{
    
    IntergralDetailsViewController *detailsVc = [[IntergralDetailsViewController alloc] init];
    
    [self.navigationController pushViewController:detailsVc animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
   
    CGFloat alpha = (offsetY / 200)>0.99?0.99:(offsetY / 200);
    
    UIView * barBackground = self.navigationController.navigationBar.subviews.firstObject;
    
    if (@available(iOS 11.0, *))
    {
        barBackground.alpha = alpha;
        [barBackground.subviews setValue:@(alpha) forKeyPath:@"alpha"];
    } else {
        barBackground.alpha = alpha;
    }
    
}

- (void)GuideView:(GuideView *)view didSelectRowAtIndex:(NSInteger)index{
    
    switch (index) {
            case 0:{
             
                
                
            }
            break;
            case 1:{
             
                RealThingViewController *realThingVc = [[RealThingViewController alloc] init];
                
                [self.navigationController pushViewController:realThingVc animated:YES];
                self.hidesBottomBarWhenPushed = YES;
            }
            break;
            case 2:{
                
                ChangeCouponViewController *changeCouponVC = [[ChangeCouponViewController alloc] init];
                
                [self.navigationController pushViewController:changeCouponVC animated:YES];
                self.hidesBottomBarWhenPushed = YES;
            }
            break;
            
        default:
            break;
    }
}

- (UIScrollView *)mainView{
    
    if (_mainView == nil) {
        
        _mainView = [[UIScrollView alloc] init];
        _mainView.showsHorizontalScrollIndicator = NO;
        _mainView.showsVerticalScrollIndicator = NO;
        _mainView.scrollsToTop = NO;
        _mainView.delegate = self;
        if (@available(iOS 11.0, *)) {
            
            //解决UIScrollView 子视图无法覆盖状态栏问题
            _mainView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _mainView;
}

- (IntegralNavigationView *)navView{
    
    if (!_navView) {
        
        _navView = [[IntegralNavigationView alloc] init];
        _navView.delegate = self;
    }
    return _navView;
}
- (GuideView *)guideView{
    
    if (!_guideView) {
        
        _guideView = [[GuideView alloc] init];
        _guideView.delegate = self;
    }
    return _guideView;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([integralActivityCell class]) bundle:nil] forCellReuseIdentifier:@"integralActivityCellID"];
    }
    return _tableView;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    integralActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"integralActivityCellID" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return cellCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 40)];
    
    lab.text = @"积分轻松赚";
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont systemFontOfSize:15.f];
    
    return lab;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}

- (void)moreEvent:(UIButton *)sender{
    
    cellCount +=1;
    
    [self.tableView reloadData];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(80+80*self->cellCount);
    }];
}


@end

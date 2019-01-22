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
#import "IntegralOrderViewController.h"

#import <Masonry.h>
#import "IntegralNavigationView.h"
#import "GuideView.h"
#import "integralActivityCell.h"

#import "MBProgressHUD+YYM_category.h"

@interface IntegralViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,GuideViewDelegate,IntegralNavigationViewDelegate>
{
    NSArray *imgArr;
}
@property (nonatomic, strong) UIScrollView *mainView;
@property (nonatomic, strong) IntegralNavigationView *navView;
@property (nonatomic, strong) GuideView *guideView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *contentArr;
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
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"兑换记录" style:UIBarButtonItemStyleDone target:self action:@selector(pushIntegralOrderViewController)];
    
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    imgArr = @[@"ic_qiandao",@"ic_xiaofei",@"ic_yaoqing"];
    
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
        make.height.mas_equalTo(40+50*3);
    }];
    
    [self getIntegralInfoWithSignIn];
    
    __weak __typeof(self)weakSelf = self;
    
    self.block = ^{
      
        [weakSelf getIntegralInfoWithSignIn];
    };
}

- (void)getIntegralInfoWithSignIn{
    
    [MBProgressHUD showWaitMessage:@"正在获取积分..." showView:self.view];
    [JJRequest getRequest:[NSString stringWithFormat:@"%@/score/info",INTEGRAL_IP] params:@{@"userId":[NSString stringWithFormat:@"%@",[UserConfig user_id]]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        [MBProgressHUD hideWaitViewAnimated:self.view];
        if ([code integerValue] == 1) {
            
            self.navView.numberLab.text = data[@"totalScore"];
            
            [UserConfig userDefaultsSetObject:data[@"totalScore"] key:@"kIntegral"];
            
            self.contentArr = data[@"ruleList"];
            
            CGFloat tableviewHeight = 0.0;
            
            for (NSString *content in self.contentArr) {
                
                CGFloat height = [PublicClass getHeightWithText:content width:MAINSCREEN.width-54 font:15.f];
                tableviewHeight += height;
            }
            [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.height.mas_equalTo(tableviewHeight+35*3+40);
            }];
            [self.tableView reloadData];
        }else{
            
            [MBProgressHUD showTextMessage:@"获取积分失败！"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError * _Nullable error) {
        [MBProgressHUD hideWaitViewAnimated:self.view];

        [MBProgressHUD showTextMessage:@"获取积分失败！"];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
- (void)pushIntegralOrderViewController{
    
    IntegralOrderViewController *integralOrderVC = [[IntegralOrderViewController alloc] init];
    
    [self.navigationController pushViewController:integralOrderVC animated:YES];
    self.hidesBottomBarWhenPushed = YES;
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
             
                RealThingViewController *realThingVc = [[RealThingViewController alloc] initWithIntegral:self.navView.numberLab.text];
                
                [self.navigationController pushViewController:realThingVc animated:YES];
                self.hidesBottomBarWhenPushed = YES;
            }
            break;
            case 2:{
                
                ChangeCouponViewController *changeCouponVC = [[ChangeCouponViewController alloc] initWithIntegral:self.navView.numberLab.text];
                changeCouponVC.block = ^{
                  
                    [self getIntegralInfoWithSignIn];
                };
                [self.navigationController pushViewController:changeCouponVC animated:YES];
                self.hidesBottomBarWhenPushed = YES;
            }
            break;
            
        default:
            break;
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    integralActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"integralActivityCellID" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.contentArr.count > indexPath.row) {
        cell.contentLab.text = self.contentArr[indexPath.row];
        cell.titleLab.text = @[@"每日登陆",@"消费送积分",@"邀请送积分"][indexPath.row];
        cell.imgView.image = [UIImage imageNamed:imgArr[indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //文字高度默认20
    
    if (self.contentArr.count>0) {
        CGFloat height = [PublicClass getHeightWithText:self.contentArr[indexPath.row] width:MAINSCREEN.width-54 font:15.f];
        return 35 + height;
    }
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 40)];
    
    lab.text = @"  积分轻松赚";
    lab.textColor = [UIColor blackColor];
    lab.font = [UIFont systemFontOfSize:15.f];
    
    return lab;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
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

- (NSArray *)contentArr{
    if (!_contentArr) {
        
        _contentArr = [NSArray array];
    }
    return _contentArr;
}

@end

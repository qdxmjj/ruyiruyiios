//
//  RootViewController.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/7.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>
@interface UIButton(FillColor)

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
+ (UIImage *)imageWithColor:(UIColor *)color;
@end

@interface RootViewController : UIViewController

//下拉刷新
@property(nonatomic,strong)UITableView *rootTableView;

-(void)addRefreshControl;

-(void)loadMoreData;

-(void)loadNewData;

//退出登录 重置数据
- (void)setdataEmptying;

- (UIBarButtonItem *)barButtonItemWithRect:(CGRect)frame image:(UIImage *)image highlighted:(UIImage *)imagehigh target:(id)target action:(SEL)action;

- (IBAction)backButtonAction:(id)sender;

- (void)alertIsloginView;

- (void)alertIsequallyTokenView;

-(void)alertResetHomeInfoView;//暂未用到，留待以后
@end

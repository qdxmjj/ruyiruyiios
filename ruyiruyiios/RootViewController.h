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

//未登录
- (void)alertIsloginView;

//token错误
- (void)alertIsequallyTokenView;

//车辆未认证 或 车辆信息未完善
- (void)perfectCaiInfoAlert;

-(void)alertResetHomeInfoView;//暂未用到，留待以后

//查询当前账号是否分享

- (void)selectShareStatus:(void(^)(BOOL cxwyStatus,BOOL replaceStatus))selectSuccess;

/*
 *调用后台接口 修改当前账号的分享状态
 *jj_project  1为免费更换 2为畅行无忧
 */
- (void)updateShareStatus:(NSInteger )jj_project;

@end

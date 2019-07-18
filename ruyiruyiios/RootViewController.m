//
//  RootViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/7.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "RootViewController.h"
#import <MBProgressHUD.h>
#import <AFNetworking.h>
#import "CodeLoginViewController.h"
#import "MyWebViewController.h"
#import "CodeLoginViewController.h"
#import "ManageCarViewController.h"
#import "MBProgressHUD+YYM_category.h"
#import "JJShare.h"

@implementation UIButton(FillColor)

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state{
    
    [self setBackgroundImage:[UIButton imageWithColor:backgroundColor] forState:state];
}

+ (UIImage *)imageWithColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsGetImageFromCurrentImageContext();
    return image;
}

@end
@interface RootViewController ()<UIGestureRecognizerDelegate>

@end

@implementation RootViewController

- (void)viewWillAppear:(BOOL)animated{
 
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置CGRectZero从导航栏下开始计算
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:20], NSFontAttributeName, nil]];
    
    if (@available(iOS 11.0, *)) {
        
        self.navigationItem.leftBarButtonItems =@[[self BarButtonItemWithImage:[UIImage imageNamed:@"ic_back"] target:self action:@selector(backButtonAction:)]];
    }else{
        UIBarButtonItem *spaceBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceBar.width = -20;  //iOS11 已失效
        self.navigationItem.leftBarButtonItems =@[spaceBar,[self BarButtonItemWithImage:[UIImage imageNamed:@"ic_back"] target:self action:@selector(backButtonAction:)]];
    }
}

-(void)addRefreshControl{
    
    //上拉更多
    self.rootTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self loadMoreData];
        
    }];
    
    self.rootTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self loadNewData];
        
    }];
}

-(void)loadMoreData{
    
    
}

-(void)loadNewData{
    
    
}

-(UITableView *)rootTableView{
    
    if (!_rootTableView) {
        
        _rootTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _rootTableView.backgroundColor = [UIColor whiteColor];
    }
    return _rootTableView;
}

-(UIBarButtonItem *)BarButtonItemWithImage:(UIImage *)image target:(id)target action:(SEL)action
{
    UIButton*bt=[UIButton buttonWithType:UIButtonTypeCustom];
    [bt setImage:image forState:UIControlStateNormal];
    bt.frame=CGRectMake(0, 0, 44, 44);
    [bt addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    if (@available(iOS 11.0, *)) {
        [bt setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];//解决iOS11 左侧按钮偏移的问题
    }
    return [[UIBarButtonItem alloc]initWithCustomView:bt];
}

- (UIBarButtonItem *)barButtonItemWithRect:(CGRect)frame image:(UIImage *)image highlighted:(UIImage *)imagehigh target:(id)target action:(SEL)action{
    
    CGFloat offset = 0.0f;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:imagehigh forState:UIControlStateHighlighted];
//    button.backgroundColor = [UIColor blackColor];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -frame.size.width + 20, 0, 0)];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, button.frame.size.width, button.frame.size.height + offset)];
    [buttonView addSubview:button];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:buttonView];
    return barButton;
}

- (IBAction)backButtonAction:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)alertIsloginView{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还没有登录" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"前往登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        CodeLoginViewController *loginVC = [[CodeLoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"暂不登录" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:ok];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)alertIsequallyTokenView{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请重新登录" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"重新登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        CodeLoginViewController *codeLoginVC = [[CodeLoginViewController alloc] init];
        [self.navigationController pushViewController:codeLoginVC animated:YES];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:ok];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)alertResetHomeInfoView{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否重置首页与配置信息,此过程可能需要一些时间!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"重置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:ok];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)perfectCaiInfoAlert{
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"当前车辆未认证" message:@"是否前往认证" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"前往" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        ///
        ManageCarViewController *manageCarVC = [[ManageCarViewController alloc] init];
        manageCarVC.popStatus = 1;
        [self.navigationController pushViewController:manageCarVC animated:YES];
    }];
    
    [alertC addAction:action];
    [alertC addAction:action1];
    [self presentViewController:alertC animated:YES completion:nil];
}

- (void)selectShareStatus:(void (^)(BOOL, BOOL))selectSuccess{
    
    NSString *reqJson = [PublicClass convertToJsonData:@{@"userId":[UserConfig user_id],@"userCarId":[UserConfig userCarId]}];
    
    [JJRequest postRequest:@"preferentialInfo/getReplaceShareStatus" params:@{@"reqJson":reqJson,@"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
      
        if (data && data != nil && data != [NSNull null]) {
            
            BOOL cxwyStatus = [data[@"cxwyStatus"] longLongValue] == 1 ? YES:NO; //1是已经分享0未分享
            BOOL replaceStatus = [data[@"replaceStatus"] longLongValue] == 1 ? YES:NO; //1是已经分享0未分享

            selectSuccess(cxwyStatus,replaceStatus);
        }else{
            selectSuccess(NO,NO);
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}

- (void)updateShareStatus:(NSInteger)jj_project{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请先分享" message:@"为了您的朋友也能享受如此好的服务，请把我们分享给您身边的朋友!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [MBProgressHUD showWaitMessage:@"正在分享..." showView:self.view];
        
        [JJShare ShareDescribe:@"如驿如意"
                        images:@[[UIImage imageNamed:@"icon"]]
                           url:@"https://mp.weixin.qq.com/s/WZHn3G0ZjiQD_5dS2Y76fA"
                         title:@"1、快来，我在如驿如意免费换了新轮胎！\n2、轮胎撞坏了，在如驿如意免费换了新的~~"
                          type:SSDKContentTypeAuto
                         block:^(BOOL shareStatus) {
                             
                             if (shareStatus) {
                                 
                                 NSString *project;
                                 if (jj_project == 1) {
                                     
                                     project = @"replaceStatus";///免费更换
                                 }else if (jj_project == 2){
                                     
                                     project = @"cxwyStatus";///畅行无忧
                                 }else{
                                     
                                     project = @"";
                                 }
                                 NSString *reqJson = [PublicClass convertToJsonData:@{@"userId":[UserConfig user_id],@"userCarId":[UserConfig userCarId],project:@(1)}];
                                 
                                 [JJRequest postRequest:@"preferentialInfo/updateReplaceShareStatus" params:@{@"reqJson":reqJson,@"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
                                     
                                     [MBProgressHUD hideWaitViewAnimated:self.view];
                                     if ([code longLongValue] == 1) {
                                         
                                         [MBProgressHUD showTextMessage:@"分享成功!"];
                                     }else{
                                         [MBProgressHUD showTextMessage:message];
                                     }
                                 } failure:^(NSError * _Nullable error) {
                                     [MBProgressHUD hideWaitViewAnimated:self.view];
                                 }];
                             }else{
                                 [MBProgressHUD hideWaitViewAnimated:self.view];
                                 [MBProgressHUD showTextMessage:@"分享失败！"];
                             }
                         }];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:ok];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}



- (void)setdataEmptying{
    
    [UserConfig userDefaultsSetObject:@"" key:@"age"];
    [UserConfig userDefaultsSetObject:@"" key:@"birthday"];
    [UserConfig userDefaultsSetObject:@"" key:@"createTime"];
    [UserConfig userDefaultsSetObject:@"" key:@"createdBy"];
    [UserConfig userDefaultsSetObject:@"" key:@"createdTime"];
    [UserConfig userDefaultsSetObject:@"" key:@"deletedBy"];
    [UserConfig userDefaultsSetObject:@"" key:@"deletedFlag"];
    [UserConfig userDefaultsSetObject:@"" key:@"deletedTime"];
    [UserConfig userDefaultsSetObject:@"" key:@"email"];
    [UserConfig userDefaultsSetObject:@"" key:@"firstAddCar"];
    [UserConfig userDefaultsSetObject:@"" key:@"gender"];
    [UserConfig userDefaultsSetObject:@"" key:@"headimgurl"];
    [UserConfig userDefaultsSetObject:@"" key:@"user_id"];
    [UserConfig userDefaultsSetObject:@"" key:@"invitationCode"];
    [UserConfig userDefaultsSetObject:@"" key:@"lastUpdatedBy"];
    [UserConfig userDefaultsSetObject:@"" key:@"lastUpdatedTime"];
    [UserConfig userDefaultsSetObject:@"" key:@"ml"];
    [UserConfig userDefaultsSetObject:@"" key:@"nick"];
    [UserConfig userDefaultsSetObject:@"" key:@"password"];
    [UserConfig userDefaultsSetObject:@"" key:@"payPwd"];
    [UserConfig userDefaultsSetObject:@"" key:@"phone"];
    [UserConfig userDefaultsSetObject:@"" key:@"qqInfoId"];
    [UserConfig userDefaultsSetObject:@"" key:@"remark"];
    [UserConfig userDefaultsSetObject:@"" key:@"status"];
    [UserConfig userDefaultsSetObject:@"" key:@"token"];
    [UserConfig userDefaultsSetObject:@"" key:@"updateTime"];
    [UserConfig userDefaultsSetObject:@"" key:@"version"];
    [UserConfig userDefaultsSetObject:@"" key:@"wxInfoId"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    
    
    [[[AFHTTPSessionManager manager]operationQueue] cancelAllOperations];

    NSLog(@"dealloc：%@",self);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

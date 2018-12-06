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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置CGRectZero从导航栏下开始计算
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:20], NSFontAttributeName, nil]];
    
    //又划返回手势
    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    panGesture.delegate = self;
    [self.view addGestureRecognizer:panGesture];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    //
    if (@available(iOS 11.0, *)) {
        
        self.navigationItem.leftBarButtonItems =@[[self BarButtonItemWithImage:[UIImage imageNamed:@"ic_back"] target:self action:@selector(backButtonAction)]];
    }else{
        UIBarButtonItem *spaceBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceBar.width = -20;  //iOS11 已失效
        self.navigationItem.leftBarButtonItems =@[spaceBar,[self BarButtonItemWithImage:[UIImage imageNamed:@"ic_back"] target:self action:@selector(backButtonAction)]];
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 当当前控制器是根控制器时，不可以侧滑返回
    if(self.navigationController.childViewControllers.count == 1)
    {
        return NO;
    }
    return YES;
}


- (void)backButtonAction{
    
    [self.navigationController popViewControllerAnimated:YES];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    
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

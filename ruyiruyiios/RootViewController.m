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
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"ic_navback"] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    self.navigationItem.leftBarButtonItem = [self barButtonItemWithRect:CGRectMake(0, 0, 60, 30) image:[UIImage imageNamed:@"返回"] highlighted:nil target:self action:@selector(backButtonAction:)];

    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:23.0f]}];
    
//    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
//    statusBarView.backgroundColor = LOGINBACKCOLOR;
//    [self.view addSubview:statusBarView];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (UIBarButtonItem *)barButtonItemWithRect:(CGRect)frame image:(UIImage *)image highlighted:(UIImage *)imagehigh target:(id)target action:(SEL)action{
    
    CGFloat offset = 0.0f;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:imagehigh forState:UIControlStateHighlighted];
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
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"此用户已在别的地方登录，请重新登录" preferredStyle:UIAlertControllerStyleAlert];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

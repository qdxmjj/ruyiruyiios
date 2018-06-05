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

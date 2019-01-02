//
//  BaseNavigation.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/4/26.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "BaseNavigation.h"
#import "CommdoityDetailsViewController.h"
#import "WelcomeViewController.h"
@interface BaseNavigation ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation BaseNavigation

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationBar.barTintColor = LOGINBACKCOLOR;
//    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"ic_navback"] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ic_navback"]];


    self.delegate = self;
}

//隐藏导航栏
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([viewController isKindOfClass:[CommdoityDetailsViewController class]]||
        [viewController isKindOfClass:[HomeViewController class]]||
        [viewController isKindOfClass:[MyViewController class]]||
        [viewController isKindOfClass:[WelcomeViewController class]]) {
        
        [self setNavigationBarHidden:YES animated:YES];
    }else{
        [self setNavigationBarHidden:NO animated:YES];
    }
}
//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{

//}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:YES];
    viewController.hidesBottomBarWhenPushed = NO;
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

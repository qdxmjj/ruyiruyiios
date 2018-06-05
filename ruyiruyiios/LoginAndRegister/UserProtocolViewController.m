//
//  UserProtocolViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/14.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "UserProtocolViewController.h"

@interface UserProtocolViewController ()

@end

@implementation UserProtocolViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController.navigationBar setHidden:NO];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"用户协议";
    // Do any additional setup after loading the view.
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

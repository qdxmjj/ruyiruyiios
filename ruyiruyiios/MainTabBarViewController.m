//
//  MainTabBarViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/8.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "HomeViewController.h"
#import "NearbyViewController.h"
#import "WinterTyreViewController.h"
#import "MyViewController.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatViewControllers];
    [self creatItems];
    // Do any additional setup after loading the view.'
}

- (void)creatViewControllers{
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    
    NearbyViewController *nearbyVC = [[NearbyViewController alloc] init];
    UINavigationController *nearbyNav = [[UINavigationController alloc] initWithRootViewController:nearbyVC];
    
    WinterTyreViewController *winterVC = [[WinterTyreViewController alloc] init];
    UINavigationController *winterNav = [[UINavigationController alloc] initWithRootViewController:winterVC];
    
    MyViewController *myVC = [[MyViewController alloc] init];
    UINavigationController *myNav = [[UINavigationController alloc] initWithRootViewController:myVC];
    self.viewControllers = @[homeNav, nearbyNav, winterNav, myNav];
}

- (void)creatItems{
    
    NSArray *titleArray = @[@"首页", @"附近", @"分类", @"我的"];
    NSArray *selectImageNameArray = @[@"首页2", @"ic_fujin", @"ic_shangpin_xuanzhong", @"ic_my"];
    NSArray *unSelectImageNameArray = @[@"ic_index", @"门店", @"ic_shangpin", @"我的"];
    for (int i = 0; i<self.tabBar.items.count; i++) {
        
        UITabBarItem *item = self.tabBar.items[i];
        item.title = titleArray[i];
        UIImage *selectImage = [UIImage imageNamed:selectImageNameArray[i]];
        selectImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *unSeletImage = [UIImage imageNamed:unSelectImageNameArray[i]];
        unSeletImage = [unSeletImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = selectImage;
        item.image = unSeletImage;
        
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        UIColor *titleHightedColor = LOGINBACKCOLOR;
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:titleHightedColor, NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    }
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

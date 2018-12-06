//
//  MainTabBarViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/8.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "BaseNavigation.h"

@interface MainTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self creatViewControllers];
//    [self creatItems];


    [self.tabBar setBarTintColor:[UIColor whiteColor]];
    self.tabBar.translucent = NO;
    self.delegate = self;
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    
    NearbyViewController *nearbyVC = [[NearbyViewController alloc] init];
    
    WinterTyreViewController *winterVC = [[WinterTyreViewController alloc] init];
    
    MyViewController *myVC = [[MyViewController alloc] init];
    
    
    [self setController:homeVC title:@"首页" imageString:@"ic_index" selectedImageString:@"首页2"];
    [self setController:nearbyVC title:@"附近" imageString:@"门店" selectedImageString:@"ic_fujin"];
    [self setController:winterVC title:@"分类" imageString:@"ic_shangpin" selectedImageString:@"ic_shangpin_xuanzhong"];
    [self setController:myVC title:@"我的" imageString:@"我的" selectedImageString:@"ic_my"];
}
/*
    https://www.jianshu.com/p/7bec9ea95c86
 */



//- (void)creatViewControllers{
//
//    HomeViewController *homeVC = [[HomeViewController alloc] init];
//    BaseNavigation *homeNav = [[BaseNavigation alloc] initWithRootViewController:homeVC];
//
//    NearbyViewController *nearbyVC = [[NearbyViewController alloc] init];
//    BaseNavigation *nearbyNav = [[BaseNavigation alloc] initWithRootViewController:nearbyVC];
//
//    WinterTyreViewController *winterVC = [[WinterTyreViewController alloc] init];
//    BaseNavigation *winterNav = [[BaseNavigation alloc] initWithRootViewController:winterVC];
//
//    MyViewController *myVC = [[MyViewController alloc] init];
//    BaseNavigation *myNav = [[BaseNavigation alloc] initWithRootViewController:myVC];
//    self.viewControllers = @[homeNav, nearbyNav, winterNav, myNav];
//}
//
//- (void)creatItems{
//
//    NSArray *titleArray = @[@"首页", @"附近", @"分类", @"我的"];
//    NSArray *selectImageNameArray = @[@"首页2", @"ic_fujin", @"ic_shangpin_xuanzhong", @"ic_my"];
//    NSArray *unSelectImageNameArray = @[@"ic_index", @"门店", @"ic_shangpin", @"我的"];
//    for (int i = 0; i<self.tabBar.items.count; i++) {
//
//        UITabBarItem *item = self.tabBar.items[i];
//        item.title = titleArray[i];
//        UIImage *selectImage = [UIImage imageNamed:selectImageNameArray[i]];
//        selectImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        UIImage *unSeletImage = [UIImage imageNamed:unSelectImageNameArray[i]];
//        unSeletImage = [unSeletImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        item.selectedImage = selectImage;
//        item.image = unSeletImage;
//
//        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
//        UIColor *titleHightedColor = LOGINBACKCOLOR;
//        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:titleHightedColor, NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
//    }
//}

-(void)setController:(UIViewController *)controller title:(NSString *)title imageString:(NSString *)image selectedImageString:(NSString *)selectedImageString
{
    BaseNavigation *nav = [[BaseNavigation alloc] initWithRootViewController:controller];
    nav.tabBarItem.image = [[UIImage imageNamed:image]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    nav.tabBarItem.selectedImage=[[UIImage imageNamed:selectedImageString]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    nav.navigationBar.titleTextAttributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil];
    controller.title=title;
    
    NSDictionary *dictHome = [NSDictionary dictionaryWithObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    [nav.tabBarItem setTitleTextAttributes:dictHome forState:UIControlStateSelected];
    [self addChildViewController:nav];
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

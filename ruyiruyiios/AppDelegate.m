  //
//  AppDelegate.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/7.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarViewController.h"
#import "WelcomeViewController.h"
#import "DBRecorder.h"
#import "FMDBCarFactory.h"
#import "FMDBCarBrand.h"
#import "FMDBCarVerhicle.h"
#import "FMDBCarTireInfo.h"
#import "FMDBCarTireType.h"
#import "MyQuotaViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "MBProgressHUD+YYM_category.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
//    MyQuotaViewController *carInfoVC = [[MyQuotaViewController alloc] init];
//    UINavigationController *carNav = [[UINavigationController alloc] initWithRootViewController:carInfoVC];
//    self.window.rootViewController = carNav;
    if (![[NSUserDefaults standardUserDefaults] valueForKey:@"isFirst"]) {

        NSString *timeStr = @"1970-01-01 11:31:03";
        [self databaseOperation:timeStr];
        WelcomeViewController *welcomeVC = [[WelcomeViewController alloc] init];
        UINavigationController *welNav = [[UINavigationController alloc] initWithRootViewController:welcomeVC];
        welNav.delegate = self;
        self.window.rootViewController = welNav;
    }else{

        MainTabBarViewController *mainTabVC = [[MainTabBarViewController alloc] init];
        self.window.rootViewController = mainTabVC;
    }
    NSLog(@"开始执行请求数据和插入数据库操作");
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            if ([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"9000"]) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"payStatus" object:nil];
            }else{
                
                [MBProgressHUD showTextMessage:@"支付宝支付失败"];
            }
        }];
    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            if ([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"9000"]) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"payStatus" object:nil];
            }else{
                
                [MBProgressHUD showTextMessage:@"支付宝支付失败"];
            }
        }];
    }
    return YES;
}

- (void)databaseOperation:(NSString *)timeStr{
    
    //get CarFactory Data
    [self getCarFactoryData:timeStr];
    //get CarBrand Data
    [self getCarBrandData:timeStr];
    //get CarType Data
    [self getCarVerhicleData:timeStr];
    //get carTireInfo Data
    [self getCarTireInfoData:timeStr];
    //get carTireType
    [self getCarTireTypeData:timeStr];
    //get all Position
    [self getAllPosition:timeStr];
}

- (void)getCarFactoryData:(NSString *)timeStr{

    NSDictionary *factoryPostDic = @{@"time":timeStr};
    NSString *factoryReqJson = [PublicClass convertToJsonData:factoryPostDic];
    [JJRequest postRequest:@"getCarFactoryData" params:@{@"reqJson":factoryReqJson} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {

        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        if ([statusStr isEqualToString:@"-1"]) {

            NSLog(@"获取数据失败");
        }else{
            
            dispatch_queue_t factoryQueue = dispatch_queue_create("insetCarFactoryData", NULL);
            dispatch_async(factoryQueue, ^{

                [DBRecorder insertFactoryArray:data];
            });
        }
    } failure:^(NSError * _Nullable error) {

        NSLog(@"请求车辆品牌数据错误:%@", error);
    }];
}

- (void)getCarBrandData:(NSString *)timeStr{
    
    NSDictionary *brandPostDic = @{@"time":timeStr};
    NSString *brandReqJson = [PublicClass convertToJsonData:brandPostDic];
    [JJRequest postRequest:@"getCarBrandData" params:@{@"reqJson":brandReqJson} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        if ([statusStr isEqualToString:@"-1"]) {
            
            NSLog(@"获取数据失败");
        }else{
            
//            YLog(@"getCarBrandData:%@", data);
            dispatch_queue_t brandQueue = dispatch_queue_create("insertCarBrandData", NULL);
            dispatch_async(brandQueue, ^{

                [DBRecorder insertBrandArray:data];
            });
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"请求车辆图标数据错误:%@", error);
    }];
}

- (void)getCarVerhicleData:(NSString *)timeStr{
    
    NSDictionary *verhiclePostDic = @{@"time":timeStr};
    NSString *verhicleReqJson = [PublicClass convertToJsonData:verhiclePostDic];
    [JJRequest postRequest:@"getCarVerhicleData" params:@{@"reqJson":verhicleReqJson} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        if ([statusStr isEqualToString:@"-1"]) {
            
            NSLog(@"获取数据失败");
        }else{
            
//            YLog(@"getCarTypeData:%@", data);
            dispatch_queue_t verhicleQueue = dispatch_queue_create("insertCarVerhicleData", NULL);
            dispatch_async(verhicleQueue, ^{

                [DBRecorder insertVerhicleArray:data];
            });
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"请求车辆型号数据错误:%@", error);
    }];
}

- (void)getCarTireInfoData:(NSString *)timeStr{
    
    NSDictionary *tireInfoPostDic = @{@"time":timeStr};
    NSString *tireInfoReqJson = [PublicClass convertToJsonData:tireInfoPostDic];
    [JJRequest postRequest:@"getCarTireInfoData" params:@{@"reqJson":tireInfoReqJson} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        if ([statusStr isEqualToString:@"-1"]) {
            
            NSLog(@"获取数据失败");
        }else{
            
//            YLog(@"getCarTireInfoData:%@", data);
            dispatch_queue_t tireInfoQueue = dispatch_queue_create("insertCarTireInfoData", NULL);
            dispatch_async(tireInfoQueue, ^{

                [DBRecorder insertTireInfoArray:data];
                NSLog(@"插入数据库完成");
            });
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"请求车辆轮胎和排量数据错误:%@", error);
    }];
}

- (void)getCarTireTypeData:(NSString *)timeStr{
    
    NSDictionary *tireTypePostDic = @{@"time":timeStr};
    NSString *tireTypeReqJson = [PublicClass convertToJsonData:tireTypePostDic];
    [JJRequest postRequest:@"getTireType" params:@{@"reqJson":tireTypeReqJson} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        if ([statusStr isEqualToString:@"-1"]) {
            
            NSLog(@"获取数据失败");
        }else{
            
//            YLog(@"getCarTireTypeData:%@", data);
            dispatch_queue_t tireTypeQueue = dispatch_queue_create("insertCarTireTypeData", NULL);
            dispatch_async(tireTypeQueue, ^{

                [DBRecorder insertTireTypeArray:data];
            });
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"请求轮胎类型数据错误:%@", error);
    }];
}

- (void)getAllPosition:(NSString *)timeStr{
    
    NSDictionary *positionPostDic = @{@"time":timeStr};
    NSString *positionReqJson = [PublicClass convertToJsonData:positionPostDic];
    [JJRequest postRequest:@"getAllPositon" params:@{@"reqJson":positionReqJson} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        if ([statusStr isEqualToString:@"-1"]) {
            
            NSLog(@"获取数据失败");
        }else{
            
//            YLog(@"getPositionData:%@", data);
            dispatch_queue_t positionQueue = dispatch_queue_create("insertPositionData", NULL);
            dispatch_async(positionQueue, ^{
                
                [DBRecorder insertPositionArray:data];
//                NSLog(@"插入数据库完成");
            });
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"请求车辆轮胎和排量数据错误:%@", error);
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    //do nothing
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    NSString *className = [NSString stringWithFormat:@"%@", [viewController class]];
    NSLog(@"当前ViewController名称:%@", className);
    [navigationController setNavigationBarHidden:NO animated:animated];
    [navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    navigationController.navigationBar.shadowImage = [UIImage new];
    navigationController.navigationBar.translucent = YES;
    navigationController.view.backgroundColor = LOGINBACKCOLOR;
    navigationController.navigationBar.backgroundColor = LOGINBACKCOLOR;
//    navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"Helvetica-Bold" size:22.0f], NSFontAttributeName, nil];
}

@end

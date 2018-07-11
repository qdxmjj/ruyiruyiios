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
#import "TobeEvaluatedViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "MBProgressHUD+YYM_category.h"
#import "MBProgressHUD+YYM_category.h"

@interface AppDelegate (){
    
    NSDictionary *_data;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
//    NSLog(@"%@", [DBRecorder getAllBrandData]);
    [WXApi registerApp:WEIXINID];
    
    //检测版本更新，新版本提醒
//    [self checkVersion];
    
    if (@available(iOS 11.0,*)) {
        
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
    }
    
//    TobeEvaluatedViewController *carInfoVC = [[TobeEvaluatedViewController alloc] init];
//    UINavigationController *carNav = [[UINavigationController alloc] initWithRootViewController:carInfoVC];
//    self.window.rootViewController = carNav;
    if (![[NSUserDefaults standardUserDefaults] valueForKey:@"isFirst"]) {

        WelcomeViewController *welcomeVC = [[WelcomeViewController alloc] init];
        UINavigationController *welNav = [[UINavigationController alloc] initWithRootViewController:welcomeVC];
        welNav.delegate = self;
        self.window.rootViewController = welNav;
    }else{

        MainTabBarViewController *mainTabVC = [[MainTabBarViewController alloc] init];
        self.window.rootViewController = mainTabVC;
    }

    if (![[NSUserDefaults standardUserDefaults] valueForKey:@"insertCompletion"]) {

        NSLog(@"开始执行请求数据和插入数据库操作");
        NSString *timeStr = @"1970-01-01 11:31:03";
        [self databaseOperation:timeStr];
    }
    return YES;
}

- (void)checkVersion{
    
    //app store生成的地址
    NSString *URL = @"https://itunes.apple.com/lookup?id=1076141152";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = nil;
    NSData *recervedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    NSString *results = [[NSString alloc] initWithBytes:[recervedData bytes] length:[recervedData length] encoding:NSUTF8StringEncoding];
    //NSLog(@"%@",results);
    NSData *data = [results dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    //NSLog(@"%@",dic);
    _data = dic;
    NSArray *infoArray = [dic objectForKey:@"results"];
    if ([infoArray count]) {
        NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
        NSString *lastVersion = [releaseInfo objectForKey:@"version"];
        
        // 取当前版本的版号
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *currentVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        NSLog(@"appstorversion:%@  产品版本:%@",lastVersion,currentVersion);
        if ([currentVersion compare:lastVersion]==NSOrderedAscending) {// 比对版本号
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"新版本" message:@"是否前往更新" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                UIApplication *application = [UIApplication sharedApplication];
                NSString *url = _data[@"results"][0][@"trackViewUrl"];
                [application openURL:[NSURL URLWithString:url]];
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                
            }];
            [alertController addAction:ok];
            [alertController addAction:cancel];
        }
    }
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
    [WXApi handleOpenURL:url delegate:self];
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
    [WXApi handleOpenURL:url delegate:self];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    [WXApi handleOpenURL:url delegate:self];
    return YES;
}

#pragma mark WXApiDelegate
- (void)onResp:(BaseResp *)resp{
    
    //WXSuccess           = 0,    /**< 成功    */
    //WXErrCodeCommon     = -1,   /**< 普通错误类型    */
    //WXErrCodeUserCancel = -2,   /**< 用户点击取消并返回    */
    //WXErrCodeSentFail   = -3,   /**< 发送失败    */
    //WXErrCodeAuthDeny   = -4,   /**< 授权失败    */
    //WXErrCodeUnsupport  = -5,   /**< 微信不支持    */
    
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        
        if (resp.errCode == 0) {
            
            SendAuthResp *resp2 = (SendAuthResp *)resp;
            NSDictionary *dict = @{@"key":resp2.code};
            [[NSNotificationCenter defaultCenter] postNotificationName:@"weiXinLoginCallBack" object:nil userInfo:dict];
        }else{
            
            [MBProgressHUD showTextMessage:@"微信登录失败!"];
        }
    }else{
        
        if (resp.errCode == 0) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"payStatus" object:nil];
        }else if (resp.errCode == -1){
            
            [MBProgressHUD showTextMessage:@"普通错误类型"];
        }else if (resp.errCode == -2){
            
            [MBProgressHUD showTextMessage:@"用户点击取消并返回"];
        }else if (resp.errCode == -3){
            
            [MBProgressHUD showTextMessage:@"发送失败"];
        }else if (resp.errCode == -4){
            
            [MBProgressHUD showTextMessage:@"授权失败"];
        }else if (resp.errCode == -5){
            
            [MBProgressHUD showTextMessage:@"微信不支持"];
        }
    }
}

- (void)databaseOperation:(NSString *)timeStr{
    
    [self getCarFactoryData:timeStr];
    [self getCarBrandData:timeStr];
    [self getCarVerhicleData:timeStr];
    [self getCarTireTypeData:timeStr];
    [self getAllPosition:timeStr];
//    dispatch_queue_t getTimeQueue = dispatch_queue_create("getTimeQueue", NULL);
//    dispatch_async(getTimeQueue, ^{
//
//        NSString *factoryTimeStr = [DBRecorder getFactoryTime];
//        NSString *brandTimeStr = [DBRecorder getBrandTime];
//        NSString *carVerhicleTimeStr = [DBRecorder getVerhicleTime];
//        NSString *carTireTypeTimeStr = [DBRecorder getTiretypeTime];
//        NSString *positionTimeStr = [DBRecorder getPositionTime];
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//            //get CarFactory Data
//            if (factoryTimeStr == NULL) {
//
//                [self getCarFactoryData:timeStr];
//            }else{
//
//                [self getCarFactoryData:factoryTimeStr];
//            }
//
//            //get CarBrand Data
//            if (brandTimeStr == NULL) {
//
//                [self getCarBrandData:timeStr];
//            }else{
//
//                [self getCarBrandData:brandTimeStr];
//            }
//
//            //get CarVerhicle Data
//            if (carVerhicleTimeStr == NULL) {
//
//                [self getCarVerhicleData:timeStr];
//            }else{
//
//                [self getCarVerhicleData:carVerhicleTimeStr];
//            }
//
//            //    //get carTireInfo Data
//            //    [self getCarTireInfoData:timeStr];
//            //get carTireType
//            if (carTireTypeTimeStr == NULL) {
//
//                [self getCarTireTypeData:timeStr];
//            }else{
//
//                [self getCarTireTypeData:carTireTypeTimeStr];
//            }
//
//            //get all Position
//            if (positionTimeStr == nil) {
//
//                [self getAllPosition:timeStr];
//            }else{
//
//                [self getAllPosition:positionTimeStr];
//            }
//        });
//    });
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

//                NSLog(@"%@", data);
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
//                NSLog(@"插入数据库完成");
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
                NSLog(@"数据库插入完成");
                [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"insertCompletion"];
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

//
//  FirstStartConfiguration.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/9/6.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "FirstStartConfiguration.h"
#import "DBRecorder.h"
#import "FMDBCarFactory.h"
#import "FMDBCarBrand.h"
#import "FMDBCarVerhicle.h"
#import "FMDBCarTireInfo.h"
#import "FMDBCarTireType.h"
#import <AFNetworkReachabilityManager.h>
#import "MBProgressHUD+YYM_category.h"

@interface FirstStartConfiguration ()

@property(nonatomic,assign)BOOL firstRequest;

@end
@implementation FirstStartConfiguration

-(void)StartConfigurationDataAndNetwork{
    
    /* 说明
     * 每次启动都需要去请求 必须的数据
     * app首次安装的时候 请求数据 使用 默认时间 1970.00.00
     * 非首次安装启动 先去数据库 查询 最新的一条数据时间 time
     * 非首次安装启动 根据查询到的时间 查询 最新的数据时间 之后的数据
     * 如果 根据 新时间 查询  有更新的数据 就更新插入数据库
     */
    
    BOOL firstInsertData; //判断是否是 第一次安装app

    self.firstRequest = YES;//每次打开app只允许 请求一遍数据
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"insertCompletion"]) {
        
        firstInsertData = NO;
    }else{
        
        firstInsertData = YES;
    }
    
    //AFN网络监听通知  每次网络状态改变都会执行
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"当前网络为wifi");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                
                NSLog(@"当前网络为蜂窝数据");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                
                NSLog(@"网络异常,请检查网络是否可用！");
                break;
            default:
                NSLog(@"网络异常,请检查网络是否可用！");
                break;
        }
        
        if (status == AFNetworkReachabilityStatusUnknown || status == AFNetworkReachabilityStatusReachableViaWiFi || status == AFNetworkReachabilityStatusReachableViaWWAN) {
            
            //app启动期间 只获取一次数据
            if (self.firstRequest) {
                [self configCarInfoWithCityInfo:firstInsertData];
            }
        }else{
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"设置网络" message:@"网络连接失败，请检查网络连接是否开启。如果网络连接已开启，app亦不可连接网络，可点击下方设置按钮前往设置网络，点击无线数据-选择WLAN与蜂窝移动网，即可允许此app访问网络！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                if (@available(iOS 10.0, *)) {
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
                        
                        NSLog(@"%@",success == YES? @"YES":@"NO");
                    }];
                    
                } else {
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                }
            }];
            [alertController addAction:ok];
            [alertController addAction:cancel];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

-(void)configCarInfoWithCityInfo:(BOOL)firstInsert{
    
    __block NSString *time = @"1970-01-01 11:31:03"; //首次启动 使用默认时间 获取全部数据

    dispatch_queue_t queue = dispatch_queue_create("xmjjQueue.com", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_t groupGCD = dispatch_group_create();
    
    dispatch_group_async(groupGCD, queue, ^{
        
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        
        if (!firstInsert) {
            //不是首次启动 获取 排序后的时间  通过时间来获取  时间段内 更新的数据
            NSInteger timestamp = [[DBRecorder getFactoryTime] integerValue];
            time = [PublicClass timestampSwitchTime:timestamp andFormatter:@"YYYY-MM-dd HH:mm:ss"];
        }else{
        }
        
        NSDictionary *factoryPostDic = @{@"time":time};
        NSString *factoryReqJson = [PublicClass convertToJsonData:factoryPostDic];
        [JJRequest postRequest:@"getCarFactoryData" params:@{@"reqJson":factoryReqJson} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
            
            NSString *statusStr = [NSString stringWithFormat:@"%@", code];
            if ([statusStr isEqualToString:@"-1"]) {
                
                NSLog(@"获取数据失败");
            }else{
                
                NSLog(@"请求车辆品牌数据成功");
                dispatch_semaphore_signal(semaphore);
                if ([data count] > 0) {
                    [DBRecorder insertFactoryArray:data];
                }
            }
            
        } failure:^(NSError * _Nullable error) {
            
            NSLog(@"请求车辆品牌数据错误:%@", error);
        }];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    
    dispatch_group_async(groupGCD, queue, ^{
        
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        
        if (!firstInsert) {
            //不是首次启动 获取 排序后的时间  通过时间来获取  时间段内 更新的数据
            NSInteger timestamp = [[DBRecorder getBrandTime] integerValue];
            time = [PublicClass timestampSwitchTime:timestamp andFormatter:@"YYYY-MM-dd HH:mm:ss"];
        }else{
        }
        
        NSDictionary *brandPostDic = @{@"time":time};
        NSString *brandReqJson = [PublicClass convertToJsonData:brandPostDic];
        [JJRequest postRequest:@"getCarBrandData" params:@{@"reqJson":brandReqJson} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
            
            NSString *statusStr = [NSString stringWithFormat:@"%@", code];
            if ([statusStr isEqualToString:@"-1"]) {
                
                NSLog(@"获取数据失败");
            }else{
                
                NSLog(@"请求车辆图标数据成功");
                dispatch_semaphore_signal(semaphore);
                if ([data count] > 0) {
                    [DBRecorder insertBrandArray:data];
                }
            }
            
        } failure:^(NSError * _Nullable error) {
            
            NSLog(@"请求车辆图标数据错误:%@", error);
        }];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    
    dispatch_group_async(groupGCD, queue, ^{
        
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        
        if (!firstInsert) {
            //不是首次启动 获取 排序后的时间  通过时间来获取  时间段内 更新的数据
            NSInteger timestamp = [[DBRecorder getVerhicleTime] integerValue];
            time = [PublicClass timestampSwitchTime:timestamp andFormatter:@"YYYY-MM-dd HH:mm:ss"];
        }else{
        }
        
        NSDictionary *verhiclePostDic = @{@"time":time};
        NSString *verhicleReqJson = [PublicClass convertToJsonData:verhiclePostDic];
        [JJRequest postRequest:@"getCarVerhicleData" params:@{@"reqJson":verhicleReqJson} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
            
            NSString *statusStr = [NSString stringWithFormat:@"%@", code];
            if ([statusStr isEqualToString:@"-1"]) {
                
                NSLog(@"获取数据失败");
            }else{
                
                NSLog(@"请求车辆型号数据成功");
                dispatch_semaphore_signal(semaphore);
                if ([data count] > 0) {
                    [DBRecorder insertVerhicleArray:data];
                }
            }
            
        } failure:^(NSError * _Nullable error) {
            
            NSLog(@"请求车辆型号数据错误:%@", error);
        }];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    
    dispatch_group_async(groupGCD, queue, ^{
        
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        
        if (!firstInsert) {
            //不是首次启动 获取 排序后的时间  通过时间来获取  时间段内 更新的数据
            NSInteger timestamp = [[DBRecorder getTiretypeTime] integerValue];
            time = [PublicClass timestampSwitchTime:timestamp andFormatter:@"YYYY-MM-dd HH:mm:ss"];
        }else{
        }
        
        NSDictionary *tireTypePostDic = @{@"time":time};
        NSString *tireTypeReqJson = [PublicClass convertToJsonData:tireTypePostDic];
        [JJRequest postRequest:@"getTireType" params:@{@"reqJson":tireTypeReqJson} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
            
            NSString *statusStr = [NSString stringWithFormat:@"%@", code];
            if ([statusStr isEqualToString:@"-1"]) {
                
                NSLog(@"获取数据失败");
            }else{
                
                NSLog(@"请求车辆类型数据成功");
                dispatch_semaphore_signal(semaphore);
                if ([data count] > 0) {
                    [DBRecorder insertTireTypeArray:data];
                }
            }
            
        } failure:^(NSError * _Nullable error) {
            
            NSLog(@"请求轮胎类型数据错误:%@", error);
        }];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    
    dispatch_group_async(groupGCD, queue, ^{
        
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        
        if (!firstInsert) {
            //不是首次启动 获取 排序后的时间  通过时间来获取  时间段内 更新的数据
            NSInteger timestamp = [[DBRecorder getPositionTime] integerValue];
            time = [PublicClass timestampSwitchTime:timestamp andFormatter:@"YYYY-MM-dd HH:mm:ss"];
        }else{
        }
        
        NSDictionary *positionPostDic = @{@"time":time};
        NSString *positionReqJson = [PublicClass convertToJsonData:positionPostDic];
        [JJRequest postRequest:@"getAllPositon" params:@{@"reqJson":positionReqJson} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
            
            NSString *statusStr = [NSString stringWithFormat:@"%@", code];
            if ([statusStr isEqualToString:@"-1"]) {
                
                NSLog(@"获取数据失败");
            }else{
                NSLog(@"请求省县市数据成功");
                dispatch_semaphore_signal(semaphore);
                if ([data count] > 0) {
                    [DBRecorder insertPositionArray:data];
                }
            }
            
        } failure:^(NSError * _Nullable error) {
            
            NSLog(@"省县市数据错误:%@", error);
        }];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    
    dispatch_group_notify(groupGCD, queue, ^{
        
        NSLog(@"所有任务执行完毕");
        self.firstRequest = NO;//本次打开app 只允许请求一次
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"insertCompletion"];
    });
}

-(void)dealloc{
    
    NSLog(@"%s",__func__);
}
@end

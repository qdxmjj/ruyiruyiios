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

@implementation FirstStartConfiguration

-(void)StartConfigurationDataAndNetwork{
    
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"insertCompletion"]) {
        
        return;
    }
    
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusUnknown) {
            NSLog(@"未知网络");
            [self configCarInfoWithCityInfo];
        } else if (status == AFNetworkReachabilityStatusReachableViaWiFi){
            NSLog(@"当前网络为wifi");
            [self configCarInfoWithCityInfo];
        } else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
            NSLog(@"当前网络为蜂窝数据");
            [self configCarInfoWithCityInfo];
            
        } else if (status == AFNetworkReachabilityStatusNotReachable){
            // 网络异常操作
            NSLog(@"网络异常,请检查网络是否可用！");
            
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
}


-(void)configCarInfoWithCityInfo{
    
    NSString *time = @"1970-01-01 11:31:03";
    //串行队列null 并行DISPATCH_QUEUE_CONCURRENT
    dispatch_queue_t queue = dispatch_queue_create("xmjjQueue.com", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_t groupGCD = dispatch_group_create();//线程组
    
    dispatch_group_async(groupGCD, queue, ^{
        
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        NSDictionary *factoryPostDic = @{@"time":time};
        NSString *factoryReqJson = [PublicClass convertToJsonData:factoryPostDic];
        [JJRequest postRequest:@"getCarFactoryData" params:@{@"reqJson":factoryReqJson} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
            
            NSString *statusStr = [NSString stringWithFormat:@"%@", code];
            if ([statusStr isEqualToString:@"-1"]) {
                
                NSLog(@"获取数据失败");
            }else{
                
                NSLog(@"请求车辆品牌数据成功");
                dispatch_semaphore_signal(semaphore);
                [DBRecorder insertFactoryArray:data];
            }
            
        } failure:^(NSError * _Nullable error) {
            
            NSLog(@"请求车辆品牌数据错误:%@", error);
        }];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
    });
    
    dispatch_group_async(groupGCD, queue, ^{
        
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        
        NSDictionary *brandPostDic = @{@"time":time};
        NSString *brandReqJson = [PublicClass convertToJsonData:brandPostDic];
        [JJRequest postRequest:@"getCarBrandData" params:@{@"reqJson":brandReqJson} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
            
            NSString *statusStr = [NSString stringWithFormat:@"%@", code];
            if ([statusStr isEqualToString:@"-1"]) {
                
                NSLog(@"获取数据失败");
            }else{
                
                NSLog(@"请求车辆图标数据成功");
                dispatch_semaphore_signal(semaphore);
                [DBRecorder insertBrandArray:data];
            }
            
        } failure:^(NSError * _Nullable error) {
            
            NSLog(@"请求车辆图标数据错误:%@", error);
        }];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    
    dispatch_group_async(groupGCD, queue, ^{
        
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        
        NSDictionary *verhiclePostDic = @{@"time":time};
        NSString *verhicleReqJson = [PublicClass convertToJsonData:verhiclePostDic];
        [JJRequest postRequest:@"getCarVerhicleData" params:@{@"reqJson":verhicleReqJson} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
            
            NSString *statusStr = [NSString stringWithFormat:@"%@", code];
            if ([statusStr isEqualToString:@"-1"]) {
                
                NSLog(@"获取数据失败");
            }else{
                
                NSLog(@"请求车辆型号数据成功");
                dispatch_semaphore_signal(semaphore);
                [DBRecorder insertVerhicleArray:data];
            }
            
        } failure:^(NSError * _Nullable error) {
            
            NSLog(@"请求车辆型号数据错误:%@", error);
        }];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    
    dispatch_group_async(groupGCD, queue, ^{
        
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        
        NSDictionary *tireTypePostDic = @{@"time":time};
        NSString *tireTypeReqJson = [PublicClass convertToJsonData:tireTypePostDic];
        [JJRequest postRequest:@"getTireType" params:@{@"reqJson":tireTypeReqJson} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
            
            NSString *statusStr = [NSString stringWithFormat:@"%@", code];
            if ([statusStr isEqualToString:@"-1"]) {
                
                NSLog(@"获取数据失败");
            }else{
                
                NSLog(@"请求车辆类型数据成功");
                dispatch_semaphore_signal(semaphore);
                [DBRecorder insertTireTypeArray:data];
            }
            
        } failure:^(NSError * _Nullable error) {
            
            NSLog(@"请求轮胎类型数据错误:%@", error);
        }];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    
    dispatch_group_async(groupGCD, queue, ^{
        
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        
        NSDictionary *positionPostDic = @{@"time":time};
        NSString *positionReqJson = [PublicClass convertToJsonData:positionPostDic];
        [JJRequest postRequest:@"getAllPositon" params:@{@"reqJson":positionReqJson} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
            
            NSString *statusStr = [NSString stringWithFormat:@"%@", code];
            if ([statusStr isEqualToString:@"-1"]) {
                
                NSLog(@"获取数据失败");
            }else{
                NSLog(@"请求省县市数据成功");
                dispatch_semaphore_signal(semaphore);
                [DBRecorder insertPositionArray:data];
            }
            
        } failure:^(NSError * _Nullable error) {
            
            NSLog(@"省县市数据错误:%@", error);
        }];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    
    dispatch_group_notify(groupGCD, queue, ^{
        
        NSLog(@"所有任务执行完毕");
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"insertCompletion"];
    });
}


-(void)dealloc{
    
    
    NSLog(@"%s",__func__);
}
@end

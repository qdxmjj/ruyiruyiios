//
//  JJPositionObject.m
//  ruyiruyiios
//
//  Created by 姚永敏 on 2019/5/30.
//  Copyright © 2019 ruyiruyi. All rights reserved.
//

#import "JJPositionObject.h"

@implementation JJPositionObject

- (void)startPosition{
 
    [self locationManager];
}

- (CLLocationManager *)locationManager{
    
    if ([CLLocationManager locationServicesEnabled]) {

    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    [_locationManager requestAlwaysAuthorization];
    [_locationManager requestWhenInUseAuthorization];
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = 5.0;
    [_locationManager startUpdatingLocation];
    }
    return _locationManager;
}

#pragma mark - 定位失败
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSURL *settingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:settingURL options:@{} completionHandler:nil];
        } else {
            // Fallback on earlier versions
        }
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    [alert addAction:cancel];
    [alert addAction:ok];
    
    
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    [vc presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 定位成功
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    [_locationManager stopUpdatingLocation];
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f", currentLocation.coordinate.longitude] forKey:@"longitude"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f", currentLocation.coordinate.latitude] forKey:@"latitude"];

    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (placemarks.count >0) {
            
            CLPlacemark *placeMark = placemarks[0];
            NSString *currentCity = placeMark.subLocality;//2018.10.24 改为默认显示县 之前默认为市
            NSString *currentStr = placeMark.locality;
            if (!currentCity) {
                
                currentCity = @"定位失败";
            }
            //存储 当前定位的信息 县 手动选择城市会覆盖此字段
            
            [UserConfig userDefaultsSetObject:currentCity key:@"currentCity"];
            
            //存储 当前定位的信息 县 只做显示用 与 购买轮胎时使用  2019.05.09

            [UserConfig userDefaultsSetObject:currentCity key:@"positionCounty"];

            //存储 当前的城市 仅做显示 与 购买轮胎时使用  2019.05.09
            
            [UserConfig userDefaultsSetObject:currentStr key:@"selectCityName"];
            
        }else if (error == nil && placemarks.count){
            
            NSLog(@"NO location and error return");
        }else if (error){
            
            NSLog(@"location error:%@", error);
        }
    }];
}

@end

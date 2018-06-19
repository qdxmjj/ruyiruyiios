//
//  YMTools.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/11.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "YMTools.h"
#import <MapKit/MapKit.h>
#import "MBProgressHUD+YYM_category.h"
#import <CoreLocation/CoreLocation.h>
@implementation YMTools

+(NSMutableAttributedString *)priceWithRedString:(NSString *)red{
    
    NSString *redStr = [NSString stringWithFormat:@"合计： %@ 元",red];
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:redStr];
    
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[redStr rangeOfString:[NSString stringWithFormat:@"%@",red]]];
    
    return attributedStr;
}


//打开百度地图导航
+(void)openBaiDuMapWithAddress:(NSString *)address latitude:(NSString *)latitude longitude:(NSString *)longitude{
    
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://map/"]]) {
        
        [MBProgressHUD showTextMessage:@"未安装百度地图"];
        return;
    }
    
    NSString *currentLongitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"longitude"];
    NSString *currentLatitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"latitude"];

    
    NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin=%f,%f&destination=%f,%f&mode=driving&src=webapp.navi.yourCompanyName.yourAppName", [currentLatitude floatValue],[currentLongitude floatValue], [latitude floatValue], [longitude floatValue]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];


    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString]];

}

//打开高德地图导航
+(void)openGaoDeMapWithAddress:(NSString *)address latitude:(NSString *)latitude longitude:(NSString *)longitude{
    
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://map/"]]) {
        
        [MBProgressHUD showTextMessage:@"未安装高德地图"];
        return;
    }
    CLLocationCoordinate2D location;
    location.latitude= [latitude floatValue];
    location.longitude = [longitude floatValue];
    
    
    NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%f&lon=%f&dev=0&style=2",address,@"iosamap",location.latitude, location.longitude] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *myLocationScheme = [NSURL URLWithString:urlString];
    
     //iOS10以后,使用新API
    if (@available(iOS 10.0, *)) {
            
        [[UIApplication sharedApplication] openURL:myLocationScheme options:@{} completionHandler:^(BOOL success){
                
                
            NSLog(@"scheme调用结束");   
        }];
            
    }else{
            
        [[UIApplication sharedApplication] openURL:myLocationScheme];
    }
}


////打开苹果自带地图导航
+(void)openAppleMapWithAddress:(NSString *)address latitude:(NSString *)latitude longitude:(NSString *)longitude{
    //当前位置
    MKMapItem *mylocation = [MKMapItem mapItemForCurrentLocation];
    
    //前面填写纬度
    CLLocationCoordinate2D location;
    location.latitude= [latitude floatValue];
    location.longitude = [longitude floatValue];
    
    CLLocationCoordinate2D coords2 = CLLocationCoordinate2DMake(location.latitude,location.longitude);
    //目的地的位置
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coords2 addressDictionary:nil]];
    
    toLocation.name = address;
    
    NSArray *items = [NSArray arrayWithObjects:mylocation, toLocation, nil];
    NSDictionary *options = @{ MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsMapTypeKey: [NSNumber numberWithInteger:MKMapTypeStandard], MKLaunchOptionsShowsTrafficKey:@YES };
    //打开苹果自身地图应用，并呈现特定的item
    [MKMapItem openMapsWithItems:items launchOptions:options];
}

@end

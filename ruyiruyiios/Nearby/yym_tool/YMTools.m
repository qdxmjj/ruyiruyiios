//
//  YMTools.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/11.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "YMTools.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@implementation YMTools

+(NSMutableAttributedString *)priceWithRedString:(NSString *)red{
    
    NSString *redStr = [NSString stringWithFormat:@"合计： %@ 元",red];
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:redStr];
    
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[redStr rangeOfString:[NSString stringWithFormat:@"%@",red]]];
    
    return attributedStr;
}


////打开百度地图导航
//- (void)openBaiDuMap{
//    NSString *urlString =@"";
//    ///打开百度地图app
//    urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin=latlng:%f,%f|name:%@&destination=latlng:%f,%f|name:%@&mode=driving&region=%@&output=html",34.264642646862,108.95108518068,@"我的位置",39.98871,116.43234,@"天安门",@"吉林"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ;
//
//
//    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString]];
//
//}
//
////打开高德地图导航
//- (void)openGaoDeMap{
//
//    NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&poiname=%@&lat=%f&lon=%f&dev=1&style=2",@"app name", @"YGche", @"终点", @"", @""] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//
//    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString]];
//
//}
//
//
////打开苹果自带地图导航
//- (void)openAppleMap{
//
//    //起点
//    CLLocationCoordinate2D coords1 = CLLocationCoordinate2DMake(nil,nil);
//
//    MKMapItem *currentLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coords1 addressDictionary:nil]];
//
//    //目的地的位置
//
//    CLLocationCoordinate2D coords2 = CLLocationCoordinate2DMake(nil,nil);
//
//    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coords2 addressDictionary:nil]];
//
//    toLocation.name = @"";
//
//    NSArray *items = [NSArray arrayWithObjects:currentLocation, toLocation, nil];
//
//    NSDictionary *options = @{ MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsMapTypeKey: [NSNumber numberWithInteger:MKMapTypeStandard], MKLaunchOptionsShowsTrafficKey:@YES };
//
//    //打开苹果自身地图应用，并呈现特定的item
//
//    [MKMapItem openMapsWithItems:items launchOptions:options];
//
//}

@end

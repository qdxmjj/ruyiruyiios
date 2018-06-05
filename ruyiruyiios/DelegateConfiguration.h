//
//  DelegateConfiguration.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/22.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDBCarTireInfo.h"

@protocol LoginStatusDelegate

- (void)updateLoginStatus;

@end

@protocol CityNameDelegate

- (void)updateCityName:(NSString *)cityNameStr;
@end

@protocol RoadStatusDelegate
- (void)updateRoadStatusName:(NSString *)nameStr OftenId:(NSString *)oftenIdStr OnceId:(NSString *)onceIdStr NotId:(NSString *)notIdStr;
@end

@protocol CartypeStatusDelegate
- (void)updateTypeStatus:(FMDBCarTireInfo *)carTireInfo;
@end

@interface DelegateConfiguration : NSObject

@property(nonatomic, strong)NSMutableArray *loginStatusListeners;
@property(nonatomic, strong)NSMutableArray *roadStatusListeners;
@property(nonatomic, strong)NSMutableArray *CartypeStatusListeners;
@property(nonatomic, strong)NSMutableArray *cityNameListers;

+ (DelegateConfiguration *)sharedConfiguration;
+ (void)setSharedConfiguration:(DelegateConfiguration *)configuration;

- (void)registerLoginStatusChangedListener:(id<LoginStatusDelegate>)delegate;
- (void)unregisterLoginStatusChangedListener:(id<LoginStatusDelegate>)delegate;
- (void)changeLoginStatus;

- (void)registerRoadStatusChangedListener:(id<RoadStatusDelegate>)delegate;
- (void)unregisterRoadStatusChangedListener:(id<RoadStatusDelegate>)delegate;
- (void)changeRoadStatusName:(NSString *)nameStr OftenId:(NSString *)oftenIdStr OnceId:(NSString *)onceIdStr NotId:(NSString *)notIdStr;

- (void)registerCartypeStatusChangeListener:(id<CartypeStatusDelegate>)delegate;
- (void)unregisterCartypeStatusChangeListener:(id<CartypeStatusDelegate>)delegate;
- (void)changeCartypeStatusNumber:(FMDBCarTireInfo *)carTireInfo;

- (void)registercityNameListers:(id<CityNameDelegate>)delegate;
- (void)unregistercityNameListers:(id<CityNameDelegate>)delegate;
- (void)changecityNameNumber:(NSString *)city_Str;

@end

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

@protocol UpdateAddCarDelegate
- (void)updateAddCarNumber;
@end

@protocol SetDefaultCarDelegate
- (void)updateDefaultCar;
@end;

@interface DelegateConfiguration : NSObject

@property(nonatomic, strong)NSMutableArray *loginStatusListeners;
@property(nonatomic, strong)NSMutableArray *roadStatusListeners;
@property(nonatomic, strong)NSMutableArray *CartypeStatusListeners;
@property(nonatomic, strong)NSMutableArray *cityNameListers;
@property(nonatomic, strong)NSMutableArray *addCarListers;
@property(nonatomic, strong)NSMutableArray *defaultCarListers;

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

- (void)registercityNameListers:(id<CityNameDelegate>)delegate;//f注册代理  哪里注册代理 就在哪个页面释放
- (void)unregistercityNameListers:(id<CityNameDelegate>)delegate;//f释放代理
- (void)changecityNameNumber:(NSString *)city_Str;//f执行代理

- (void)registeraddCarListers:(id<UpdateAddCarDelegate>)delegate;
- (void)unregisteraddCarListers:(id<UpdateAddCarDelegate>)delegate;
- (void)changeaddCarNumber;

- (void)registerdefaultCarListers:(id<SetDefaultCarDelegate>)delegate;
- (void)unregisterdefaultCarListers:(id<SetDefaultCarDelegate>)delegate;
- (void)changedefaultCarNumber;

- (void)removeAllDelegateMutableA;

@end

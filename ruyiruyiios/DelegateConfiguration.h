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

//签订执行
- (void)registerLoginStatusChangedListener:(id<LoginStatusDelegate>)delegate;
//销毁代理
- (void)unregisterLoginStatusChangedListener:(id<LoginStatusDelegate>)delegate;
//注册代理
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


//当前退出登录模式 无法使用此移除方式  使用必出bug  因为 页面代理的签订是在页面首次加载出现的时候签订  而当前重新登录 并不会销毁之前已经初始化的界面 所以 调用 此移除方法 将会造成 所以页面代理无法执行

// 若要销毁对应代理方法 只需要在签订执行代理的页面 调用销毁方法即可
- (void)removeAllDelegateMutableA;

@end

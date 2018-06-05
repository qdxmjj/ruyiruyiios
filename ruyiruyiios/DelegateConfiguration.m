//
//  DelegateConfiguration.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/22.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "DelegateConfiguration.h"

static DelegateConfiguration *shareConfiguration = nil;

@implementation DelegateConfiguration

+ (DelegateConfiguration *)sharedConfiguration{
    
    if (shareConfiguration == nil) {
        
        [DelegateConfiguration setSharedConfiguration:[[DelegateConfiguration alloc] init]];
    }
    return shareConfiguration;
}

+ (void)setSharedConfiguration:(DelegateConfiguration *)configuration{
    
    if (configuration != shareConfiguration) {
        
        shareConfiguration = configuration;
    }
}

- (NSMutableArray *)loginStatusListeners{
    
    if (_loginStatusListeners == nil) {
        
        _loginStatusListeners = [[NSMutableArray alloc] init];
    }
    return _loginStatusListeners;
}

- (NSMutableArray *)roadStatusListeners{
    
    if (_roadStatusListeners == nil) {
        
        _roadStatusListeners = [[NSMutableArray alloc] init];
    }
    return _roadStatusListeners;
}

- (NSMutableArray *)CartypeStatusListeners{
    
    if (_CartypeStatusListeners == nil) {
        
        _CartypeStatusListeners = [[NSMutableArray alloc] init];
    }
    return _CartypeStatusListeners;
}

- (NSMutableArray *)cityNameListers{
    
    if (_cityNameListers == nil) {
        
        _cityNameListers = [[NSMutableArray alloc] init];
    }
    return _cityNameListers;
}

- (void)registerLoginStatusChangedListener:(id<RoadStatusDelegate>)delegate{
    
    if (delegate == nil) {
        
        return;
    }
    if (self.loginStatusListeners != nil) {
        
        if (![self.loginStatusListeners  containsObject:delegate]) {
            
            [self.loginStatusListeners addObject:delegate];
        }
    }
    NSLog(@"登录状态代理注册之后的数组值:%@", self.loginStatusListeners);
}

- (void)unregisterLoginStatusChangedListener:(id<RoadStatusDelegate>)delegate{
    
    if (delegate == nil) {
        
        return;
    }
    if (self.loginStatusListeners != nil) {
        
        if ([self.loginStatusListeners containsObject:delegate]) {
            
            [self.loginStatusListeners removeObject:delegate];
        }
    }
    NSLog(@"登录状态注销之后的数组值:%@", self.loginStatusListeners);
}

- (void)changeLoginStatus{
    
    NSLog(@"调用登录状态的delegateListers:%@", self.loginStatusListeners);
    for (int i = 0; i<self.loginStatusListeners.count; i++) {
        
        id<LoginStatusDelegate> delegate = [self.loginStatusListeners objectAtIndex:i];
        [delegate updateLoginStatus];
    }
}

- (void)registerRoadStatusChangedListener:(id<RoadStatusDelegate>)delegate{
    
    if (delegate == nil) {
        
        return;
    }
    if (self.roadStatusListeners != nil) {
        
        if (![self.roadStatusListeners containsObject:delegate]) {
            
            [self.roadStatusListeners addObject:delegate];
        }
    }
    NSLog(@"注册之后的数组值:%@", self.roadStatusListeners);
}

- (void)unregisterRoadStatusChangedListener:(id<RoadStatusDelegate>)delegate{
    
    if (delegate == nil) {
        
        return;
    }
    if (self.roadStatusListeners != nil) {
        
        if ([self.roadStatusListeners containsObject:delegate]) {
            
            [self.roadStatusListeners removeObject:delegate];
        }
    }
    NSLog(@"注销之后的数组值:%@", self.roadStatusListeners);
}

- (void)changeRoadStatusName:(NSString *)nameStr OftenId:(NSString *)oftenIdStr OnceId:(NSString *)onceIdStr NotId:(NSString *)notIdStr{
    
    NSLog(@"调用代理事件的delegateListers:%@",self.roadStatusListeners);
    for (int i = 0; i<self.roadStatusListeners.count; i++) {
        
        id<RoadStatusDelegate> delegate = [self.roadStatusListeners objectAtIndex:i];
        [delegate updateRoadStatusName:nameStr OftenId:oftenIdStr OnceId:onceIdStr NotId:notIdStr];
    }
}

- (void)registerCartypeStatusChangeListener:(id<CartypeStatusDelegate>)delegate{
    
    if (delegate == nil) {
        
        return;
    }
    if (self.CartypeStatusListeners != nil) {
        
        if (![self.CartypeStatusListeners containsObject:delegate]) {
            
            [self.CartypeStatusListeners addObject:delegate];
        }
    }
    NSLog(@"汽车类型代理注册之后的数组值:%@", self.CartypeStatusListeners);
}

- (void)unregisterCartypeStatusChangeListener:(id<CartypeStatusDelegate>)delegate{
    
    if (delegate == nil) {
        
        return;
    }
    if (self.CartypeStatusListeners != nil) {
        
        if ([self.CartypeStatusListeners containsObject:delegate]) {
            
            [self.CartypeStatusListeners removeObject:delegate];
        }
    }
    NSLog(@"汽车类型代理注销之后的数组:%@", self.CartypeStatusListeners);
}

- (void)changeCartypeStatusNumber:(FMDBCarTireInfo *)carTireInfo{
    
    NSLog(@"调用汽车类型代理事件的delegateListers:%@", self.CartypeStatusListeners);
    for (int i = 0; i<self.CartypeStatusListeners.count; i++) {
        
        id<CartypeStatusDelegate>delegate = [self.CartypeStatusListeners objectAtIndex:i];
        [delegate updateTypeStatus:carTireInfo];
    }
}

- (void)registercityNameListers:(id<CityNameDelegate>)delegate{
    
    if (delegate == nil) {
        
        return;
    }
    if (self.cityNameListers != nil) {
        
        if (![self.cityNameListers containsObject:delegate]) {
            
            [self.cityNameListers addObject:delegate];
        }
    }
    NSLog(@"城市名称代理注册之后的数组:%@", self.cityNameListers);
}

- (void)unregistercityNameListers:(id<CityNameDelegate>)delegate{
    
    if (delegate == nil) {
        
        return;
    }
    if (self.cityNameListers != nil) {
        
        if ([self.cityNameListers containsObject:delegate]) {
            
            [self.cityNameListers removeObject:delegate];
        }
    }
    NSLog(@"注销之后的城市名称数组值：%@", self.cityNameListers);
}

- (void)changecityNameNumber:(NSString *)city_Str{
    
    NSLog(@"城市名称调用代理事件的代理数组:%@", self.cityNameListers);
    for (int i = 0; i<self.cityNameListers.count; i++) {
        
        id<CityNameDelegate> delegate = [self.cityNameListers objectAtIndex:i];
        [delegate updateCityName:city_Str];
    }
}

@end

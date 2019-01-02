//
//  WinterTyreRequeset.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/14.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "WinterTyreRequeset.h"

@implementation WinterTyreRequeset

+(void)getServrceListWithInfo:(NSDictionary *)info succrss:(requestSuccessBlock)succrsshandler failure:(requestFailureBlock)failureHandler{
    
    [self postRequest:@"serviceInfo/showServicesList" params:@{@"reqJson":[PublicClass convertToJsonData:info],@"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if ([code longLongValue] ==1) {
            
            if (data == [NSNull null]) {
                
                data = @[];
            }
            succrsshandler(code,message,data);
        }
        
    } failure:^(NSError * _Nullable error) {
 
    }];
}

+(void)getStockListByServiceWithInfo:(NSDictionary *)info succrss:(requestSuccessBlock)succrsshandler failure:(requestFailureBlock)failureHandler{
    
    
    [self postRequest:@"stockInfo/queryStockListByService" params:@{@"reqJson":[PublicClass convertToJsonData:info]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
       
        if ([code longLongValue]==1) {
            
            if ([data isEqual:[NSNull null]]) {
                
                
            }else{
                succrsshandler(code,message,data);
            }
        }
        
    } failure:^(NSError * _Nullable error) {
        
        
    }];
    
}
@end

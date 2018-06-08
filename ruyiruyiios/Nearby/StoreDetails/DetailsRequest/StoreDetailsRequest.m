//
//  StoreDetailsRequest.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/5/31.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "StoreDetailsRequest.h"
#import "UserConfig.h"
#import "MBProgressHUD+YYM_category.h"
@implementation StoreDetailsRequest


+(void)getStoreAddedServicesWith:(NSDictionary *)info succrss:(requestSuccessBlock)succrsshandler failure:(requestFailureBlock)failureHandler{
    
    [self postRequest:@"getStoreAddedServices" params:@{@"reqJson":[PublicClass convertToJsonData:info],@"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if ([code longLongValue] ==1) {
            
            succrsshandler(code,message,data);
        }
        
//        [MBProgressHUD showTextMessage:message];
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

+(void)getStockListByStoreWithInfo:(NSDictionary *)info succrss:(requestSuccessBlock)succrsshandler failure:(requestFailureBlock)failureHandler{
    
    
    [self postRequest:@"stockInfo/queryStockListByStore" params:@{@"reqJson":[PublicClass convertToJsonData:info]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if ([code longLongValue] == 1) {
            
            
            succrsshandler(code,message,data);
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
    
}


+(void)getStoreInfoByStoreIdWithInfo:(NSDictionary *)info succrss:(requestSuccessBlock)succrsshandler failure:(requestFailureBlock)failureHandler{
    
    
    [self postRequest:@"getStoreInfoByStoreId" params:@{@"reqJson":[PublicClass convertToJsonData:info],@"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {

        if ([code longLongValue] == 1) {
            
            succrsshandler(code,message,data);
        }
        
//        [MBProgressHUD showTextMessage:message];
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}


+(void)getCommitByConditionWithInfo:(NSDictionary *)info succrss:(requestSuccessBlock)succrsshandler failure:(requestFailureBlock)failureHandler{
    
    
    [self postRequest:@"getCommitByCondition" params:@{@"reqJson":[PublicClass convertToJsonData:info],@"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if ([code longLongValue] == 1) {
            
            
            succrsshandler(code,message,data);
        }
        
        [MBProgressHUD showTextMessage:message];
        
    } failure:^(NSError * _Nullable error) {
        
        
        
    }];
    
    
    
    
    
    
}

@end

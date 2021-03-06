//
//  FJStoreReqeust.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/5/30.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "FJStoreReqeust.h"
#import "PublicClass.h"
#import "DBRecorder.h"
#import "MBProgressHUD+YYM_category.h"

@implementation FJStoreReqeust

+(void)getFJStoreByConditionWithInfo:(NSDictionary *)info succrss:(requestSuccessBlock)succrsshandler failure:(requestFailureBlock)failureHandler{
        
    [self postRequest:@"selectStoreByCondition" params:@{@"reqJson":[PublicClass convertToJsonData:info],@"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if ([code longLongValue] == 1) {
            
            succrsshandler(code,message,data);
        }else{
        
            [MBProgressHUD showTextMessage:@"筛选失败"];
            succrsshandler(code,message,nil);
        }
    } failure:^(NSError * _Nullable error) {
        
        failureHandler(error);
    }];
}

+(void)searchFjStoreByConditionWithInfo:(NSDictionary *)info succrss:(requestSuccessBlock)succrsshandler failure:(requestFailureBlock)failureHandler{
    
    
    [self postRequest:@"" params:@{@"reqJson":[PublicClass convertToJsonData:info]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
    } failure:^(NSError * _Nullable error) {
        
    }];
    
}


@end

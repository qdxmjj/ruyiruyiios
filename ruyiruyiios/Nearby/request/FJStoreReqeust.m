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
    
//    FMDBUserInfo *infos = [[DBRecorder getAllUserInfoData] objectAtIndex:0];
    
    if ([UserConfig token] ==nil) {
        
        [MBProgressHUD showTextMessage:@"请先登录！再刷新此页面"];
        return;
    }

    
    [self postRequest:@"selectStoreByCondition" params:@{@"reqJson":[PublicClass convertToJsonData:info],@"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if ([code longLongValue] == 1) {
            
            succrsshandler(code,message,data);
        }
        
//        [MBProgressHUD showTextMessage:message];
        
    } failure:^(NSError * _Nullable error) {
        
    }];
    
    
}



@end

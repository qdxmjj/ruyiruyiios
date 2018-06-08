//
//  StoreDetailsRequest.h
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/5/31.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "JJRequest.h"

@interface StoreDetailsRequest : JJRequest

+(void)getStoreAddedServicesWith:(NSDictionary *)info succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler;


+(void)getStockListByStoreWithInfo:(NSDictionary *)info succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler;

+(void)getStoreInfoByStoreIdWithInfo:(NSDictionary *)info succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler;

//获取全部评论
+(void)getCommitByConditionWithInfo:(NSDictionary *)info  succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler;
@end

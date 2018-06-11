//
//  FJStoreReqeust.h
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/5/30.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "JJRequest.h"

@interface FJStoreReqeust : JJRequest

+(void)getFJStoreByConditionWithInfo:(NSDictionary *)info succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler;

+(void)searchFjStoreByConditionWithInfo:(NSDictionary *)info succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler;

@end

//
//  WinterTyreRequeset.h
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/14.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "JJRequest.h"

@interface WinterTyreRequeset : JJRequest

//根据大类获取小类
+(void)getServrceListWithInfo:(NSDictionary *)info succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler;


//根据小类获取小类对应的商品

+(void)getStockListByServiceWithInfo:(NSDictionary *)info succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler;


@end

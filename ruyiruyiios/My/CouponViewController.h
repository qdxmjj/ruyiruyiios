//
//  CouponViewController.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/20.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "RootViewController.h"

@interface CouponViewController : RootViewController

@property(nonatomic, copy)NSString *couponTypeStr;

@property(nonatomic, copy)NSString  *storesID;//限制门店ID
//@property(nonatomic, copy)NSString  *positionsName;//限制地区名称
@property(nonatomic, copy)NSString  *rule;//限制商品名称

@property(nonatomic, strong)NSArray *commodityList;//所有的商品

@property(nonatomic, copy)void(^callBuyStore)(NSString *couponIdStr,NSString *typeIdStr, NSString *couponNameStr);

@end

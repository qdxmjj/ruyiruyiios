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

@property(nonatomic, copy)NSString  *rule;//限制商品名称

@property (nonatomic, copy) NSString *isSelect;///是否可以点击 1 可以点击 其他不可以

@property (nonatomic, copy) NSString *totalPrice;///购物车商品总价 -- 原始价格

@property(nonatomic, strong)NSArray *goodsNameArr;//购物车所有的商品名称

@property(nonatomic, copy)void(^callBuyStore)(NSString *couponIdStr,NSString *typeIdStr, NSString *couponNameStr);

@end

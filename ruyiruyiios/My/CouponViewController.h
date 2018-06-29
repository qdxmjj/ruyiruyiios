//
//  CouponViewController.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/20.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "RootViewController.h"

@interface CouponViewController : RootViewController

@property(nonatomic, strong)NSString *couponTypeStr;
@property(nonatomic, copy)void(^callBuyStore)(NSString *couponIdStr,NSString *typeIdStr, NSString *couponNameStr);

@end

//
//  WaitPaymentViewController.h
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/28.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "RootViewController.h"

@interface WaitPaymentViewController : RootViewController

//订单编号
@property(nonatomic,copy,nonnull)NSString *orderNo;

//订单类型
@property(nonatomic,copy,nonnull)NSString *orderType;

/**
 * 传0 返回到主页  传入1 返回到上一页
 */
@property(nonatomic,copy,nonnull)NSString *backStatus;

@end

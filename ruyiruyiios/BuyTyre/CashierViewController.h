//
//  CashierViewController.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/30.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "RootViewController.h"
#import "ShoeOrderInfo.h"
#import "WXApi.h"

@interface CashierViewController : RootViewController<WXApiDelegate>

@property(nonatomic, strong)NSString *orderNoStr;
@property(nonatomic, strong)NSString *totalPriceStr;
@property(nonatomic, strong)NSString *orderTypeStr;

@end

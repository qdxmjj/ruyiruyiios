//
//  CashierViewController.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/30.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "RootViewController.h"
#import "ShoeOrderInfo.h"

@interface CashierViewController : RootViewController

@property(nonatomic, strong)NSString *orderNoStr;
@property(nonatomic, strong)NSString *totalPriceStr;
@property(nonatomic, strong)NSString *userStatusStr;

@end

//
//  FreeChargeOrderViewController.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/7/7.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "RootViewController.h"

@interface FreeChargeOrderViewController : RootViewController

@property(nonatomic, strong)NSString *titleStr;
@property(nonatomic, strong)NSString *orderNoStr;
@property(nonatomic, strong)NSString *orderTypeStr;
@property(nonatomic, copy)void(^backOrderBlock)(NSString *update);

@end

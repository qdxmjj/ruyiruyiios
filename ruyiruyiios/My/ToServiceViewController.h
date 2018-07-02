//
//  ToServiceViewController.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/7/1.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "RootViewController.h"

@interface ToServiceViewController : RootViewController

@property(nonatomic, strong)NSString *titleStr;
@property(nonatomic, strong)NSString *orderNoStr;
@property(nonatomic, strong)NSString *orderTypeStr;
@property(nonatomic, copy)void (^callBackBlock)(NSString *);

@end

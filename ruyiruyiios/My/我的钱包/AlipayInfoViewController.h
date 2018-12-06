//
//  AlipayInfoViewController.h
//  ruyiRuyi
//
//  Created by 姚永敏 on 2018/10/17.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "RootViewController.h"

typedef void (^setingAlipayInfoBlock)(NSString *alipayPhone);


@interface AlipayInfoViewController : RootViewController

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *IDNumber;

@property(nonatomic,copy)NSString *account;


@property(nonatomic,copy)setingAlipayInfoBlock block;

@end

//
//  CompleteViewController.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/7/2.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "RootViewController.h"

@interface CompleteViewController : RootViewController

@property(nonatomic, strong)NSString *titleStr;
@property(nonatomic, strong)NSString *orderNoStr;
@property(nonatomic, strong)NSString *orderTypeStr;
@property(nonatomic, strong)NSString *addRightFlageStr;
@property(nonatomic, copy)void(^backTobeReplaceBlock)(NSString *updateStr);

@end

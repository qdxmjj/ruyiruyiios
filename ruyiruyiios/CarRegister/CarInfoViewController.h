//
//  CarInfoViewController.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/18.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "RootViewController.h"

@interface CarInfoViewController : RootViewController

@property(copy, nonatomic)void(^block)(NSString *);
@property(nonatomic, strong)NSString *user_car_idStr;
@property(nonatomic, assign)BOOL is_alter;

@end

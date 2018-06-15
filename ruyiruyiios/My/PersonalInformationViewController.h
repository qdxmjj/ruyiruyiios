//
//  PersonalInformationViewController.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/14.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "RootViewController.h"

@interface PersonalInformationViewController : RootViewController

@property(copy, nonatomic)void(^block)(NSString *);
@property(copy, nonatomic)void(^updateViewBlock)(NSString *);

@end

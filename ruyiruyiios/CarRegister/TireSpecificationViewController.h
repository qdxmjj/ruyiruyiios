//
//  TireSpecificationViewController.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/24.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "RootViewController.h"

@interface TireSpecificationViewController : RootViewController

@property(nonatomic, copy)void(^specificationBlock)(NSString *);

@end

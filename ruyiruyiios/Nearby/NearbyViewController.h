//
//  NearbyViewController.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/8.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "RootViewController.h"

@interface NearbyViewController : RootViewController

/**
 *条件内容
 */
@property(nonatomic,copy,nonnull)NSString *condition;

/**
 *条件ID
 */
@property(nonatomic,copy,nonnull)NSString *serviceType;

/**
 *push状态 默认0 进入新页面 1 POP返沪剧上一个页面
 */
@property(nonatomic,copy,nonnull)NSString *status;

@property(copy, nonatomic)void(^backBlock)(NSDictionary *);

@end

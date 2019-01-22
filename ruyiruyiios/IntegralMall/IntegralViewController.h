//
//  IntegralViewController.h
//  Menu
//
//  Created by 姚永敏 on 2018/12/19.
//  Copyright © 2018 YYM. All rights reserved.
//

#import "RootViewController.h"
NS_ASSUME_NONNULL_BEGIN
typedef void (^refreshBlock)(void);
@interface IntegralViewController : RootViewController

@property (nonatomic, copy) refreshBlock block;
@end

NS_ASSUME_NONNULL_END

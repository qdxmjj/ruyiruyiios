//
//  ChangeCouponViewController.h
//  Menu
//
//  Created by 姚永敏 on 2018/12/24.
//  Copyright © 2018 YYM. All rights reserved.
//

#import "RootViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^getIntegralInfoBlock)(void);
@interface ChangeCouponViewController : RootViewController

- (instancetype)initWithIntegral:(NSString *)integral;

@property (nonatomic, copy) getIntegralInfoBlock block;
@end

NS_ASSUME_NONNULL_END

//
//  LogisticsViewController.h
//  ruyiruyiios
//
//  Created by 姚永敏 on 2019/1/15.
//  Copyright © 2019 ruyiruyi. All rights reserved.
//

#import "RootViewController.h"
#import "integralOrderModel/LogisticsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LogisticsViewController : RootViewController

- (instancetype)initWithOrderLogisticsModel:(LogisticsModel *)model;

@end

NS_ASSUME_NONNULL_END

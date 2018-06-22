//
//  CouponRightView.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/20.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponInfo.h"

@interface CouponRightView : UIView

@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UILabel *limitLabel;
@property(nonatomic, strong)UILabel *startLabel;
@property(nonatomic, strong)UILabel *endLabel;

- (void)setdatatoViews:(CouponInfo *)counponInfo;

@end

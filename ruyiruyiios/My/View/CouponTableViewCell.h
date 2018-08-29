//
//  CouponTableViewCell.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/20.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponLeftView.h"
#import "CouponRightView.h"
#import "CouponInfo.h"

@interface CouponTableViewCell : UITableViewCell

@property(nonatomic, strong)CouponLeftView *leftView;
@property(nonatomic, strong)CouponRightView *rightView;

//old
- (void)setdatatoViews:(CouponInfo *)couponInfo couponType:(NSString *)couponTypeStr;

//new
- (void)setdatatoViews:(CouponInfo *)counponInfo commodityList:(NSArray *)commodityList storeID:(NSString *)storeID;

@end

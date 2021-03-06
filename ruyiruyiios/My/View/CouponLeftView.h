//
//  CouponLeftView.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/20.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponInfo.h"

@interface CouponLeftView : UIView

@property(nonatomic, strong)UIImageView *backImageV;
@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UIView *midView;
@property(nonatomic, strong)UILabel *useStateLabel;

//old
- (void)setdatatoViews:(CouponInfo *)counponInfo couponType:(NSString *)couponTypeStr;

//new
- (void)setdatatoViews:(CouponInfo *)counponInfo commodityList:(NSArray *)commodityList storeID:(NSString *)storeID;

@end

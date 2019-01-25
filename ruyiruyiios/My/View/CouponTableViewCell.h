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


- (void)setdatatoViews:(CouponInfo *)couponInfo;

-(void)setdatatoViews:(CouponInfo *)counponInfo goodsNameArr:(NSArray *)goodsNameArr totalPrice:(NSString *)totalPrice storeID:(NSString *)storeID;

@end

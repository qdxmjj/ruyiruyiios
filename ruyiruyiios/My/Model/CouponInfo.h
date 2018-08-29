//
//  CouponInfo.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/20.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CouponInfo : NSObject

@property(nonatomic, strong)NSNumber *callStatus;
@property(nonatomic, strong)NSString *couponName;
@property(nonatomic, strong)NSNumber *dateLine;
@property(nonatomic, strong)NSNumber *deadline;
@property(nonatomic, strong)NSString *endTime;
@property(nonatomic, strong)NSNumber *coupon_id;
@property(nonatomic, strong)NSString *nextCycleTime;
@property(nonatomic, strong)NSNumber *no;
@property(nonatomic, strong)NSString *orderNo;
@property(nonatomic, strong)NSString *platNumber;
@property(nonatomic, strong)NSNumber *salesId;
@property(nonatomic, strong)NSString *serviceEndDate;
@property(nonatomic, strong)NSString *startTime;
@property(nonatomic, strong)NSNumber *status;
@property(nonatomic, strong)NSString *statusList;
@property(nonatomic, strong)NSString *time;
@property(nonatomic, strong)NSNumber *type;
@property(nonatomic, strong)NSNumber *userCarId;
@property(nonatomic, strong)NSNumber *userId;
@property(nonatomic, strong)NSNumber *userShoeOrderId;
@property(nonatomic, strong)NSNumber *viewTypeId;

@property(nonatomic, strong)id storesName;//数组
@property(nonatomic, copy)NSString *positionsName;
@property(nonatomic, copy)NSString *rule;
@property(nonatomic, copy)NSString *storeIdList;// @"100,200,300" 多个  需要以， 隔开分割成数组

@end

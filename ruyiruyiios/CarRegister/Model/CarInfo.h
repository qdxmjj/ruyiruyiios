//
//  CarInfo.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/29.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarInfo : NSObject

@property (nonatomic, strong)NSNumber *avgTravelMileage;
@property (nonatomic, strong)NSNumber *carId;
@property (nonatomic, strong)NSString *carName;
@property (nonatomic, strong)NSNumber *credit;
@property (nonatomic, strong)NSNumber *currentTimes;
@property (nonatomic, strong)NSNumber *cxwy;
@property (nonatomic, strong)NSNumber *drivingLicenseDate;
@property (nonatomic, strong)NSString *font;
@property (nonatomic, strong)NSNumber *carInfoid;
@property (nonatomic, strong)NSString *insuranceDate;
@property (nonatomic, strong)NSString *insuranceImg;
@property (nonatomic, strong)NSNumber *isDefault;
@property (nonatomic, strong)NSNumber *isNewenergy;
@property (nonatomic, strong)NSString *maturityImg;
@property (nonatomic, strong)NSNumber *mileage;
@property (nonatomic, strong)NSNumber *nextTimes;
@property (nonatomic, strong)NSString *platNumber;
@property (nonatomic, strong)NSNumber *proCityId;
@property (nonatomic, strong)NSString *proCityName;
@property (nonatomic, strong)NSString *rear;
@property (nonatomic, strong)NSString *referee;
@property (nonatomic, strong)NSNumber *remain;
@property (nonatomic, strong)NSString *roadTxt;
@property (nonatomic, strong)NSNumber *serviceEndDate;
@property (nonatomic, strong)NSNumber *state;
@property (nonatomic, strong)NSNumber *surplusTravelTime;
@property (nonatomic, strong)NSString *time;
@property (nonatomic, strong)NSNumber *traveled;
@property (nonatomic, strong)NSString *traveledImgInverse;
@property (nonatomic, strong)NSString *traveledImgObverse;
@property (nonatomic, strong)NSNumber *userId;
@property (nonatomic, strong)NSNumber *serviceYearLength;

@property (nonatomic, strong)NSNumber *authenticatedState; ///1 认证 2 未认证

@end

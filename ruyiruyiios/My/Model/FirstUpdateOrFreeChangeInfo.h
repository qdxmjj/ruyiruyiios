//
//  FirstUpdateInfo.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/29.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FirstUpdateOrFreeChangeInfo : NSObject

@property(nonatomic, strong)NSString *userName;
@property(nonatomic, strong)NSString *userPhone;
@property(nonatomic, strong)NSString *platNumber;
@property(nonatomic, strong)NSString *firstChangeOrderVoList;
@property(nonatomic, strong)NSString *freeChangeOrderVoList;
@property(nonatomic, strong)NSString *storeName;
@property(nonatomic, strong)NSString *orderImg;
@property(nonatomic, strong)NSNumber *storeId;
@property(nonatomic, strong)NSString *orderTotalPrice;
@property(nonatomic, strong)NSString *shoeOrderVoList;
@property(nonatomic, strong)NSString *stockOrderVoList;
@property(nonatomic, strong)NSString *userCarShoeBarCodeList;
@property(nonatomic, strong)NSString *userCarShoeOldBarCodeList;

@property(nonatomic, strong)NSString *orderType;

@end

//
//  BuyTireData.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/1.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BuyTireData : NSObject

@property(nonatomic, strong)NSString *brand;
@property(nonatomic, strong)NSString *cxwyMaxPrice;
@property(nonatomic, strong)NSString *cxwyMinPrice;
@property(nonatomic, strong)NSString *cxwyPrice;
@property(nonatomic, strong)NSString *detailStr;
@property(nonatomic, strong)NSString *figure;
@property(nonatomic, strong)NSString *finalCxwyPrice;
@property(nonatomic, strong)NSString *load;
@property(nonatomic, strong)NSString *platNumber;
@property(nonatomic, strong)NSString *shoeDownImg;
@property(nonatomic, strong)NSNumber *shoeId;
@property(nonatomic, strong)NSString *shoeLeftImg;
@property(nonatomic, strong)NSString *shoeMiddleImg;
@property(nonatomic, strong)NSString *shoeRightImg;
@property(nonatomic, strong)NSString *shoeUpImg;
@property(nonatomic, strong)NSString *size;
@property(nonatomic, strong)NSString *speed;
@property(nonatomic, strong)NSString *userName;
@property(nonatomic, strong)NSString *userPhone;
@property(nonatomic, strong)NSString *shoeBasePrice;

@property(nonatomic, strong)id  cxwyPriceParamList;

@property(nonatomic, strong)id  cxwyPriceMap;

@end

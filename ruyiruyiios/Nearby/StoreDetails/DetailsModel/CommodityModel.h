//
//  CommodityModel.h
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/1.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommodityModel : NSObject

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,copy)NSString *imgUrl;
@property(nonatomic,copy)NSString *amount;
@property(nonatomic,copy)NSString *commodityID;

@property(nonatomic,copy)NSString *commodityNumber;

@property(nonatomic,copy)NSString *serviceId;

@property(nonatomic,copy)NSString *serviceTypeId;

@property(nonatomic,copy)NSString *system;//是否是特价商品 1特殊商品 其他不是
@property(nonatomic,copy)NSString *serviceDesc; //特价商品描述


@end

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
@property(nonatomic,copy)NSString *price;//商品现在的售价
@property(nonatomic,copy)NSString *imgUrl;
@property(nonatomic,copy)NSString *amount; /// 库存
@property(nonatomic,copy)NSString *commodityID;

@property(nonatomic,copy)NSString *commodityNumber;///自己添加的字段 选择的商品数量

@property(nonatomic,copy)NSString *serviceId;

@property(nonatomic,copy)NSString *serviceTypeId;

@property(nonatomic,copy)NSString *system;//是否是特价商品 1特殊商品 其他不是
@property(nonatomic,copy)NSString *serviceDesc; //特价商品描述

@property(nonatomic,copy)NSString *discountFlag; //是否是折扣商品
@property(nonatomic,copy)NSString *originalPrice; //原价
@property(nonatomic,copy)NSString *stockDesc; //商品描述


@end

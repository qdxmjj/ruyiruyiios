//
//  StockOrderVoInfo.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/7/1.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StockOrderVoInfo : NSObject

@property(nonatomic, strong)NSNumber *amount;
@property(nonatomic, strong)NSNumber *detailId;
@property(nonatomic, strong)NSString *detailImage;
@property(nonatomic, strong)NSString *detailName;
@property(nonatomic, strong)NSString *detailPrice;
@property(nonatomic, strong)NSNumber *detailServiceId;
@property(nonatomic, strong)NSNumber *detailServiceTypeId;
@property(nonatomic, strong)NSString *detailTotalPrice;

@end

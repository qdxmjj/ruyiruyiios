//
//  shoeOrderVo.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/8.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoeOrderVo : NSObject

@property(nonatomic, strong)NSNumber *cxwyAmount;
@property(nonatomic, strong)NSString *cxwyPrice;
@property(nonatomic, strong)NSString *cxwyTotalPrice;
@property(nonatomic, strong)NSNumber *cxwyType;
@property(nonatomic, strong)NSNumber *fontAmount;
@property(nonatomic, strong)NSString *fontPrice;
@property(nonatomic, strong)NSString *fontRearFlag;
@property(nonatomic, strong)NSString *fontShoeName;
@property(nonatomic, strong)NSString *fontTotalPrice;
@property(nonatomic, strong)NSNumber *rearAmount;
@property(nonatomic, strong)NSString *rearPrice;
@property(nonatomic, strong)NSString *rearShoeName;
@property(nonatomic, strong)NSString *rearTotalPrice;

@end

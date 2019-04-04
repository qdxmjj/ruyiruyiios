//
//  ManageCar.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/25.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManageCar : NSObject

@property(nonatomic, strong)NSString *car_brand;
@property(nonatomic, strong)NSNumber *car_id;
@property(nonatomic, strong)NSString *car_name;
@property(nonatomic, strong)NSNumber *is_default;
@property(nonatomic, strong)NSString *plat_number;
@property(nonatomic, strong)NSNumber *user_car_id;
@property(nonatomic, strong)NSString *authenticatedState; ///是否 认证  1 已认证 2未认证

@end

//
//  FMDBCarFactory.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/15.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMDBCarFactory : NSObject

@property(nonatomic, strong)NSNumber *carBrandId; //车标ID
@property(nonatomic, strong)NSString *factory;    //工厂
@property(nonatomic, strong)NSNumber *factoryId;         //车辆ID
@property(nonatomic, strong)NSNumber *system;
@property(nonatomic, strong)NSString *time;       //时间

@end

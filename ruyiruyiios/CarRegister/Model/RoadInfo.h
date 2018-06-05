//
//  RoadInfo.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/21.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoadInfo : NSObject

@property(nonatomic, strong)NSNumber *road_id;
@property(nonatomic, strong)NSString *road_description;
@property(nonatomic, strong)NSString *img;
@property(nonatomic, strong)NSString *name;
@property(nonatomic, strong)NSString *time;
@property(nonatomic, strong)NSNumber *typeIRate;
@property(nonatomic, strong)NSNumber *typeIiRate;
@property(nonatomic, strong)NSNumber *typeIiiRate;

@end

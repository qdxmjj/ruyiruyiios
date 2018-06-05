//
//  RoadInfo.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/21.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "RoadInfo.h"

@implementation RoadInfo

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        
        self.road_id = value;
    }
    if ([key isEqualToString:@"description"]) {
        
        self.road_description = value;
    }
}

@end

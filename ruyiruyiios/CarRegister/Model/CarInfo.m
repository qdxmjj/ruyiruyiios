//
//  CarInfo.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/29.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "CarInfo.h"

@implementation CarInfo

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        
        self.carInfoid = value;
    }
}

@end

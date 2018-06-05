//
//  TirePattern.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/31.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "TirePattern.h"

@implementation TirePattern

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"description"]) {
        
        self.tire_description = value;
    }
}

@end

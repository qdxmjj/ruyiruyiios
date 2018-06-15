//
//  CarCXWYInfo.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/13.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "CarCXWYInfo.h"

@implementation CarCXWYInfo

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        
        self.carCXWYInfoid = value;
    }
}

@end

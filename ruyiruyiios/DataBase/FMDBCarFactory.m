//
//  FMDBCarFactory.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/15.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "FMDBCarFactory.h"

@implementation FMDBCarFactory


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        
        self.factoryId = value;
    }
}

@end

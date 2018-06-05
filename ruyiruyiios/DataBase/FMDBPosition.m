//
//  FMDBPosition.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/23.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "FMDBPosition.h"

@implementation FMDBPosition

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        
        self.positionId = value;
    }
}

@end

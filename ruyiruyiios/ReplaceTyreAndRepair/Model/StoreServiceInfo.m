//
//  StoreServiceInfo.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/11.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "StoreServiceInfo.h"

@implementation StoreServiceInfo

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        
        self.serviceInfoId = value;
    }
}

@end

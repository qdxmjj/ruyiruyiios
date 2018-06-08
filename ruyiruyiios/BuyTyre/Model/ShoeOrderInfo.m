//
//  ShoeOrderInfo.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/6.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "ShoeOrderInfo.h"

@implementation ShoeOrderInfo

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        
        self.shoeOderinfo_id = value;
    }
}

@end

//
//  CreditLineCarInfo.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/21.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "CreditLineCarInfo.h"

@implementation CreditLineCarInfo

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        
        self.creditLine_id = value;
    }
}

@end

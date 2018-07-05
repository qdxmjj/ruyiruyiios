//
//  CXWYPriceParamInfo.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/7/4.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "CXWYPriceParamInfo.h"

@implementation CXWYPriceParamInfo

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        
        self.infoId = value;
    }
}

@end

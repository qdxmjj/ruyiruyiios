//
//  UserCarShoeOldBarCodeInfo.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/7/9.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "UserCarShoeOldBarCodeInfo.h"

@implementation UserCarShoeOldBarCodeInfo

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        
        self.infoId = value;
    }
}

@end

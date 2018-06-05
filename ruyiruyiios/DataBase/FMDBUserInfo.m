//
//  FMDBUserInfo.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/12.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "FMDBUserInfo.h"

@implementation FMDBUserInfo

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        
        self.user_id = value;
    }
}

@end

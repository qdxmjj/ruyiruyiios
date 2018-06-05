//
//  Lunbo_infos.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/17.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "Lunbo_infos.h"

@implementation Lunbo_infos

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        
        self.lun_id = value;
    }
}

@end

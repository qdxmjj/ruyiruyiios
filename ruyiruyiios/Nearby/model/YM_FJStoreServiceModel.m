//
//  YM_FJStoreServiceModel.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/5/30.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "YM_FJStoreServiceModel.h"

@implementation YM_FJStoreServiceModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        
        _serviceID = value;
    }
    
    
}

@end

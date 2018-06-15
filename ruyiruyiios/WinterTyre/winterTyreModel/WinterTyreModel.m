//
//  WinterTyreModel.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/14.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "WinterTyreModel.h"

@implementation WinterTyreModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"serviceTypeId"]) {
        
        _serviceTypeId = [NSString stringWithFormat:@"%@",value];
    }
    
    if ([key isEqualToString:@"stockTypeId"]) {
        
        _stockTypeId = [NSString stringWithFormat:@"%@",value];
    }
    
    
}

@end

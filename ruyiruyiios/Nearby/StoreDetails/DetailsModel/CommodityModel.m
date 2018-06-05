//
//  CommodityModel.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/1.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "CommodityModel.h"

@implementation CommodityModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        
        _commodityID = value;
    }
    
}

@end

//
//  IntegralGoodsMode.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2019/1/11.
//  Copyright © 2019年 ruyiruyi. All rights reserved.
//

#import "IntegralGoodsMode.h"

@implementation IntegralGoodsMode
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"description"]) {
        self.goods_description = value;
    }
}
@end

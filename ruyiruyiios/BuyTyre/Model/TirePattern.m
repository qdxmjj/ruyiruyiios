//
//  TirePattern.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/31.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "TirePattern.h"

@implementation TirePattern

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"description"]) {
        
        self.tire_description = value;
    }
}

-(CGSize )sectionTextSize{
    
    if (self.tire_description) {
        
        CGSize sizeToFit = [self.tire_description boundingRectWithSize:CGSizeMake(MAINSCREEN.width-70, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.f]} context:nil].size;
        
        return sizeToFit;
    }
    return CGSizeMake(0.1, 0.1);
}

@end

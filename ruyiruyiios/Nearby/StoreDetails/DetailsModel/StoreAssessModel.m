//
//  StoreAssessModel.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/6.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "StoreAssessModel.h"

@implementation StoreAssessModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"img1Url"]) {
        
        if ([self isUrlString:value]) {
            
            [self.contentimgArr addObject:value];

        }
    }
    
    if ([key isEqualToString:@"img2Url"]) {
        
        if ([self isUrlString:value]) {

            [self.contentimgArr addObject:value];
            
        }
        
    }
    
    if ([key isEqualToString:@"img3Url"]) {
        
        if ([self isUrlString:value]) {

            [self.contentimgArr addObject:value];
            
        }
        
    }
    
    if ([key isEqualToString:@"img4Url"]) {
        
        if ([self isUrlString:value]) {

            [self.contentimgArr addObject:value];
            
        }
        
    }
    
    if ([key isEqualToString:@"img5Url"]) {

        if ([self isUrlString:value]) {

            [self.contentimgArr addObject:value];
            
        }
    }
}

- (BOOL)isUrlString:(NSString *)urlStr{
    
    NSString *emailRegex = @"[a-zA-z]+://.*";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:urlStr];
    
}
-(NSMutableArray *)contentimgArr{
    
    if (!_contentimgArr) {
        
        _contentimgArr = [NSMutableArray array];
    }
    
    
    return _contentimgArr;
}

@end

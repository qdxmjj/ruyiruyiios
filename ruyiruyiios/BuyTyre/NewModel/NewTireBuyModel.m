//
//  NewTireBuyModel.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/8/14.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "NewTireBuyModel.h"

@implementation NewTireBuyModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"data"]) {
        
        self.dataArr = value;
    }
    
    
    
    
}
@end

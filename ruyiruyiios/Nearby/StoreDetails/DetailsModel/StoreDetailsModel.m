//
//  StoreDetailsModel.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/6.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "StoreDetailsModel.h"

@implementation StoreDetailsModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"storeServcieList"]) {
        
        self.storeServcieList = value;
    }
    
}

@end

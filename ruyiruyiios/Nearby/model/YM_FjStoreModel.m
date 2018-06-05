//
//  YM_FjStoreModel.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/5/30.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "YM_FjStoreModel.h"

@implementation YM_FjStoreModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"storeServcieList"]) {
        
        self.serviceList = value;
    }
}

@end

//
//  AddressInfoModel.m
//  ruyiruyiios
//
//  Created by 姚永敏 on 2019/1/7.
//  Copyright © 2019 ruyiruyi. All rights reserved.
//

#import "AddressInfoModel.h"

@implementation AddressInfoModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        
        self.address_id = value;
    }
}
@end

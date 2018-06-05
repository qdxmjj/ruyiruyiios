//
//  FMDBCarBrand.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/15.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "FMDBCarBrand.h"

@implementation FMDBCarBrand

@synthesize icon;
@synthesize brandId;
@synthesize imgUrl;
@synthesize name;
@synthesize system;
@synthesize time;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        
        self.brandId = value;
    }
}

@end

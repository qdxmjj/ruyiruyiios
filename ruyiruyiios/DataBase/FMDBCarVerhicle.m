//
//  FMDBCarVerhicle.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/16.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "FMDBCarVerhicle.h"

@implementation FMDBCarVerhicle

@synthesize carBrandId;
@synthesize carVersion;
@synthesize factoryId;
@synthesize verhicleId;
@synthesize system;
@synthesize time;
@synthesize verhicle;
@synthesize verify;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        
        self.verhicleId = value;
    }
}

@end

//
//  FMDBCarTireInfo.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/16.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "FMDBCarTireInfo.h"

@implementation FMDBCarTireInfo

@synthesize brand;
@synthesize carBrandId;
@synthesize font;
@synthesize tireInfoId;
@synthesize name;
@synthesize pailiang;
@synthesize price;
@synthesize rear;
@synthesize system;
@synthesize time;
@synthesize verhicle;
@synthesize verhicleId;
@synthesize year;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        
        self.tireInfoId = value;
    }
}

@end

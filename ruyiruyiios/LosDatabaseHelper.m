//
//  LosDatabaseHelper.m
//  iSmartWatch
//
//  Created by xujunquan on 16/8/11.
//  Copyright © 2016年 Gloria Guo. All rights reserved.
//

#import "LosDatabaseHelper.h"

@implementation LosDatabaseHelper{

    FMDatabaseQueue *queue;
}

-(id) init
{
    self = [super init];
    if(self){
        
        NSString *dbFilePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"db_CMBCC.sqlite"];
        queue = [FMDatabaseQueue databaseQueueWithPath:dbFilePath];
    }
    return self;
}

+(LosDatabaseHelper*) sharedInstance
{
    //多线程保护
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

-(void) inDatabase:(void(^)(FMDatabase*))block
{
    [queue inDatabase:^(FMDatabase *db){
        block(db);
    }];
}

- (void)inTransaction:(void(^)(FMDatabase *db, BOOL rollback))block{
    
    [queue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        
        block(db, rollback);
    }];
}

@end

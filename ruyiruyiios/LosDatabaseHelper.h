//
//  LosDatabaseHelper.h
//  iSmartWatch
//
//  Created by xujunquan on 16/8/11.
//  Copyright © 2016年 Gloria Guo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabaseQueue.h"

@interface LosDatabaseHelper : NSObject

+(LosDatabaseHelper*) sharedInstance;
-(void) inDatabase:(void(^)(FMDatabase*))block;
- (void)inTransaction:(void(^)(FMDatabase *db, BOOL rollback))block;
@end

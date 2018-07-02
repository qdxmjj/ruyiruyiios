//
//  DBRecorder.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/12.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "DBRecorder.h"
#import <FMDB.h>
#import "LosDatabaseHelper.h"

@implementation DBRecorder

+ (void)insertFactoryArray:(NSArray *)dataArray{
    
    LosDatabaseHelper *helper = [LosDatabaseHelper sharedInstance];
    [helper inTransaction:^(FMDatabase *db, BOOL rollback) {
        
        @try{
            
            if ([db open]) {
                
                [db setShouldCacheStatements:YES];
                if (![db tableExists:@"carFactory"]) {
                    
                    [db executeUpdate:@"CREATE TABLE carFactory(Id INTEGER PRIMARY KEY, carBrandId INTEGER, factory TEXT, factoryId INTEGER, system INTEGER, time TEXT)"];
                    NSLog(@"车辆品牌数据库创建完成!");
                }
                NSString *carBrand_Str, *factoryId_Str, *system_Str;
                for (NSDictionary *dataDic in dataArray) {
                    
                    FMDBCarFactory *carFactory = [[FMDBCarFactory alloc] init];
                    [carFactory setValuesForKeysWithDictionary:dataDic];
                    carBrand_Str = [NSString stringWithFormat:@"%ld", (long)[carFactory.carBrandId intValue]];
                    factoryId_Str = [NSString stringWithFormat:@"%ld", (long)[carFactory.factoryId intValue]];
                    system_Str = [NSString stringWithFormat:@"%ld", (long)[carFactory.system intValue]];
                    FMResultSet *factoryRs = [db executeQuery:@"select * from carFactory where factoryId = ?", factoryId_Str];
                    if ([factoryRs next]) {
                        
                        [db executeUpdate:@"update carFactory set carBrandId = ?, factory = ?, system = ?, time = ? where factoryId = ?", carBrand_Str, carFactory.factory, system_Str, carFactory.time, factoryId_Str];
                    }else{
                        
                        [db executeUpdate:@"insert into carFactory(carBrandId, factory, factoryId, system, time) values(?,?,?,?,?)", carBrand_Str, carFactory.factory, factoryId_Str, system_Str, carFactory.time];
                    }
                    [factoryRs close];
                }
            }
        }@catch(NSException *exception){
            
            
        }@finally{
            
            
        }
    }];
}

+ (NSArray *)getFactoryData:(NSNumber *)brandId{
    
    LosDatabaseHelper *helper = [LosDatabaseHelper sharedInstance];
    NSMutableArray *factoryArray = [[NSMutableArray alloc] init];
    [helper inTransaction:^(FMDatabase *db, BOOL rollback) {
        
        if ([db open]) {
            
            [db setShouldCacheStatements:YES];
            if (![db tableExists:@"carFactory"]) {
                
                [db executeUpdate:@"CREATE TABLE carFactory(Id INTEGER PRIMARY KEY, carBrandId INTEGER, factory TEXT, factoryId INTEGER, system INTEGER, time TEXT)"];
                NSLog(@"车辆品牌数据库创建完成!");
            }
            FMResultSet *factoryRs = [db executeQuery:@"select * from carFactory where carBrandId = ?", brandId];
            while ([factoryRs next]) {
                
                FMDBCarFactory *carFactory = [[FMDBCarFactory alloc] init];
                carFactory.carBrandId = [NSNumber numberWithInt:[factoryRs intForColumn:@"carBrandId"]];
                carFactory.factory = [factoryRs stringForColumn:@"factory"];
                carFactory.factoryId = [NSNumber numberWithInt:[factoryRs intForColumn:@"factoryId"]];
                carFactory.system = [NSNumber numberWithInt:[factoryRs intForColumn:@"system"]];
                carFactory.time = [factoryRs stringForColumn:@"time"];
                [factoryArray addObject:carFactory];
            }
            [factoryRs close];
        }else{
            
            NSLog(@"车辆品牌数据库打开失败");
        }
    }];
    return factoryArray;
}

+ (NSString *)getFactoryTime{
    
    LosDatabaseHelper *helper = [LosDatabaseHelper sharedInstance];
    __block NSArray *factoryPaixArray = [[NSArray alloc] init];
    [helper inTransaction:^(FMDatabase *db, BOOL rollback) {
        
        if ([db open]) {
            
            [db setShouldCacheStatements:YES];
            if (![db tableExists:@"carFactory"]) {
                
                [db executeUpdate:@"CREATE TABLE carFactory(Id INTEGER PRIMARY KEY, carBrandId INTEGER, factory TEXT, factoryId INTEGER, system INTEGER, time TEXT)"];
                NSLog(@"车辆品牌数据库创建完成!");
            }
            FMResultSet *factoryRs = [db executeQuery:@"select * from carFactory"];
            NSMutableArray *timeArray = [[NSMutableArray alloc] init];
            while ([factoryRs next]) {
                
                FMDBCarFactory *carFactory = [[FMDBCarFactory alloc] init];
                carFactory.carBrandId = [NSNumber numberWithInt:[factoryRs intForColumn:@"carBrandId"]];
                carFactory.factory = [factoryRs stringForColumn:@"factory"];
                carFactory.factoryId = [NSNumber numberWithInt:[factoryRs intForColumn:@"factoryId"]];
                carFactory.system = [NSNumber numberWithInt:[factoryRs intForColumn:@"system"]];
                carFactory.time = [factoryRs stringForColumn:@"time"];
                NSString *timeStr = [PublicClass timestampSwitchTime:[carFactory.time integerValue] andFormatter:@"YYYY-MM-dd HH:mm:ss"];
                [timeArray addObject:timeStr];
            }
            factoryPaixArray = [timeArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
                if (obj1 == [NSNull null]) {
                    obj1 = @"0000-00-00 00:00:00";
                }
                if (obj2 == [NSNull null]) {
                    obj2 = @"0000-00-00 00:00:00";
                }
                NSDate *date1 = [formatter dateFromString:obj1];
                NSDate *date2 = [formatter dateFromString:obj2];
                NSComparisonResult result = [date1 compare:date2];
                return result = NSOrderedAscending;
            }];
            [factoryRs close];
        }else{
            
            NSLog(@"车辆品牌数据库打开失败");
        }
    }];
    if (factoryPaixArray.count == 0) {
        
        return NULL;
    }else{
        
        return [factoryPaixArray objectAtIndex:0];
    }
}

+ (void)insertBrandArray:(NSArray *)dataArray{
    
    LosDatabaseHelper *helper = [LosDatabaseHelper sharedInstance];
    [helper inTransaction:^(FMDatabase *db, BOOL rollback) {
        
        if ([db open]) {
            
            [db setShouldCacheStatements:YES];
            if (![db tableExists:@"carBrand"]) {
                
                [db executeUpdate:@"CREATE TABLE carBrand(Id INTEGER PRIMARY KEY, icon TEXT, brandId INTEGER, imgUrl TEXT, name TEXT, system INTEGER, time TEXT)"];
                NSLog(@"车辆图标数据库创建完成!");
            }
            NSString *brandId_Str, *system_Str;
            for (NSDictionary *dataDic in dataArray) {
                
                FMDBCarBrand *carBrand = [[FMDBCarBrand alloc] init];
                [carBrand setValuesForKeysWithDictionary:dataDic];
                brandId_Str = [NSString stringWithFormat:@"%ld", (long)[carBrand.brandId intValue]];
                system_Str = [NSString stringWithFormat:@"%ld", (long)[carBrand.system intValue]];
                FMResultSet *brandRs = [db executeQuery:@"select * from carBrand where brandId = ?", brandId_Str];
                if ([brandRs next]) {
                    
                    [db executeUpdate:@"update carBrand set icon = ?, imgUrl = ?, name = ?, system = ?, time = ? where brandId = ?", carBrand.icon, carBrand.imgUrl, carBrand.name, system_Str, carBrand.time, brandId_Str];
                }else{
                    
                    [db executeUpdate:@"insert into carBrand(icon, brandId, imgUrl, name, system, time) values(?,?,?,?,?,?)", carBrand.icon, brandId_Str, carBrand.imgUrl, carBrand.name, system_Str, carBrand.time];
                }
                [brandRs close];
            }
        }else{
            
            NSLog(@"车辆品牌数据库打开失败");
        }
    }];
}

+ (NSArray *)getAllBrandData{
    
    LosDatabaseHelper *helper = [LosDatabaseHelper sharedInstance];
    NSMutableArray *brandArray = [[NSMutableArray alloc] init];
    [helper inTransaction:^(FMDatabase *db, BOOL rollback) {
        if ([db open]) {
            
            [db setShouldCacheStatements:YES];
            if (![db tableExists:@"carBrand"]) {
                
                [db executeUpdate:@"CREATE TABLE carBrand(Id INTEGER PRIMARY KEY, icon TEXT, brandId INTEGER, imgUrl TEXT, name TEXT, system INTEGER, time TEXT)"];
                NSLog(@"车辆品牌数据库创建完成!");
            }
            FMResultSet *brandRs = [db executeQuery:@"select * from carBrand"];
            while ([brandRs next]) {
                
                FMDBCarBrand *carBrand = [[FMDBCarBrand alloc] init];
                carBrand.icon = [brandRs stringForColumn:@"icon"];
                carBrand.brandId = [NSNumber numberWithInt:[brandRs intForColumn:@"brandId"]];
                carBrand.imgUrl = [brandRs stringForColumn:@"imgUrl"];
                carBrand.name = [brandRs stringForColumn:@"name"];
                carBrand.system = [NSNumber numberWithInt:[brandRs intForColumn:@"system"]];
                carBrand.time = [brandRs stringForColumn:@"time"];
                [brandArray addObject:carBrand];
            }
            [brandRs close];
        }else{
            
            NSLog(@"车辆品牌数据库创建失败");
        }
    }];
    return brandArray;
}

+ (NSString *)getBrandTime{
    
    LosDatabaseHelper *helper = [LosDatabaseHelper sharedInstance];
    __block NSArray *brandPaixArray = [[NSArray alloc] init];
    [helper inTransaction:^(FMDatabase *db, BOOL rollback) {
        if ([db open]) {
            
            [db setShouldCacheStatements:YES];
            if (![db tableExists:@"carBrand"]) {
                
                [db executeUpdate:@"CREATE TABLE carBrand(Id INTEGER PRIMARY KEY, icon TEXT, brandId INTEGER, imgUrl TEXT, name TEXT, system INTEGER, time TEXT)"];
                NSLog(@"车辆图标数据库创建完成!");
            }
            FMResultSet *brandRs = [db executeQuery:@"select * from carBrand"];
            NSMutableArray *brandTimeArray = [[NSMutableArray alloc] init];
            while ([brandRs next]) {
                
                FMDBCarBrand *carBrand = [[FMDBCarBrand alloc] init];
                carBrand.icon = [brandRs stringForColumn:@"icon"];
                carBrand.brandId = [NSNumber numberWithInt:[brandRs intForColumn:@"brandId"]];
                carBrand.imgUrl = [brandRs stringForColumn:@"imgUrl"];
                carBrand.name = [brandRs stringForColumn:@"name"];
                carBrand.system = [NSNumber numberWithInt:[brandRs intForColumn:@"system"]];
                carBrand.time = [brandRs stringForColumn:@"time"];
                NSString *timeStr = [PublicClass timestampSwitchTime:[carBrand.time integerValue] andFormatter:@"YYYY-MM-dd HH:mm:ss"];
                [brandTimeArray addObject:timeStr];
            }
            brandPaixArray = [brandTimeArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
                if (obj1 == [NSNull null]) {
                    obj1 = @"0000-00-00 00:00:00";
                }
                if (obj2 == [NSNull null]) {
                    obj2 = @"0000-00-00 00:00:00";
                }
                NSDate *brandDate1 = [formatter dateFromString:obj1];
                NSDate *brandDate2 = [formatter dateFromString:obj2];
                NSComparisonResult result = [brandDate1 compare:brandDate2];
                return result == NSOrderedAscending;
            }];
            [brandRs close];
        }else{
            
            NSLog(@"车辆品牌数据库创建失败");
        }
    }];
    if (brandPaixArray.count == 0) {
        
        return NULL;
    }else{
        
        return [brandPaixArray objectAtIndex:0];
    }
}

+ (void)insertVerhicleArray:(NSArray *)dataArray{
    
    LosDatabaseHelper *helper = [LosDatabaseHelper sharedInstance];
    [helper inTransaction:^(FMDatabase *db, BOOL rollback) {
        
        if ([db open]) {
            
            [db setShouldCacheStatements:YES];
            if (![db tableExists:@"carVerhicle"]) {
                
                [db executeUpdate:@"CREATE TABLE carVerhicle(Id INTEGER PRIMARY KEY, carBrandId INTEGER, carVersion TEXT, factoryId INTEGER, verhicleId INTEGER, system INTEGER, time TEXT, verhicle TEXT, verify INTEGER)"];
                NSLog(@"车辆型号数据库创建完成!");
            }
            NSString *carBrandId_Str, *factoryId_Str, *verhicleId_Str, *system_Str, *verify_Str;
            for (NSDictionary *dataDic in dataArray) {
                
                FMDBCarVerhicle *carVerhicle = [[FMDBCarVerhicle alloc] init];
                [carVerhicle setValuesForKeysWithDictionary:dataDic];
                carBrandId_Str = [NSString stringWithFormat:@"%ld", (long)[carVerhicle.carBrandId intValue]];
                factoryId_Str = [NSString stringWithFormat:@"%ld", (long)[carVerhicle.factoryId intValue]];
                verhicleId_Str = [NSString stringWithFormat:@"%ld", (long)[carVerhicle.verhicleId intValue]];
                system_Str = [NSString stringWithFormat:@"%ld", (long)[carVerhicle.system intValue]];
                verify_Str = [NSString stringWithFormat:@"%ld", (long)[carVerhicle.verify intValue]];
                FMResultSet *verhicleRs = [db executeQuery:@"select * from carVerhicle where verhicleId = ?", verhicleId_Str];
                if ([verhicleRs next]) {
                    
                    [db executeUpdate:@"update carVerhicle set carBrandId = ?, carVersion = ?, factoryId = ?, system = ?, time = ?, verhicle = ?, verify = ? where verhicleId = ?", carBrandId_Str, carVerhicle.carVersion, factoryId_Str, system_Str, carVerhicle.time, carVerhicle.verhicle, verify_Str, verhicleId_Str];
                }else{
                    
                    [db executeUpdate:@"insert into carVerhicle(carBrandId, carVersion, factoryId, verhicleId, system, time, verhicle, verify) values(?,?,?,?,?,?,?,?)", carBrandId_Str, carVerhicle.carVersion, factoryId_Str, verhicleId_Str, system_Str, carVerhicle.time, carVerhicle.verhicle, verify_Str];
                }
                [verhicleRs close];
            }
        }else{
            
            NSLog(@"车辆型号数据库打开失败");
        }
    }];
}

+ (NSArray *)getVerhicleData:(NSNumber *)factoryId{
    
    LosDatabaseHelper *helper = [LosDatabaseHelper sharedInstance];
    NSMutableArray *verhicleArray = [[NSMutableArray alloc] init];
    [helper inTransaction:^(FMDatabase *db, BOOL rollback) {
        
        if ([db open]) {
            
            [db setShouldCacheStatements:YES];
            if (![db tableExists:@"carVerhicle"]) {
                
                [db executeUpdate:@"CREATE TABLE carVerhicle(Id INTEGER PRIMARY KEY, carBrandId INTEGER, carVersion TEXT, factoryId INTEGER, verhicleId INTEGER, system INTEGER, time TEXT, verhicle TEXT, verify INTEGER)"];
                NSLog(@"车辆型号数据库创建完成!");
            }
            FMResultSet *verhicleRs = [db executeQuery:@"select * from carVerhicle where factoryId = ?", factoryId];
            while ([verhicleRs next]) {
                
                FMDBCarVerhicle *carVerhicle = [[FMDBCarVerhicle alloc] init];
                carVerhicle.carBrandId = [NSNumber numberWithInt:[verhicleRs intForColumn:@"carBrandId"]];
                carVerhicle.carVersion = [verhicleRs stringForColumn:@"carVersion"];
                carVerhicle.factoryId = [NSNumber numberWithInt:[verhicleRs intForColumn:@"factoryId"]];
                carVerhicle.verhicleId = [NSNumber numberWithInt:[verhicleRs intForColumn:@"verhicleId"]];
                carVerhicle.system = [NSNumber numberWithInt:[verhicleRs intForColumn:@"system"]];
                carVerhicle.time = [verhicleRs stringForColumn:@"time"];
                carVerhicle.verhicle = [verhicleRs stringForColumn:@"verhicle"];
                carVerhicle.verify = [NSNumber numberWithInt:[verhicleRs intForColumn:@"verify"]];
                [verhicleArray addObject:carVerhicle];
            }
        }else{
            
            NSLog(@"车辆型号数据库打开失败");
        }
    }];
    return verhicleArray;
}

+ (NSString *)getVerhicleTime{
    
    LosDatabaseHelper *helper = [LosDatabaseHelper sharedInstance];
    __block NSArray *verhiclePaixArray = [[NSArray alloc] init];
    [helper inTransaction:^(FMDatabase *db, BOOL rollback) {
        
        if ([db open]) {
            
            [db setShouldCacheStatements:YES];
            if (![db tableExists:@"carVerhicle"]) {
                
                [db executeUpdate:@"CREATE TABLE carVerhicle(Id INTEGER PRIMARY KEY, carBrandId INTEGER, carVersion TEXT, factoryId INTEGER, verhicleId INTEGER, system INTEGER, time TEXT, verhicle TEXT, verify INTEGER)"];
                NSLog(@"车辆型号数据库创建完成!");
            }
            FMResultSet *verhicleRs = [db executeQuery:@"select * from carVerhicle"];
            NSMutableArray *verhicleTimeArry = [[NSMutableArray alloc] init];
            while ([verhicleRs next]) {
                
                FMDBCarVerhicle *carVerhicle = [[FMDBCarVerhicle alloc] init];
                carVerhicle.carBrandId = [NSNumber numberWithInt:[verhicleRs intForColumn:@"carBrandId"]];
                carVerhicle.carVersion = [verhicleRs stringForColumn:@"carVersion"];
                carVerhicle.factoryId = [NSNumber numberWithInt:[verhicleRs intForColumn:@"factoryId"]];
                carVerhicle.verhicleId = [NSNumber numberWithInt:[verhicleRs intForColumn:@"verhicleId"]];
                carVerhicle.system = [NSNumber numberWithInt:[verhicleRs intForColumn:@"system"]];
                carVerhicle.time = [verhicleRs stringForColumn:@"time"];
                carVerhicle.verhicle = [verhicleRs stringForColumn:@"verhicle"];
                carVerhicle.verify = [NSNumber numberWithInt:[verhicleRs intForColumn:@"verify"]];
                NSString *timeStr = [PublicClass timestampSwitchTime:[carVerhicle.time integerValue] andFormatter:@"YYYY-MM-dd HH:mm:ss"];
                [verhicleTimeArry addObject:timeStr];
            }
            verhiclePaixArray = [verhicleTimeArry sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
                if (obj1 == [NSNull null]) {
                    obj1 = @"0000-00-00 00:00:00";
                }
                if (obj2 == [NSNull null]) {
                    obj2 = @"0000-00-00 00:00:00";
                }
                NSDate *date1 = [formatter dateFromString:obj1];
                NSDate *date2 = [formatter dateFromString:obj2];
                NSComparisonResult result = [date1 compare:date2];
                return result == NSOrderedAscending;
            }];
            [verhicleRs close];
        }else{
            
            NSLog(@"车辆型号数据库打开失败");
        }
    }];
    if (verhiclePaixArray.count == 0) {
        
        return NULL;
    }else{
        
        return [verhiclePaixArray objectAtIndex:0];
    }
}

+ (void)insertTireInfoArray:(NSArray *)dataArray{
    
    LosDatabaseHelper *helper = [LosDatabaseHelper sharedInstance];
    [helper inTransaction:^(FMDatabase *db, BOOL rollback) {
        
        if ([db open]) {
            
            [db setShouldCacheStatements:YES];
            if (![db tableExists:@"carTireInfo"]) {
                
                [db executeUpdate:@"CREATE TABLE carTireInfo(Id INTEGER PRIMARY KEY, tireInfoId INTEGER, brand TEXT, carBrandId INTEGER, verhicle TEXT, verhicleId INTEGER, pailiang TEXT, price INTEGER, year INTEGER, name TEXT, font TEXT, rear TEXT, system INTEGER, time TEXT)"];
                NSLog(@"车辆轮胎和排量数据库创建完成!");
            }
            NSString *tireInfoId_Str, *carBrandId_Str, *verhicleId_Str, *price_Str, *year_Str, *system_Str;
            for (NSDictionary *dataDic in dataArray) {
                
                FMDBCarTireInfo *carTireInfo = [[FMDBCarTireInfo alloc] init];
                [carTireInfo setValuesForKeysWithDictionary:dataDic];
                tireInfoId_Str = [NSString stringWithFormat:@"%ld", (long)[carTireInfo.tireInfoId intValue]];
                carBrandId_Str = [NSString stringWithFormat:@"%ld", (long)[carTireInfo.carBrandId intValue]];
                verhicleId_Str = [NSString stringWithFormat:@"%ld", (long)[carTireInfo.verhicleId intValue]];
                price_Str = [NSString stringWithFormat:@"%ld", (long)[carTireInfo.price intValue]];
                year_Str = [NSString stringWithFormat:@"%ld", (long)[carTireInfo.year intValue]];
                system_Str = [NSString stringWithFormat:@"%ld", (long)[carTireInfo.system intValue]];
                FMResultSet *tireInfoRs = [db executeQuery:@"select * from carTireInfo where tireInfoId = ?", tireInfoId_Str];
                if ([tireInfoRs next]) {
                    
                    [db executeUpdate:@"update carTireInfo set brand = ?, carBrandId = ?, verhicle = ?, verhicleId = ?, pailiang = ?, price = ?, year = ?, name = ?, font = ?, rear = ?, system = ?, time = ? where tireInfoId = ?", carTireInfo.brand, carBrandId_Str, carTireInfo.verhicle, verhicleId_Str, carTireInfo.pailiang, price_Str, year_Str, carTireInfo.name, carTireInfo.font, carTireInfo.rear, system_Str, carTireInfo.time, tireInfoId_Str];
                }else{
                    
                    [db executeUpdate:@"insert into carTireInfo(tireInfoId, brand, carBrandId, verhicle, verhicleId, pailiang, price, year, name, font, rear, system, time) values(?,?,?,?,?,?,?,?,?,?,?,?,?)", tireInfoId_Str, carTireInfo.brand, carBrandId_Str, carTireInfo.verhicle, verhicleId_Str, carTireInfo.pailiang, price_Str, year_Str, carTireInfo.name, carTireInfo.font, carTireInfo.rear, system_Str, carTireInfo.time];
                }
                [tireInfoRs close];
            }
        }
    }];
}

+ (NSArray *)getTireInfoData:(NSNumber *)verhicleId{
    
    LosDatabaseHelper *helper = [LosDatabaseHelper sharedInstance];
    NSMutableArray *tireinfoMutableA = [[NSMutableArray alloc] init];
    [helper inTransaction:^(FMDatabase *db, BOOL rollback) {
        
        if ([db open]) {
            
            [db setShouldCacheStatements:YES];
            if (![db tableExists:@"carTireInfo"]) {
                
                [db executeUpdate:@"CREATE TABLE carTireInfo(Id INTEGER PRIMARY KEY, tireInfoId INTEGER, brand TEXT, carBrandId INTEGER, verhicle TEXT, verhicleId INTEGER, pailiang TEXT, price INTEGER, year INTEGER, name TEXT, font TEXT, rear TEXT, system INTEGER, time TEXT)"];
                NSLog(@"车辆轮胎和排量数据库创建完成!");
            }
            FMResultSet *cartireInfoRs = [db executeQuery:@"select * from carTireInfo where verhicleId = ?", verhicleId];
            while ([cartireInfoRs next]) {
                
                FMDBCarTireInfo *carTireinfo = [[FMDBCarTireInfo alloc] init];
                carTireinfo.tireInfoId = [NSNumber numberWithInt:[cartireInfoRs intForColumn:@"tireInfoId"]];
                carTireinfo.brand = [cartireInfoRs stringForColumn:@"brand"];
                carTireinfo.carBrandId = [NSNumber numberWithInt:[cartireInfoRs intForColumn:@"carBrandId"]];
                carTireinfo.verhicle = [cartireInfoRs stringForColumn:@"verhicle"];
                carTireinfo.verhicleId = [NSNumber numberWithInt:[cartireInfoRs intForColumn:@"verhicleId"]];
                carTireinfo.pailiang = [cartireInfoRs stringForColumn:@"pailiang"];
                carTireinfo.price = [NSNumber numberWithInt:[cartireInfoRs intForColumn:@"price"]];
                carTireinfo.year = [NSNumber numberWithInt:[cartireInfoRs intForColumn:@"year"]];
                carTireinfo.name = [cartireInfoRs stringForColumn:@"name"];
                carTireinfo.font = [cartireInfoRs stringForColumn:@"font"];
                carTireinfo.rear = [cartireInfoRs stringForColumn:@"rear"];
                carTireinfo.system = [NSNumber numberWithInt:[cartireInfoRs intForColumn:@"system"]];
                carTireinfo.time = [cartireInfoRs stringForColumn:@"time"];
                [tireinfoMutableA addObject:carTireinfo];
            }
        }
    }];
    return tireinfoMutableA;
}

+ (NSArray *)getTireInfoDataByTireinfoId:(NSNumber *)tireinfoId{
    
    LosDatabaseHelper *helper = [LosDatabaseHelper sharedInstance];
    NSMutableArray *tireinfoMutableA = [[NSMutableArray alloc] init];
    [helper inTransaction:^(FMDatabase *db, BOOL rollback) {
        
        if ([db open]) {
            
            [db setShouldCacheStatements:YES];
            if (![db tableExists:@"carTireInfo"]) {
                
                [db executeUpdate:@"CREATE TABLE carTireInfo(Id INTEGER PRIMARY KEY, tireInfoId INTEGER, brand TEXT, carBrandId INTEGER, verhicle TEXT, verhicleId INTEGER, pailiang TEXT, price INTEGER, year INTEGER, name TEXT, font TEXT, rear TEXT, system INTEGER, time TEXT)"];
                NSLog(@"车辆轮胎和排量数据库创建完成!");
            }
            FMResultSet *cartireInfoRs = [db executeQuery:@"select * from carTireInfo where tireInfoId = ?", tireinfoId];
            while ([cartireInfoRs next]) {
                
                FMDBCarTireInfo *carTireinfo = [[FMDBCarTireInfo alloc] init];
                carTireinfo.tireInfoId = [NSNumber numberWithInt:[cartireInfoRs intForColumn:@"tireInfoId"]];
                carTireinfo.brand = [cartireInfoRs stringForColumn:@"brand"];
                carTireinfo.carBrandId = [NSNumber numberWithInt:[cartireInfoRs intForColumn:@"carBrandId"]];
                carTireinfo.verhicle = [cartireInfoRs stringForColumn:@"verhicle"];
                carTireinfo.verhicleId = [NSNumber numberWithInt:[cartireInfoRs intForColumn:@"verhicleId"]];
                carTireinfo.pailiang = [cartireInfoRs stringForColumn:@"pailiang"];
                carTireinfo.price = [NSNumber numberWithInt:[cartireInfoRs intForColumn:@"price"]];
                carTireinfo.year = [NSNumber numberWithInt:[cartireInfoRs intForColumn:@"year"]];
                carTireinfo.name = [cartireInfoRs stringForColumn:@"name"];
                carTireinfo.font = [cartireInfoRs stringForColumn:@"font"];
                carTireinfo.rear = [cartireInfoRs stringForColumn:@"rear"];
                carTireinfo.system = [NSNumber numberWithInt:[cartireInfoRs intForColumn:@"system"]];
                carTireinfo.time = [cartireInfoRs stringForColumn:@"time"];
                [tireinfoMutableA addObject:carTireinfo];
            }
        }
    }];
    return tireinfoMutableA;
}

+ (NSArray *)getTireInfoData:(NSNumber *)verhicleId andpailiang:(NSString *)paiLiang{
    
    LosDatabaseHelper *helper = [LosDatabaseHelper sharedInstance];
    NSMutableArray *tireinfoMutableA = [[NSMutableArray alloc] init];
    [helper inTransaction:^(FMDatabase *db, BOOL rollback) {
        
        if ([db open]) {
            
            [db setShouldCacheStatements:YES];
            if (![db tableExists:@"carTireInfo"]) {
                
                [db executeUpdate:@"CREATE TABLE carTireInfo(Id INTEGER PRIMARY KEY, tireInfoId INTEGER, brand TEXT, carBrandId INTEGER, verhicle TEXT, verhicleId INTEGER, pailiang TEXT, price INTEGER, year INTEGER, name TEXT, font TEXT, rear TEXT, system INTEGER, time TEXT)"];
                NSLog(@"车辆轮胎和排量数据库创建完成!");
            }
            FMResultSet *cartireInfoRs = [db executeQuery:@"select * from carTireInfo where verhicleId = ? and pailiang = ?", verhicleId, paiLiang];
            while ([cartireInfoRs next]) {
                
                FMDBCarTireInfo *carTireinfo = [[FMDBCarTireInfo alloc] init];
                carTireinfo.tireInfoId = [NSNumber numberWithInt:[cartireInfoRs intForColumn:@"tireInfoId"]];
                carTireinfo.brand = [cartireInfoRs stringForColumn:@"brand"];
                carTireinfo.carBrandId = [NSNumber numberWithInt:[cartireInfoRs intForColumn:@"carBrandId"]];
                carTireinfo.verhicle = [cartireInfoRs stringForColumn:@"verhicle"];
                carTireinfo.verhicleId = [NSNumber numberWithInt:[cartireInfoRs intForColumn:@"verhicleId"]];
                carTireinfo.pailiang = [cartireInfoRs stringForColumn:@"pailiang"];
                carTireinfo.price = [NSNumber numberWithInt:[cartireInfoRs intForColumn:@"price"]];
                carTireinfo.year = [NSNumber numberWithInt:[cartireInfoRs intForColumn:@"year"]];
                carTireinfo.name = [cartireInfoRs stringForColumn:@"name"];
                carTireinfo.font = [cartireInfoRs stringForColumn:@"font"];
                carTireinfo.rear = [cartireInfoRs stringForColumn:@"rear"];
                carTireinfo.system = [NSNumber numberWithInt:[cartireInfoRs intForColumn:@"system"]];
                carTireinfo.time = [cartireInfoRs stringForColumn:@"time"];
                [tireinfoMutableA addObject:carTireinfo];
            }
        }
    }];
    return tireinfoMutableA;
}

+ (NSArray *)getTireInfoData:(NSNumber *)verhicleId andpailiang:(NSString *)paiLiang andYear:(NSNumber *)year{
    
    LosDatabaseHelper *helper = [LosDatabaseHelper sharedInstance];
    NSMutableArray *tireinfoMutableA = [[NSMutableArray alloc] init];
    [helper inTransaction:^(FMDatabase *db, BOOL rollback) {
        
        if ([db open]) {
            
            [db setShouldCacheStatements:YES];
            if (![db tableExists:@"carTireInfo"]) {
                
                [db executeUpdate:@"CREATE TABLE carTireInfo(Id INTEGER PRIMARY KEY, tireInfoId INTEGER, brand TEXT, carBrandId INTEGER, verhicle TEXT, verhicleId INTEGER, pailiang TEXT, price INTEGER, year INTEGER, name TEXT, font TEXT, rear TEXT, system INTEGER, time TEXT)"];
                NSLog(@"车辆轮胎和排量数据库创建完成!");
            }
            FMResultSet *cartireInfoRs = [db executeQuery:@"select * from carTireInfo where verhicleId = ? and pailiang = ? and year = ?", verhicleId, paiLiang, year];
            while ([cartireInfoRs next]) {
                
                FMDBCarTireInfo *carTireinfo = [[FMDBCarTireInfo alloc] init];
                carTireinfo.tireInfoId = [NSNumber numberWithInt:[cartireInfoRs intForColumn:@"tireInfoId"]];
                carTireinfo.brand = [cartireInfoRs stringForColumn:@"brand"];
                carTireinfo.carBrandId = [NSNumber numberWithInt:[cartireInfoRs intForColumn:@"carBrandId"]];
                carTireinfo.verhicle = [cartireInfoRs stringForColumn:@"verhicle"];
                carTireinfo.verhicleId = [NSNumber numberWithInt:[cartireInfoRs intForColumn:@"verhicleId"]];
                carTireinfo.pailiang = [cartireInfoRs stringForColumn:@"pailiang"];
                carTireinfo.price = [NSNumber numberWithInt:[cartireInfoRs intForColumn:@"price"]];
                carTireinfo.year = [NSNumber numberWithInt:[cartireInfoRs intForColumn:@"year"]];
                carTireinfo.name = [cartireInfoRs stringForColumn:@"name"];
                carTireinfo.font = [cartireInfoRs stringForColumn:@"font"];
                carTireinfo.rear = [cartireInfoRs stringForColumn:@"rear"];
                carTireinfo.system = [NSNumber numberWithInt:[cartireInfoRs intForColumn:@"system"]];
                carTireinfo.time = [cartireInfoRs stringForColumn:@"time"];
                [tireinfoMutableA addObject:carTireinfo];
            }
        }
    }];
    return tireinfoMutableA;
}

+ (void)insertTireTypeArray:(NSArray *)dataArray{
    
    LosDatabaseHelper *helper = [LosDatabaseHelper sharedInstance];
    [helper inTransaction:^(FMDatabase *db, BOOL rollback) {
        
        if ([db open]) {
            
            [db setShouldCacheStatements:YES];
            if (![db tableExists:@"carTireType"]) {
                
                [db executeUpdate:@"CREATE TABLE carTireType(Id INTEGER PRIMARY KEY, time TEXT, tireDiameter TEXT, tireFlatWidth TEXT, tireFlatnessRatio TEXT, tireState INTEGER, tireTypeId INTEGER)"];
                NSLog(@"轮胎类型数据库创建完成!");
            }
            NSString *tireState_Str, *tireTypeId_Str;
            for (NSDictionary *dataDic in dataArray) {
                
                FMDBCarTireType *carTireType = [[FMDBCarTireType alloc] init];
                [carTireType setValuesForKeysWithDictionary:dataDic];
                tireState_Str = [NSString stringWithFormat:@"%ld", (long)[carTireType.tireState intValue]];
                tireTypeId_Str = [NSString stringWithFormat:@"%ld", (long)[carTireType.tireTypeId intValue]];
                FMResultSet *tireTypeRs = [db executeQuery:@"select * from carTireType where tireTypeId = ?", tireTypeId_Str];
                if ([tireTypeRs next]) {
                    
                    [db executeUpdate:@"update carTireType set time = ?, tireDiameter = ?, tireFlatWidth = ?, tireFlatnessRatio = ?, tireState = ? where tireTypeId = ?", carTireType.time, carTireType.tireDiameter, carTireType.tireFlatWidth, carTireType.tireFlatnessRatio, tireState_Str, tireTypeId_Str];
                }else{
                    
                    [db executeUpdate:@"insert into carTireType(time, tireDiameter, tireFlatWidth, tireFlatnessRatio, tireState, tireTypeId) values(?,?,?,?,?,?)", carTireType.time, carTireType.tireDiameter, carTireType.tireFlatWidth, carTireType.tireFlatnessRatio, tireState_Str, tireTypeId_Str];
                }
                [tireTypeRs close];
            }
        }
    }];
}

+ (NSArray *)getAllTiretypeData{
    
    LosDatabaseHelper *helper = [LosDatabaseHelper sharedInstance];
    NSMutableArray *tireTypeArray = [[NSMutableArray alloc] init];
    [helper inTransaction:^(FMDatabase *db, BOOL rollback) {
        
        if ([db open]) {
            
            [db setShouldCacheStatements:YES];
            if (![db tableExists:@"carTireType"]) {
                
                [db executeUpdate:@"CREATE TABLE carTireType(Id INTEGER PRIMARY KEY, time TEXT, tireDiameter TEXT, tireFlatWidth TEXT, tireFlatnessRatio TEXT, tireState INTEGER, tireTypeId INTEGER)"];
                NSLog(@"轮胎类型数据库创建完成!");
            }
            FMResultSet *tireTypeRs = [db executeQuery:@"select * from carTireType"];
            while ([tireTypeRs next]) {
                
                FMDBCarTireType *carTireType = [[FMDBCarTireType alloc] init];
                carTireType.time = [tireTypeRs stringForColumn:@"time"];
                carTireType.tireDiameter = [tireTypeRs stringForColumn:@"tireDiameter"];
                carTireType.tireFlatWidth = [tireTypeRs stringForColumn:@"tireFlatWidth"];
                carTireType.tireFlatnessRatio = [tireTypeRs stringForColumn:@"tireFlatnessRatio"];
                carTireType.tireState = [NSNumber numberWithInt:[tireTypeRs intForColumn:@"tireState"]];
                carTireType.tireTypeId = [NSNumber numberWithInt:[tireTypeRs intForColumn:@"tireTypeId"]];
                [tireTypeArray addObject:carTireType];
            }
            [tireTypeRs close];
        }else{
            
            NSLog(@"轮胎类型数据库打开失败");
        }
    }];
    return tireTypeArray;
}

+ (NSString *)getTiretypeTime{
    
    LosDatabaseHelper *helper = [LosDatabaseHelper sharedInstance];
    __block NSArray *tiretypePaixArray = [[NSArray alloc] init];
    [helper inTransaction:^(FMDatabase *db, BOOL rollback) {
        
        if ([db open]) {
            
            [db setShouldCacheStatements:YES];
            if (![db tableExists:@"carTireType"]) {
                
                [db executeUpdate:@"CREATE TABLE carTireType(Id INTEGER PRIMARY KEY, time TEXT, tireDiameter TEXT, tireFlatWidth TEXT, tireFlatnessRatio TEXT, tireState INTEGER, tireTypeId INTEGER)"];
                NSLog(@"轮胎类型数据库创建完成!");
            }
            FMResultSet *tireTypeRs = [db executeQuery:@"select * from carTireType"];
            NSMutableArray *tireTypeTimeArray = [[NSMutableArray alloc] init];
            while ([tireTypeRs next]) {
                
                FMDBCarTireType *carTireType = [[FMDBCarTireType alloc] init];
                carTireType.time = [tireTypeRs stringForColumn:@"time"];
                carTireType.tireDiameter = [tireTypeRs stringForColumn:@"tireDiameter"];
                carTireType.tireFlatWidth = [tireTypeRs stringForColumn:@"tireFlatWidth"];
                carTireType.tireFlatnessRatio = [tireTypeRs stringForColumn:@"tireFlatnessRatio"];
                carTireType.tireState = [NSNumber numberWithInt:[tireTypeRs intForColumn:@"tireState"]];
                carTireType.tireTypeId = [NSNumber numberWithInt:[tireTypeRs intForColumn:@"tireTypeId"]];
                NSString *timeStr = [PublicClass timestampSwitchTime:[carTireType.time integerValue] andFormatter:@"YYYY-MM-dd HH:mm:ss"];
                [tireTypeTimeArray addObject:timeStr];
            }
            tiretypePaixArray = [tireTypeTimeArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
                if (obj1 == [NSNull null]) {
                    obj1 = @"0000-00-00 00:00:00";
                }
                if (obj2 == [NSNull null]) {
                    obj2 = @"0000-00-00 00:00:00";
                }
                NSDate *date1 = [formatter dateFromString:obj1];
                NSDate *date2 = [formatter dateFromString:obj2];
                NSComparisonResult result = [date1 compare:date2];
                return result == NSOrderedAscending;
            }];
            [tireTypeRs close];
        }else{
            
            NSLog(@"轮胎类型数据库打开失败");
        }
    }];
    if (tiretypePaixArray.count == 0) {
        
        return NULL;
    }else{
        
        return [tiretypePaixArray objectAtIndex:0];
    }
}

+ (NSArray *)getTiretypeDataByflatWidth:(NSString *)tireFlatWidth{
    
    LosDatabaseHelper *helper = [LosDatabaseHelper sharedInstance];
    NSMutableArray *tireTypeArray = [[NSMutableArray alloc] init];
    [helper inTransaction:^(FMDatabase *db, BOOL rollback) {
        
        if ([db open]) {
            
            [db setShouldCacheStatements:YES];
            if (![db tableExists:@"carTireType"]) {
                
                [db executeUpdate:@"CREATE TABLE carTireType(Id INTEGER PRIMARY KEY, time TEXT, tireDiameter TEXT, tireFlatWidth TEXT, tireFlatnessRatio TEXT, tireState INTEGER, tireTypeId INTEGER)"];
                NSLog(@"轮胎类型数据库创建完成!");
            }
            FMResultSet *tireTypeRs = [db executeQuery:@"select * from carTireType where tireFlatWidth = ?", tireFlatWidth];
            while ([tireTypeRs next]) {
                
                FMDBCarTireType *carTireType = [[FMDBCarTireType alloc] init];
                carTireType.time = [tireTypeRs stringForColumn:@"time"];
                carTireType.tireDiameter = [tireTypeRs stringForColumn:@"tireDiameter"];
                carTireType.tireFlatWidth = [tireTypeRs stringForColumn:@"tireFlatWidth"];
                carTireType.tireFlatnessRatio = [tireTypeRs stringForColumn:@"tireFlatnessRatio"];
                carTireType.tireState = [NSNumber numberWithInt:[tireTypeRs intForColumn:@"tireState"]];
                carTireType.tireTypeId = [NSNumber numberWithInt:[tireTypeRs intForColumn:@"tireTypeId"]];
                [tireTypeArray addObject:carTireType];
            }
            [tireTypeRs close];
        }else{
            
            NSLog(@"轮胎类型数据库打开失败");
        }
    }];
    return tireTypeArray;
}

+ (NSArray *)getTiretypeDataByflatRatio:(NSString *)flatRatio{
    
    LosDatabaseHelper *helper = [LosDatabaseHelper sharedInstance];
    NSMutableArray *tireTypeArray = [[NSMutableArray alloc] init];
    [helper inTransaction:^(FMDatabase *db, BOOL rollback) {
        
        if ([db open]) {
            
            [db setShouldCacheStatements:YES];
            if (![db tableExists:@"carTireType"]) {
                
                [db executeUpdate:@"CREATE TABLE carTireType(Id INTEGER PRIMARY KEY, time TEXT, tireDiameter TEXT, tireFlatWidth TEXT, tireFlatnessRatio TEXT, tireState INTEGER, tireTypeId INTEGER)"];
                NSLog(@"轮胎类型数据库创建完成!");
            }
            FMResultSet *tireTypeRs = [db executeQuery:@"select * from carTireType where tireFlatnessRatio = ?", flatRatio];
            while ([tireTypeRs next]) {
                
                FMDBCarTireType *carTireType = [[FMDBCarTireType alloc] init];
                carTireType.time = [tireTypeRs stringForColumn:@"time"];
                carTireType.tireDiameter = [tireTypeRs stringForColumn:@"tireDiameter"];
                carTireType.tireFlatWidth = [tireTypeRs stringForColumn:@"tireFlatWidth"];
                carTireType.tireFlatnessRatio = [tireTypeRs stringForColumn:@"tireFlatnessRatio"];
                carTireType.tireState = [NSNumber numberWithInt:[tireTypeRs intForColumn:@"tireState"]];
                carTireType.tireTypeId = [NSNumber numberWithInt:[tireTypeRs intForColumn:@"tireTypeId"]];
                [tireTypeArray addObject:carTireType];
            }
            [tireTypeRs close];
        }else{
            
            NSLog(@"轮胎类型数据库打开失败");
        }
    }];
    return tireTypeArray;
}

+ (void)insertPositionArray:(NSArray *)dataArray{
    
    LosDatabaseHelper *helper = [LosDatabaseHelper sharedInstance];
    [helper inTransaction:^(FMDatabase *db, BOOL rollback) {
        
        if ([db open]) {
            
            [db setShouldCacheStatements:YES];
            if (![db tableExists:@"position"]) {
                
                [db executeUpdate:@"CREATE TABLE position(Id INTEGER PRIMARY KEY, definition INTEGER, fid INTEGER, icon TEXT, positionId INTEGER, level INTEGER, name TEXT, time TEXT)"];
                NSLog(@"省市区位置数据库创建完成!");
            }
            NSString *pdefinition_Str, *pfid_Str, *positionId_Str, *plevel_Str;
            for (NSDictionary *dataDic in dataArray) {
                
                FMDBPosition *position = [[FMDBPosition alloc] init];
                [position setValuesForKeysWithDictionary:dataDic];
                pdefinition_Str = [NSString stringWithFormat:@"%ld", (long)[position.definition intValue]];
                pfid_Str = [NSString stringWithFormat:@"%ld", (long)[position.fid intValue]];
                positionId_Str = [NSString stringWithFormat:@"%ld", (long)[position.positionId intValue]];
                plevel_Str = [NSString stringWithFormat:@"%ld", (long)[position.level intValue]];
                FMResultSet *positionRs = [db executeQuery:@"select * from position where positionId = ?", positionId_Str];
                if ([positionRs next]) {
                    
                    [db executeUpdate:@"update position set definition = ?, fid = ?, icon = ?, level = ?, name = ?, time = ? where positionId = ?", pdefinition_Str, pfid_Str, position.icon, plevel_Str, position.name, position.time, positionId_Str];
                }else{
                    
                    [db executeUpdate:@"insert into position(definition, fid, icon, positionId, level, name, time) values(?,?,?,?,?,?,?)", pdefinition_Str, pfid_Str, position.icon, positionId_Str, plevel_Str, position.name, position.time];
                }
                [positionRs close];
            }
        }
    }];
}

+ (NSArray *)getProvinceArray:(NSNumber *)definition{
    
    LosDatabaseHelper *helper = [LosDatabaseHelper sharedInstance];
    NSMutableArray *provinceArray = [[NSMutableArray alloc] init];
    [helper inTransaction:^(FMDatabase *db, BOOL rollback) {
        
        if ([db open]) {
            
            [db setShouldCacheStatements:YES];
            if (![db tableExists:@"position"]) {
                
                [db executeUpdate:@"CREATE TABLE position(Id INTEGER PRIMARY KEY, definition INTEGER, fid INTEGER, icon TEXT, positionId INTEGER, level INTEGER, name TEXT, time TEXT)"];
                NSLog(@"省市区位置数据库创建完成!");
            }
            FMResultSet *provinceRs = [db executeQuery:@"select * from position where definition = ?", definition];
            while ([provinceRs next]) {
                
                FMDBPosition *position = [[FMDBPosition alloc] init];
                position.definition = [NSNumber numberWithInt:[provinceRs intForColumn:@"definition"]];
                position.fid = [NSNumber numberWithInt:[provinceRs intForColumn:@"fid"]];
                position.icon = [provinceRs stringForColumn:@"icon"];
                position.positionId = [NSNumber numberWithInt:[provinceRs intForColumn:@"positionId"]];
                position.level = [NSNumber numberWithInt:[provinceRs intForColumn:@"level"]];
                position.name = [provinceRs stringForColumn:@"name"];
                position.time = [provinceRs stringForColumn:@"time"];
                [provinceArray addObject:position];
            }
            [provinceRs close];
        }
    }];
    return provinceArray;
}

+ (NSArray *)getCityArray:(NSNumber *)positionId{
    
    LosDatabaseHelper *helper = [LosDatabaseHelper sharedInstance];
    NSMutableArray *cityArray = [[NSMutableArray alloc] init];
    [helper inTransaction:^(FMDatabase *db, BOOL rollback) {
        
        if ([db open]) {
            
            [db setShouldCacheStatements:YES];
            if (![db tableExists:@"position"]) {
                
                [db executeUpdate:@"CREATE TABLE position(Id INTEGER PRIMARY KEY, definition INTEGER, fid INTEGER, icon TEXT, positionId INTEGER, level INTEGER, name TEXT, time TEXT)"];
                NSLog(@"省市区位置数据库创建完成!");
            }
            FMResultSet *provinceRs = [db executeQuery:@"select * from position where fid = ?", positionId];
            while ([provinceRs next]) {
                
                FMDBPosition *position = [[FMDBPosition alloc] init];
                position.definition = [NSNumber numberWithInt:[provinceRs intForColumn:@"definition"]];
                position.fid = [NSNumber numberWithInt:[provinceRs intForColumn:@"fid"]];
                position.icon = [provinceRs stringForColumn:@"icon"];
                position.positionId = [NSNumber numberWithInt:[provinceRs intForColumn:@"positionId"]];
                position.level = [NSNumber numberWithInt:[provinceRs intForColumn:@"level"]];
                position.name = [provinceRs stringForColumn:@"name"];
                position.time = [provinceRs stringForColumn:@"time"];
                [cityArray addObject:position];
            }
            [provinceRs close];
        }
    }];
    return cityArray;
}

+ (NSArray *)getPro_City_id:(NSString *)name{
    
    LosDatabaseHelper *helper = [LosDatabaseHelper sharedInstance];
    NSMutableArray *cityArray = [[NSMutableArray alloc] init];
    [helper inTransaction:^(FMDatabase *db, BOOL rollback) {
        
        if ([db open]) {
            
            [db setShouldCacheStatements:YES];
            if (![db tableExists:@"position"]) {
                
                [db executeUpdate:@"CREATE TABLE position(Id INTEGER PRIMARY KEY, definition INTEGER, fid INTEGER, icon TEXT, positionId INTEGER, level INTEGER, name TEXT, time TEXT)"];
                NSLog(@"省市区位置数据库创建完成!");
            }
            FMResultSet *provinceRs = [db executeQuery:@"select * from position where name = ?", name];
            while ([provinceRs next]) {
                
                FMDBPosition *position = [[FMDBPosition alloc] init];
                position.definition = [NSNumber numberWithInt:[provinceRs intForColumn:@"definition"]];
                position.fid = [NSNumber numberWithInt:[provinceRs intForColumn:@"fid"]];
                position.icon = [provinceRs stringForColumn:@"icon"];
                position.positionId = [NSNumber numberWithInt:[provinceRs intForColumn:@"positionId"]];
                position.level = [NSNumber numberWithInt:[provinceRs intForColumn:@"level"]];
                position.name = [provinceRs stringForColumn:@"name"];
                position.time = [provinceRs stringForColumn:@"time"];
                [cityArray addObject:position];
            }
            [provinceRs close];
        }
    }];
    return cityArray;
}

+ (NSString *)getPositionTime{
    
    LosDatabaseHelper *helper = [LosDatabaseHelper sharedInstance];
    __block NSArray *positionPaixArrray = [[NSArray alloc] init];
    [helper inTransaction:^(FMDatabase *db, BOOL rollback) {
        
        if ([db open]) {
            
            [db setShouldCacheStatements:YES];
            if (![db tableExists:@"position"]) {
                
                [db executeUpdate:@"CREATE TABLE position(Id INTEGER PRIMARY KEY, definition INTEGER, fid INTEGER, icon TEXT, positionId INTEGER, level INTEGER, name TEXT, time TEXT)"];
                NSLog(@"省市区位置数据库创建完成!");
            }
            FMResultSet *provinceRs = [db executeQuery:@"select * from position"];
            NSMutableArray *positionTimeArray = [[NSMutableArray alloc] init];
            while ([provinceRs next]) {
                
                FMDBPosition *position = [[FMDBPosition alloc] init];
                position.definition = [NSNumber numberWithInt:[provinceRs intForColumn:@"definition"]];
                position.fid = [NSNumber numberWithInt:[provinceRs intForColumn:@"fid"]];
                position.icon = [provinceRs stringForColumn:@"icon"];
                position.positionId = [NSNumber numberWithInt:[provinceRs intForColumn:@"positionId"]];
                position.level = [NSNumber numberWithInt:[provinceRs intForColumn:@"level"]];
                position.name = [provinceRs stringForColumn:@"name"];
                position.time = [provinceRs stringForColumn:@"time"];
                NSString *timeStr = [PublicClass timestampSwitchTime:[position.time integerValue] andFormatter:@"YYYY-MM-dd HH:mm:ss"];
                [positionTimeArray addObject:timeStr];
            }
            positionPaixArrray = [positionTimeArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
                if (obj1 == [NSNull null]) {
                    obj1 = @"0000-00-00 00:00:00";
                }
                if (obj2 == [NSNull null]) {
                    obj2 = @"0000-00-00 00:00:00";
                }
                NSDate *date1 = [formatter dateFromString:obj1];
                NSDate *date2 = [formatter dateFromString:obj2];
                NSComparisonResult result = [date1 compare:date2];
                return result == NSOrderedAscending;
            }];
            [provinceRs close];
        }else{
            
            NSLog(@"地理位置数据库打开失败!");
        }
    }];
    if (positionPaixArrray.count == 0) {
        
        return NULL;
    }else{
        
        return [positionPaixArrray objectAtIndex:0];
    }
}

@end

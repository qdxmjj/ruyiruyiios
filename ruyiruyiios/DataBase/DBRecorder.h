//
//  DBRecorder.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/12.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "FMDBCarFactory.h"
#import "FMDBCarBrand.h"
#import "FMDBCarVerhicle.h"
#import "FMDBCarTireInfo.h"
#import "FMDBCarTireType.h"
#import "FMDBPosition.h"
#import "FMDBUserInfo.h"
#import "UserConfig.h"

@interface DBRecorder : NSObject

//factory
+ (void)insertFactoryArray:(NSArray *)dataArray;
+ (NSArray *)getFactoryData:(NSNumber *)brandId;

//brand
+ (void)insertBrandArray:(NSArray *)dataArray;
+ (NSArray *)getAllBrandData;

//Verhicle
+ (void)insertVerhicleArray:(NSArray *)dataArray;
+ (NSArray *)getVerhicleData:(NSNumber *)factoryId;

//TireInfo
+ (void)insertTireInfoArray:(NSArray *)dataArray;
+ (NSArray *)getTireInfoData:(NSNumber *)verhicleId;
+ (NSArray *)getTireInfoDataByTireinfoId:(NSNumber *)tireinfoId;
+ (NSArray *)getTireInfoData:(NSNumber *)verhicleId andpailiang:(NSString *)paiLiang;
+ (NSArray *)getTireInfoData:(NSNumber *)verhicleId andpailiang:(NSString *)paiLiang andYear:(NSNumber *)year;

//TireType
+ (void)insertTireTypeArray:(NSArray *)dataArray;
+ (NSArray *)getAllTiretypeData;
+ (NSArray *)getTiretypeDataByflatWidth:(NSString *)tireFlatWidth;
+ (NSArray *)getTiretypeDataByflatRatio:(NSString *)flatRatio;

//Position
+ (void)insertPositionArray:(NSArray *)dataArray;
+ (NSArray *)getProvinceArray:(NSNumber *)definition;
+ (NSArray *)getCityArray:(NSNumber *)positionId;
+ (NSArray *)getPro_City_id:(NSString *)name;
@end

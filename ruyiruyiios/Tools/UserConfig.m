//
//  UserConfig.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/4/26.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "UserConfig.h"
@implementation UserConfig

+(void)userDefaultsSetObject:(id)object key:(NSString *)key{
    
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(id)userDefaultsGetObjectForKey:(NSString *)key{
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:key]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:key];
    }else{
        return NULL;
    }
}

+(NSString *)currentCity{
    if ([self userDefaultsGetObjectForKey:@"currentCity"] == NULL) {
        return @"青岛市";
    }
    return [self userDefaultsGetObjectForKey:@"currentCity"];
}

+(NSNumber *)age{
    
    return [self userDefaultsGetObjectForKey:@"age"];
}

+(NSString *)birthday{
    
    return [self userDefaultsGetObjectForKey:@"birthday"];
}

+(NSString *)createTime{
    
    return [self userDefaultsGetObjectForKey:@"createTime"];
}

+(NSString *)createdBy{
    
    return [self userDefaultsGetObjectForKey:@"createdBy"];
}

+(NSString *)createdTime{
    
    return [self userDefaultsGetObjectForKey:@"createdTime"];
}

+(NSString *)deletedBy{
    
    return [self userDefaultsGetObjectForKey:@"deletedBy"];
}

+(NSString *)deletedFlag{
    
    return [self userDefaultsGetObjectForKey:@"deletedFlag"];
}

+(NSString *)deletedTime{
    
    return [self userDefaultsGetObjectForKey:@"deletedTime"];
}

+(NSString *)email{
    
    return [self userDefaultsGetObjectForKey:@"email"];
}

+(NSNumber *)firstAddCar{
    
    return [self userDefaultsGetObjectForKey:@"firstAddCar"];
}

+(NSNumber *)gender{
    
    return [self userDefaultsGetObjectForKey:@"gender"];
}

+(NSString *)headimgurl{
    
    return [self userDefaultsGetObjectForKey:@"headimgurl"];
}

+(NSNumber *)user_id{
    
    return [self userDefaultsGetObjectForKey:@"user_id"];
}

+(NSString *)invitationCode{
    
    return [self userDefaultsGetObjectForKey:@"invitationCode"];
}

+(NSString *)lastUpdatedBy{
    
    return [self userDefaultsGetObjectForKey:@"lastUpdatedBy"];
}

+(NSString *)lastUpdatedTime{
    
    return [self userDefaultsGetObjectForKey:@"lastUpdatedTime"];
}

+(NSNumber *)ml{
    
    return [self userDefaultsGetObjectForKey:@"ml"];
}

+(NSString *)nick{
    
    return [self userDefaultsGetObjectForKey:@"nick"];
}

+(NSString *)password{
    
    return [self userDefaultsGetObjectForKey:@"password"];
}

+(NSString *)payPwd{
    
    return [self userDefaultsGetObjectForKey:@"payPwd"];
}

+(NSString *)phone{
    
    return [self userDefaultsGetObjectForKey:@"phone"];
}

+(NSString *)qqInfoId{
    
    return [self userDefaultsGetObjectForKey:@"qqInfoId"];
}

+(NSString *)remark{
    
    return [self userDefaultsGetObjectForKey:@"remark"];
}

+(NSNumber *)status{
    
    return [self userDefaultsGetObjectForKey:@"status"];
}

+(NSString *)token{
    
    return [self userDefaultsGetObjectForKey:@"token"];
}

+(NSString *)updateTime{
    
    return [self userDefaultsGetObjectForKey:@"updateTime"];
}

+(NSString *)version{
    
    return [self userDefaultsGetObjectForKey:@"version"];
}

+(NSString *)wxInfoId{
    
    return [self userDefaultsGetObjectForKey:@"wxInfoId"];
}

+(NSNumber *)userCarId{
    
    return [self userDefaultsGetObjectForKey:@"userCarId"];
}

+(NSString *)selectCityName{
    if ([self userDefaultsGetObjectForKey:@""] == NULL) {
        return @"青岛市";
    }
    return [self userDefaultsGetObjectForKey:@"selectCityName"];
}

+ (NSString *)integral{
    
    return [self userDefaultsGetObjectForKey:@"kIntegral"];
}

+ (NSString *)authenticatedState{
    
    
    return [self userDefaultsGetObjectForKey:@"kAuthenticatedState"];
}
@end

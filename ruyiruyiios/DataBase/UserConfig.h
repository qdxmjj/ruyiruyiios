//
//  UserConfig.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/4/26.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserConfig : NSObject


+(void)userDefaultsSetObject:(id)object key:(NSString *)key;

+(id)userDefaultsGetObjectForKey:(NSString *)key;

+(NSNumber *)age;

+(NSString *)birthday;

+(NSString *)createTime;

+(NSString *)createdBy;

+(NSString *)createdTime;

+(NSString *)deletedBy;

+(NSString *)deletedFlag;

+(NSString *)deletedTime;

+(NSString *)email;

+(NSNumber *)firstAddCar;

+(NSNumber *)gender;

+(NSString *)headimgurl;

+(NSNumber *)user_id;

+(NSString *)invitationCode;

+(NSString *)lastUpdatedBy;

+(NSString *)lastUpdatedTime;

+(NSNumber *)ml;

+(NSString *)nick;

+(NSString *)password;

+(NSString *)payPwd;

+(NSString *)phone;

+(NSString *)qqInfoId;

+(NSString *)remark;

+(NSNumber *)status;

+(NSString *)token;

+(NSString *)updateTime;

+(NSString *)version;

+(NSString *)wxInfoId;

+(NSNumber *)userCarId;
@end

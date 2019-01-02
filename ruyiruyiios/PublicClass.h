//
//  PublicClass.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/8.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>

@interface PublicClass : NSObject

+ (void)showHUD:(NSString *)HUDStr view:(UIView *)selfView;
+ (NSString *)convertToJsonData:(id)object;
+ (NSString *)gettodayDate;
+(NSString *)md5:(NSString *)str;
+ (BOOL)valiMobile:(NSString *)mobile;
+ (BOOL) validateEmail:(NSString *)email;
+ (CGSize)getLabelSize:(UILabel *)label fontsize:(CGFloat)fontsize;
+ (NSString *)returnDateStrselectYear:(NSInteger)year selectMonth:(NSInteger)month selectDay:(NSInteger)day;
+(NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format;
+ (UIColor *) colorWithHexString: (NSString *)color;
+ (NSString *)doEncryptStr:(NSString *)originalStr key:(NSString *)keyStr;

+(BOOL)isCurrentMonth:(NSString *)oldDate;//比较当前时间日期与旧的时间日期 判断是否是当前月

+(NSString *)getTimestampFromTime:(NSString *)timeStampString formatter:(NSString *)format;//时间戳转时间
+(NSString *)getDateWithformatter:(NSString *)format;//基本时间日期



@end

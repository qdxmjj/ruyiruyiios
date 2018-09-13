//
//  YMTools.h
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/11.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMTools : NSObject

/**
 *总价格红色
 */
+(NSMutableAttributedString *)priceWithRedString:(NSString *)red;

+(void)openBaiDuMapWithAddress:(NSString *)address latitude:(NSString *)latitude longitude:(NSString *)longitude;

+(void)openGaoDeMapWithAddress:(NSString *)address latitude:(NSString *)latitude longitude:(NSString *)longitude;


+ (void)openAppleMapWithAddress:( NSString * _Nonnull )address latitude:( NSString * _Nonnull )latitude longitude:( NSString * _Nonnull )longitude;
@end

@interface NSString (Category)

-(NSString *_Nonnull)UTF8Value;
@end

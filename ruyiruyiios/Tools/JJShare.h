//
//  JJShare.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/7/2.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKUI/ShareSDKUI.h>
#import <WXApi.h>
@interface JJShare : NSObject

/*
 * http://www.mob.com  
 */

//注册分享
+(void)ShareRegister;

/*设置分享参数
 分享界面
 */
+(void)ShareDescribe:(NSString *)describe images:(id)images url:(NSString *)url title:(NSString *)title type:(SSDKContentType)type;

@end

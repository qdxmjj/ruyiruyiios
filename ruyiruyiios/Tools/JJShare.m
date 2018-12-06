//
//  JJShare.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/7/2.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "JJShare.h"
#import "MBProgressHUD+YYM_category.h"
@implementation JJShare

+(void)ShareRegister{
    
    
    [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister) {
       
        [platformsRegister setupWeChatWithAppId:@"wx407c59de8b10c601" appSecret:@"e1d142170ca69c78838af93dbcdc6b1e"];
    }];
    
//    [ShareSDK registerActivePlatforms:@[@(SSDKPlatformSubTypeWechatSession),@(SSDKPlatformSubTypeWechatTimeline)] onImport:^(SSDKPlatformType platformType) {
//
//        switch (platformType) {
//            case SSDKPlatformTypeWechat:
//
//                [ShareSDKConnector connectWeChat:[WXApi class]];
//
//                break;
//
//            default:
//                break;
//        }
//
//    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
//
//        switch (platformType) {
//            case SSDKPlatformTypeWechat:
//
//
//                //注册 mob 设置应用 填写应用appid
//                [appInfo SSDKSetupWeChatByAppId:@"wx407c59de8b10c601" appSecret:@"e1d142170ca69c78838af93dbcdc6b1e"];
//
//                break;
//
//            default:
//                break;
//        }
//
//    }];
}



+(void)ShareDescribe:(NSString *)describe images:(id)images url:(NSString *)url title:(NSString *)title type:(SSDKContentType)type
{
    if (![WXApi isWXAppInstalled]) {
        
        [MBProgressHUD showTextMessage:@"未检测到微信，请先安装微信！"];
        return;
    };
    
    
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        
    [shareParams SSDKSetupShareParamsByText:describe images:images url:[NSURL URLWithString:url] title:title type:type];
        
    [ShareSDK showShareActionSheet:nil customItems:nil shareParams:shareParams sheetConfiguration:nil onStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
            
    }];
    
}


@end

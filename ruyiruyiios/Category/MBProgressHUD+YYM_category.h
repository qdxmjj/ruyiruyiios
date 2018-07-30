//
//  MBProgressHUD+YYM_category.h
//  QGliuzao
//
//  Created by 姚永敏 on 2018/1/12.
//  Copyright © 2018年 姚永敏. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (YYM_category)

/**
 *  正在加载
 */
+ (void)showWaitMessage:(NSString *)message showView:(UIView *)view;

+(void)hideWaitViewAnimated:(UIView *)view;

+(void)showTextMessage:(NSString *)message;

+(void)showError:(NSString *)message integer:(NSInteger )ErrorCode;
@end

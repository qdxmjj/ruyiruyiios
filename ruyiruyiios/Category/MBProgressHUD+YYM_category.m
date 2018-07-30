//
//  MBProgressHUD+YYM_category.m
//  QGliuzao
//
//  Created by 姚永敏 on 2018/1/12.
//  Copyright © 2018年 姚永敏. All rights reserved.
//

#import "MBProgressHUD+YYM_category.h"

@implementation MBProgressHUD (YYM_category)

+(void)showTextMessage:(NSString *)message{
    

    [self MBProgressHUDWithTextMessage:message];
    return;
}

+(void)showError:(NSString *)message integer:(NSInteger )ErrorCode{
    
    NSString *Error = [NSString stringWithFormat:@"%@（%ld）",message,(long)ErrorCode];

    [self MBProgressHUDWithTextMessage:Error];
    return;
}

+ (void)showWaitMessage:(NSString *)message showView:(UIView *)view{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    [hud showAnimated:YES];
}

+(void)hideWaitViewAnimated:(UIView *)view{
    
    //    [self hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
    
    [self hideHUDForView:view animated:YES];
}


+(void)MBProgressHUDWithTextMessage:(NSString *)message {
    if ([UIApplication sharedApplication].keyWindow) {
        
        
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows lastObject] animated:YES];
    hud.label.text = message;
    hud.mode = MBProgressHUDModeText;
    
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:1.5];
    
    return;
}
@end

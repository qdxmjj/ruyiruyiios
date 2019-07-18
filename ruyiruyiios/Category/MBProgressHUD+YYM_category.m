//
//  MBProgressHUD+YYM_category.m
//  QGliuzao
//
//  Created by 姚永敏 on 2018/1/12.
//  Copyright © 2018年 姚永敏. All rights reserved.
//

#import "MBProgressHUD+YYM_category.h"
#import "UIView+extension.h"
@implementation MBProgressHUD (YYM_category)

+(void)showTextMessage:(NSString *)message{
    

    [self MBProgressHUDWithTextMessage:message];
    return;
}

+(void)showBottomTextMessage:(NSString *)msg showView:(UIView *)view{
    
    MBProgressHUD *hud;
    if (!view) {
        
        hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows lastObject] animated:YES];
    }else{
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    hud.offset = CGPointMake(0.f, MAINSCREEN.height-88);
    hud.label.text = msg;
    hud.mode = MBProgressHUDModeText;
    
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:2.5];
    
}

+(void)showError:(NSString *)message integer:(NSInteger )ErrorCode{
    
    NSString *Error = [NSString stringWithFormat:@"%@（%ld）",message,(long)ErrorCode];

    [self MBProgressHUDWithTextMessage:Error];
    return;
}

+ (void)showWaitMessage:(NSString *)message showView:(UIView *)view{
    MBProgressHUD *hud;
    if (!view) {
        
        hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    }else{
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    hud.label.text = message;
    [hud showAnimated:YES];
}

+(void)hideWaitViewAnimated:(UIView *)view{
    
    //    [self hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];    
    if (!view) {
        
        [self hideHUDForView:[[UIApplication sharedApplication].windows lastObject] animated:YES];
    }else{
        [self hideHUDForView:view animated:YES];
    }
}


+(void)MBProgressHUDWithTextMessage:(NSString *)message {
    if ([UIApplication sharedApplication].keyWindow) {
        
        
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.label.text = message;
    hud.mode = MBProgressHUDModeText;
    
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:1.5];
    
    return;
}
@end

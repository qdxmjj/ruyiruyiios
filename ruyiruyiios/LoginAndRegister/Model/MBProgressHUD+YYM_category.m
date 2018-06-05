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
    
    NSString *Error = [NSString stringWithFormat:@"%@（%ld）",message,ErrorCode];

    [self MBProgressHUDWithTextMessage:Error];
    return;
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

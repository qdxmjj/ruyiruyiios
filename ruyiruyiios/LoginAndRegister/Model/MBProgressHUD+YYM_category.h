//
//  MBProgressHUD+YYM_category.h
//  QGliuzao
//
//  Created by 姚永敏 on 2018/1/12.
//  Copyright © 2018年 姚永敏. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (YYM_category)



+(void)showTextMessage:(NSString *)message;

+(void)showError:(NSString *)message integer:(NSInteger )ErrorCode;
@end

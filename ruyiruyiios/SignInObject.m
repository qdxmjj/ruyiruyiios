//
//  SignInObject.m
//  ruyiruyiios
//
//  Created by 姚永敏 on 2018/12/27.
//  Copyright © 2018 ruyiruyi. All rights reserved.
//

#import "SignInObject.h"
#import "MBProgressHUD+YYM_category.h"
@implementation SignInObject

+(void)startSignInAndshowView:(UIView *)view{
    
    if (![UserConfig user_id] || [[UserConfig user_id] isEqual:[NSNull null]]) {
        
        return;
    }

    [JJRequest getRequest:[NSString stringWithFormat:@"%@/score/info",SERVERPREFIX] params:@{@"userId":[NSString stringWithFormat:@"%@",[UserConfig user_id]]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if ([code integerValue] == 1) {
            
            if ([data[@"signState"] integerValue] == 1) {
                
                NSLog(@"未签到");
                
                [JJRequest postRequest:@"score/sign" params:@{@"userId":[NSString stringWithFormat:@"%@",[UserConfig user_id]]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
                    
                    if ([code integerValue] != 1) {
                        
                        return ;
                    }
                    
                    NSLog(@"%@",data);
                    
                    NSString *signInCount = data[@"continuousMonth"];
                    
                    NSArray *couponArr = data[@"couponList"];
                    
                    NSString *couponName;

                    if (couponArr.count>0) {
                        
                        couponName = data[@"couponList"][0];
                    }else{
                        couponName = @"";
                    }
                    
                    NSString *addedScore = data[@"addedScore"];
                    
                    NSString *msg = [NSString stringWithFormat:@"已连续签到:%@次，本次签到获取:%@积分 %@",signInCount,addedScore,couponName];
                    
                    [MBProgressHUD showBottomTextMessage:msg showView:view];
                } failure:^(NSError * _Nullable error) {
                    
                }];
            }
//            NSLog(@"积分：%@",data[@"totalScore"]);
//            NSLog(@"总签到次数：%@",data[@"currentMonthSignAmount"]);
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}
@end

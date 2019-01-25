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

    [JJRequest getRequest:[NSString stringWithFormat:@"%@/score/info",INTEGRAL_IP] params:@{@"userId":[NSString stringWithFormat:@"%@",[UserConfig user_id]]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if ([code integerValue] == 1) {
            
            if ([data[@"signState"] integerValue] == 0) {
                
                NSLog(@"未签到");
                
                [JJRequest interchangeablePostRequestWithIP:INTEGRAL_IP path:@"score/sign" params:@{@"userId":[NSString stringWithFormat:@"%@",[UserConfig user_id]],@"token":[UserConfig token]} success:^(id  _Nullable data) {
                    
                    if ([data[@"status"] integerValue] != 1) {
                        
                        return ;
                    }
                    
                    NSLog(@"签到信息：%@",data);
                    NSDictionary *integralDic = data[@"data"];
                    
                    NSString *signInCount = integralDic[@"continuousMonth"];
                    
                    NSArray *couponArr = integralDic[@"couponList"];
                    
                    NSString *couponName;
                    
                    if (couponArr.count>0) {
                        
                        couponName = integralDic[@"couponList"][0];
                    }else{
                        couponName = @"";
                    }
                    
                    NSString *addedScore = integralDic[@"addedScore"];
                    
                    NSString *msg = [NSString stringWithFormat:@"已连续签到:%@次，本次签到获取:%@积分 %@",signInCount,addedScore,couponName];
                    
                    [MBProgressHUD showBottomTextMessage:msg showView:view];
                } failure:^(NSError * _Nullable error) {
                    
                }];
            }
////            NSLog(@"积分：%@",data[@"totalScore"]);
////            NSLog(@"总签到次数：%@",data[@"currentMonthSignAmount"]);
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}
@end

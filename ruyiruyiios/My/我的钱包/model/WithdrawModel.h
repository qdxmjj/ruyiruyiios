//
//  WithdrawModel.h
//  ruyiRuyi
//
//  Created by 姚永敏 on 2018/10/18.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WithdrawModel : NSObject

@property(nonatomic,copy)NSString *remark;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,copy)NSString *money;
@property(nonatomic,copy)NSString *orderNo;
@property(nonatomic,strong)NSNumber *status;//提现状态（1提现中/2提现成功/3提现失败）
@property(nonatomic,copy)NSNumber *type; //收支类型 1 支出 2 收入
@property(nonatomic,copy)NSNumber *expensesType; ////支出类型(1 支付宝 2 微信)）


@end

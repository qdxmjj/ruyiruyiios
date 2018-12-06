//
//  RecordingDetailsView.h
//  ruyiRuyi
//
//  Created by 姚永敏 on 2018/10/19.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordingDetailsView : UIView

@property(nonatomic,copy)NSString *isPayStatus;//支出类型(1 支付宝 2 微信)

@property(nonatomic,copy)NSString *withdrawAmount;

@property(nonatomic,copy)NSString *withdrawStatus;//提现状态（1 提现中 2 成功 3 失败）

@property(nonatomic,copy)NSString *receiptInfo;

@property(nonatomic,copy)NSString *date;

@property(nonatomic,copy)NSString *orderNO;

@property(nonatomic,copy)NSString *type;//收支类型 1 支出 2 收入
-(void)show;

-(void)dismiss;

@end

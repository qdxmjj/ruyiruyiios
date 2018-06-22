//
//  MyQuotaMiddleView.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/22.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyQuotaMiddleView : UIView<UITextFieldDelegate>

@property(nonatomic, strong)UILabel *repayLabel;
@property(nonatomic, strong)UITextField *realRepayTF;
@property(nonatomic, strong)UIButton *removeTFBtn;
@property(nonatomic, strong)UIButton *updateMoneyNumberBtn;
@property(nonatomic, strong)UILabel *mostRepayLabel;
@property(nonatomic, strong)UIView *underLineView;

- (void)setDatatoHeadView:(float)creditFloat remainCredit:(float)remainCreditFloat;

@end

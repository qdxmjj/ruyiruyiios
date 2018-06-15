//
//  PersonAlertEmailView.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/14.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonAlertEmailView : UIView<UITextFieldDelegate>

@property(nonatomic, strong)UITextField *emailTF;
@property(nonatomic, strong)UIButton *sureBtn;
@property(nonatomic, strong)UIButton *cancelBtn;

@end

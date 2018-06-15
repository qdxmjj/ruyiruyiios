//
//  PersonAlertEmailView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/14.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "PersonAlertEmailView.h"

@implementation PersonAlertEmailView

- (UITextField *)emailTF{
    
    if (_emailTF == nil) {
        
        _emailTF = [[UITextField alloc] init];
        _emailTF.delegate = self;
        _emailTF.placeholder = @"请输入邮箱";
        _emailTF.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _emailTF.textColor = TEXTCOLOR64;
    }
    return _emailTF;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (UIButton *)sureBtn{
    
    if (_sureBtn == nil) {
        
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:LOGINBACKCOLOR forState:UIControlStateNormal];
    }
    return _sureBtn;
}

- (UIButton *)cancelBtn{
    
    if (_cancelBtn == nil) {
        
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _cancelBtn;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.emailTF];
        [self addSubview:self.sureBtn];
        [self addSubview:self.cancelBtn];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.emailTF.frame = CGRectMake(40, 30, MAINSCREEN.width - 80, 20);
    self.sureBtn.frame = CGRectMake(self.emailTF.frame.origin.x, self.emailTF.frame.origin.y+50, 40, 20);
    self.cancelBtn.frame = CGRectMake(self.emailTF.frame.origin.x+self.emailTF.frame.size.width - 60, self.emailTF.frame.origin.y+50, 40, 20);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

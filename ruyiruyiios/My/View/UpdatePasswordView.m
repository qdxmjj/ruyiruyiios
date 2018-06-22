//
//  UpdatePasswordView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/19.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "UpdatePasswordView.h"

@implementation UpdatePasswordView

- (UITextField *)originalTF{
    
    if (_originalTF == nil) {
        
        _originalTF = [[UITextField alloc] init];
        _originalTF.textColor = TEXTCOLOR64;
        _originalTF.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _originalTF.placeholder = @"请输入原密码";
        _originalTF.delegate = self;
        _originalTF.secureTextEntry = YES;
    }
    return _originalTF;
}

- (UITextField *)newTF{
    
    if (_newTF == nil) {
        
        _newTF = [[UITextField alloc] init];
        _newTF.textColor = TEXTCOLOR64;
        _newTF.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _newTF.placeholder = @"请输入新密码";
        _newTF.delegate = self;
        _newTF.secureTextEntry = YES;
    }
    return _newTF;
}

- (UITextField *)sureNewTF{
    
    if (_sureNewTF == nil) {
        
        _sureNewTF = [[UITextField alloc] init];
        _sureNewTF.textColor = TEXTCOLOR64;
        _sureNewTF.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _sureNewTF.placeholder = @"请确认新密码";
        _sureNewTF.delegate = self;
        _sureNewTF.secureTextEntry = YES;
    }
    return _sureNewTF;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imgArray = @[@"ic_yuanmima", @"ic_mima", @"ic_mima"];
        [self addUnchangeView];
        [self addChangeView];
    }
    return self;
}

- (void)addUnchangeView{
    
    for (int i = 0; i<self.imgArray.count; i++) {
        
        UIImageView *iconImageV = [[UIImageView alloc] init];
        if (i == 0) {
            
            iconImageV.frame = CGRectMake(20, 20, 19, 19);
        }else{
            
            iconImageV.frame = CGRectMake(20, 60+(i - 1)*44, 15, 24);
        }
        iconImageV.image = [UIImage imageNamed:self.imgArray[i]];
        [self addSubview:iconImageV];
    }
}

- (void)addChangeView{
    
    [self addSubview:self.originalTF];
    [self addSubview:self.newTF];
    [self addSubview:self.sureNewTF];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.originalTF.frame = CGRectMake(60, 20, MAINSCREEN.width - 60, 20);
    self.newTF.frame = CGRectMake(60, 66, MAINSCREEN.width - 60, 20);
    self.sureNewTF.frame = CGRectMake(60, 106, MAINSCREEN.width - 60, 20);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

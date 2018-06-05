//
//  NumberSelectView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/1.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "NumberSelectView.h"
#import "MBProgressHUD+YYM_category.h"

@implementation NumberSelectView

- (UIButton *)leftBtn{
    
    if (_leftBtn == nil) {
        
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.tag = 1;
        _leftBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _leftBtn.layer.borderWidth = 0.8;
        _leftBtn.backgroundColor = [UIColor whiteColor];
        _leftBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        [_leftBtn addTarget:self action:@selector(chickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_leftBtn setTitle:@"-" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _leftBtn;
}

- (UILabel *)numberLabel{
    
    if (_numberLabel == nil) {
        
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.layer.borderWidth = 0.8;
        _numberLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _numberLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _numberLabel.text = @"0";
        _numberLabel.textColor = [UIColor blackColor];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.backgroundColor = [UIColor whiteColor];
    }
    return _numberLabel;
}

- (UIButton *)rightBtn{
    
    if (_rightBtn == nil) {
        
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.tag = 2;
        _rightBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _rightBtn.layer.borderWidth = 0.8;
        _rightBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        [_rightBtn addTarget:self action:@selector(chickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_rightBtn setTitle:@"+" forState:UIControlStateNormal];
        _rightBtn.backgroundColor = [UIColor whiteColor];
    }
    return _rightBtn;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.leftBtn];
        [self addSubview:self.numberLabel];
        [self addSubview:self.rightBtn];
    }
    return self;
}

- (void)chickBtn:(UIButton *)button{
    
    NSInteger number = [self.numberLabel.text integerValue];
    if (button.tag == 1) {
        
        if (number < 1) {
            
            [MBProgressHUD showTextMessage:@"数量不可为负数"];
            return;
        }else{
            
            number--;
        }
    }else{
        
        if (number > 9) {
            
            [MBProgressHUD showTextMessage:@"数量超过上限"];
            return;
        }else{
            
            number++;
        }
    }
    self.numberLabel.text = [NSString stringWithFormat:@"%ld", number];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.leftBtn.frame = CGRectMake(30, 0, 30, 30);
    self.numberLabel.frame = CGRectMake(60, 0, 50, 30);
    self.rightBtn.frame =CGRectMake(110, 0, 30, 30);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

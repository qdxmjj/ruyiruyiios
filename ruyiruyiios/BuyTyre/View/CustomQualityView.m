//
//  CustomQualityView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/1.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "CustomQualityView.h"

@implementation CustomQualityView

- (UIView *)leftView{
    
    if (_leftView == nil) {
        
        _leftView = [[UIView alloc] init];
        _leftView.backgroundColor = [UIColor lightGrayColor];
    }
    return _leftView;
}

- (UILabel *)customTitleLabel{
    
    if (_customTitleLabel == nil) {
        
        _customTitleLabel = [[UILabel alloc] init];
        _customTitleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _customTitleLabel.textColor = TEXTCOLOR64;
        _customTitleLabel.text = @"在如驿如意购物您可享受到一下品质服务";
    }
    return _customTitleLabel;
}

- (UIView *)rightView{
    
    if (_rightView == nil) {
        
        _rightView = [[UIView alloc] init];
        _rightView.backgroundColor = [UIColor lightGrayColor];
    }
    return _rightView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.customTitleLabel];
        [self addSubview:self.leftView];
        [self addSubview:self.rightView];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    CGSize size = [self.customTitleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.customTitleLabel.font, NSFontAttributeName, nil]];
    self.customTitleLabel.frame = CGRectMake(MAINSCREEN.width/2 - size.width/2, 0, size.width, size.height);
    self.leftView.frame = CGRectMake(10, 9.5, (MAINSCREEN.width/2 - size.width/2 - 10) - 2, 0.5);
    self.rightView.frame = CGRectMake(MAINSCREEN.width/2 + size.width/2+2, 9.5, (MAINSCREEN.width/2 - size.width/2 - 10)-2, 0.5);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  PaySuccessBackView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/13.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "PaySuccessBackView.h"

@implementation PaySuccessBackView

- (UIImageView *)bigImageV{
    
    if (_bigImageV == nil) {
        
        _bigImageV = [[UIImageView alloc] init];
    }
    return _bigImageV;
}

- (UIImageView *)smallImageV{
    
    if (_smallImageV == nil) {
        
        _smallImageV = [[UIImageView alloc] init];
    }
    return _smallImageV;
}

- (UIImageView *)rightImageV{
    
    if (_rightImageV == nil) {
        
        _rightImageV = [[UIImageView alloc] init];
    }
    return _rightImageV;
}

- (UILabel *)successLabel{
    
    if (_successLabel == nil) {
        
        _successLabel = [[UILabel alloc] init];
        _successLabel.font = [UIFont fontWithName:TEXTFONT size:24.0];
        _successLabel.textColor = [UIColor whiteColor];
        _successLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _successLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.bigImageV];
        [self addSubview:self.smallImageV];
        [self addSubview:self.rightImageV];
        [self addSubview:self.successLabel];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.bigImageV.frame = CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height - 64 - 80 - 140);
    self.smallImageV.frame = CGRectMake(MAINSCREEN.width/2 - 80, self.bigImageV.frame.size.height - 80, 160, 160);
    self.rightImageV.frame = CGRectMake(MAINSCREEN.width/2 - 25, self.bigImageV.frame.size.height - 210, 50, 50);
    self.successLabel.frame = CGRectMake(0, self.bigImageV.frame.size.height - 145, MAINSCREEN.width, 24);
}

- (void)setDatatoViews{
    
    self.bigImageV.image = [UIImage imageNamed:@"pic_back"];
    self.smallImageV.image = [UIImage imageNamed:@"pic_tu"];
    self.rightImageV.image = [UIImage imageNamed:@"pic_right"];
    self.successLabel.text = @"支付成功";
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

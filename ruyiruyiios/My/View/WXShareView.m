//
//  WXShareView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/25.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "WXShareView.h"

@implementation WXShareView

- (UIButton *)weixinBtn{
    
    if (_weixinBtn == nil) {
        
        _weixinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_weixinBtn setImage:[UIImage imageNamed:@"ic_t_wechat"] forState:UIControlStateNormal];
    }
    return _weixinBtn;
}

- (UIButton *)friendsBtn{
    
    if (_friendsBtn == nil) {
        
        _friendsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_friendsBtn setImage:[UIImage imageNamed:@"ic_pengyou"] forState:UIControlStateNormal];
    }
    return _friendsBtn;
}

- (UILabel *)weixinLabel{
    
    if (_weixinLabel == nil) {
        
        _weixinLabel = [[UILabel alloc] init];
        _weixinLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _weixinLabel.textColor = TEXTCOLOR64;
        _weixinLabel.text = @"微信";
        _weixinLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _weixinLabel;
}

- (UILabel *)friendsLabel{
    
    if (_friendsLabel == nil) {
        
        _friendsLabel = [[UILabel alloc] init];
        _friendsLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _friendsLabel.textColor = TEXTCOLOR64;
        _friendsLabel.text = @"朋友圈";
        _friendsLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _friendsLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.weixinBtn];
        [self addSubview:self.friendsBtn];
        [self addSubview:self.weixinLabel];
        [self addSubview:self.friendsLabel];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.weixinBtn.frame = CGRectMake((self.frame.size.width/2 - 55)/2, 10, 55, 55);
    self.friendsBtn.frame = CGRectMake((self.frame.size.width/2 + (self.frame.size.width/2 - 55)/2), 10, 55, 55);
    self.weixinLabel.frame = CGRectMake((self.frame.size.width/2 - 55)/2, 70, 55, 20);
    self.friendsLabel.frame = CGRectMake((self.frame.size.width/2 + (self.frame.size.width/2 - 55)/2), 70, 55, 20);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

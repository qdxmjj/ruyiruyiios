//
//  ExtensionHeadView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/20.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "ExtensionHeadView.h"

@implementation ExtensionHeadView

- (UIImageView *)iconImageV{
    
    if (_iconImageV == nil) {
        
        _iconImageV = [[UIImageView alloc] init];
    }
    return _iconImageV;
}

- (UILabel *)codeLabel{
    
    if (_codeLabel == nil) {
        
        _codeLabel = [[UILabel alloc] init];
        _codeLabel.font = [UIFont boldSystemFontOfSize:25.0];
        _codeLabel.textColor = [UIColor blackColor];
        _codeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _codeLabel;
}

- (UIButton *)shareBtn{
    
    if (_shareBtn == nil) {
        
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareBtn.layer.cornerRadius = 6.0;
        _shareBtn.layer.masksToBounds = YES;
        _shareBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        [_shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _shareBtn;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {

        [self addSubview:self.iconImageV];
        [self addSubview:self.codeLabel];
        [self addSubview:self.shareBtn];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.iconImageV.frame = CGRectMake((MAINSCREEN.width - 150)/2, 10, 150, 150);
    self.codeLabel.frame = CGRectMake(0, 97, MAINSCREEN.width, 25);
    self.shareBtn.frame = CGRectMake(10, 170, MAINSCREEN.width - 20, 34);
}

- (void)setdatatoViews:(NSString *)codeStr{
    
    self.iconImageV.image = [UIImage imageNamed:@"ic_people"];
    self.codeLabel.text = codeStr;
    [self.shareBtn setTitle:@"立即分享" forState:UIControlStateNormal];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  AboutUsHeadView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/19.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "AboutUsHeadView.h"

@implementation AboutUsHeadView

- (UIImageView *)iconImageV{
    
    if (_iconImageV == nil) {
        
        _iconImageV = [[UIImageView alloc] init];
    }
    return _iconImageV;
}

- (UILabel *)versionLabel{
    
    if (_versionLabel == nil) {
        
        _versionLabel = [[UILabel alloc] init];
        _versionLabel.font = [UIFont fontWithName:TEXTFONT size:12.0];
        _versionLabel.textColor = TEXTCOLOR64;
        _versionLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _versionLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.iconImageV];
        [self addSubview:self.versionLabel];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.iconImageV.frame = CGRectMake((MAINSCREEN.width - 200)/2, 0, 200, 115);
    self.versionLabel.frame = CGRectMake(0, 118, MAINSCREEN.width, 20);
}

- (void)setversionLabelText:(NSString *)textStr imgStr:(NSString *)imageNamestr{
    
    self.versionLabel.text = textStr;
    self.iconImageV.image = [UIImage imageNamed:imageNamestr];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

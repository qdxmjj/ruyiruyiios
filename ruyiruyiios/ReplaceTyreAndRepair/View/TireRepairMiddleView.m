//
//  TireRepairMiddleView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/26.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "TireRepairMiddleView.h"

@implementation TireRepairMiddleView

- (UILabel *)userNameLabel{
    
    if (_userNameLabel == nil) {
        
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.textColor = [UIColor lightGrayColor];
        _userNameLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _userNameLabel.textAlignment = NSTextAlignmentRight;
    }
    return _userNameLabel;
}

- (UILabel *)userPhoneLabel{
    
    if (_userPhoneLabel == nil) {
        
        _userPhoneLabel = [[UILabel alloc] init];
        _userPhoneLabel.textColor = [UIColor lightGrayColor];
        _userPhoneLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _userPhoneLabel.textAlignment = NSTextAlignmentRight;
    }
    return _userPhoneLabel;
}

- (UILabel *)userPlatNumberLabel{
    
    if (_userPlatNumberLabel == nil) {
        
        _userPlatNumberLabel = [[UILabel alloc] init];
        _userPlatNumberLabel.textColor = [UIColor lightGrayColor];
        _userPlatNumberLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _userPlatNumberLabel.textAlignment = NSTextAlignmentRight;
    }
    return _userPlatNumberLabel;
}

- (UIView *)underLineView{
    
    if (_underLineView == nil) {
        
        _underLineView = [[UIView alloc] init];
    }
    return _underLineView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        NSArray *labelNameArray = @[@"联系人", @"联系电话", @"车牌号码"];
        [self addUnchangeViews:labelNameArray];
        [self addChangeViews];
    }
    return self;
}

- (void)addUnchangeViews:(NSArray *)array{
    
    for (int i = 0; i<array.count; i++) {
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15+35*i, MAINSCREEN.width/2 - 20, 20)];
        titleLabel.text = array[i];
        titleLabel.textColor = TEXTCOLOR64;
        titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:titleLabel];
    }
}

- (void)addChangeViews{
    
    [self addSubview:self.userNameLabel];
    [self addSubview:self.userPhoneLabel];
    [self addSubview:self.userPlatNumberLabel];
    [self addSubview:self.underLineView];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.userNameLabel.frame = CGRectMake(MAINSCREEN.width/2, 15, MAINSCREEN.width/2 - 20, 20);
    self.userPhoneLabel.frame = CGRectMake(MAINSCREEN.width/2, 50, MAINSCREEN.width/2 - 20, 20);
    self.userPlatNumberLabel.frame = CGRectMake(MAINSCREEN.width/2, 85, MAINSCREEN.width/2 - 20, 20);
    self.underLineView.frame = CGRectMake(0, 119, MAINSCREEN.width, 1);
}

- (void)setdatatoViews:(NSString *)platNumberStr{
    
    self.userNameLabel.text = [UserConfig nick];
    self.userPhoneLabel.text = [UserConfig phone];
    self.userPlatNumberLabel.text = platNumberStr;
    self.underLineView.backgroundColor = [PublicClass colorWithHexString:@"#ececec"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

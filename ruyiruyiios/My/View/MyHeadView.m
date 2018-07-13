//
//  MyHeadView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/7.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "MyHeadView.h"
#import <UIImageView+WebCache.h>

@implementation MyHeadView

- (UIImageView *)backImageV{
    
    if (_backImageV == nil) {
        
        _backImageV = [[UIImageView alloc] init];
        _backImageV.image = [UIImage imageNamed:@"ic_ground"];
    }
    return _backImageV;
}

- (UIImageView *)headPortraitImageV{
    
    if (_headPortraitImageV == nil) {
        
        _headPortraitImageV = [[UIImageView alloc] init];
        _headPortraitImageV.layer.cornerRadius = 25.0;
        _headPortraitImageV.layer.masksToBounds = YES;
    }
    return _headPortraitImageV;
}

- (UILabel *)nameLabel{
    
    if (_nameLabel == nil) {
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

- (UIButton *)nameAndHeadBtn{
    
    if (_nameAndHeadBtn == nil) {
        
        _nameAndHeadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _nameAndHeadBtn.backgroundColor = [UIColor blackColor];
    }
    return _nameAndHeadBtn;
}

- (UIButton *)myQuotaBtn{
    
    if (_myQuotaBtn == nil) {
        
        _myQuotaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_myQuotaBtn setTitle:@"我的额度" forState:UIControlStateNormal];
        [_myQuotaBtn setTitleColor:TEXTCOLOR64 forState:UIControlStateNormal];
        _myQuotaBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
    }
    return _myQuotaBtn;
}

- (UIButton *)creditLineBtn{
    
    if (_creditLineBtn == nil) {
        
        _creditLineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_creditLineBtn setTitle:@"车辆额度列表" forState:UIControlStateNormal];
        [_creditLineBtn setTitleColor:TEXTCOLOR64 forState:UIControlStateNormal];
        _creditLineBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
    }
    return _creditLineBtn;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addUnchangeView];
        [self addChangeView];
    }
    return self;
}

- (void)addUnchangeView{
    
    UIView *midView = [[UIView alloc] initWithFrame:CGRectMake(MAINSCREEN.width/2, 140, 0.5, 50)];
    midView.backgroundColor = [PublicClass colorWithHexString:@"#ececec"];
    [self addSubview:midView];
    
    UIView *underLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 190, MAINSCREEN.width, 5)];
    underLineView.backgroundColor = [PublicClass colorWithHexString:@"#ececec"];
    [self addSubview:underLineView];
}

- (void)addChangeView{
    
    [self addSubview:self.backImageV];
    [self addSubview:self.headPortraitImageV];
    [self addSubview:self.nameLabel];
    [self addSubview:self.nameAndHeadBtn];
    [self addSubview:self.myQuotaBtn];
    [self addSubview:self.creditLineBtn];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.backImageV.frame = CGRectMake(0, 0, MAINSCREEN.width, 140);
    self.headPortraitImageV.frame = CGRectMake(MAINSCREEN.width/2 - 50/2, 40, 50, 50);
    self.nameLabel.frame = CGRectMake(MAINSCREEN.width/2 - 50, 100, 100, 20);
    self.nameAndHeadBtn.frame = CGRectMake(self.headPortraitImageV.frame.origin.x, 40, 100, 100);
    self.myQuotaBtn.frame = CGRectMake(0, 140, MAINSCREEN.width/2, 50);
    self.creditLineBtn.frame = CGRectMake(MAINSCREEN.width/2, 140, MAINSCREEN.width/2, 50);
}

- (void)setDatatoHeadView{
    
    if ([UserConfig user_id] == NULL || [[NSString stringWithFormat:@"%@", [UserConfig user_id]] isEqualToString:@""]) {
        
        self.headPortraitImageV.image = [UIImage imageNamed:@"ic_notlogged"];
        self.nameLabel.text = @"立即登录";
        self.nameLabel.layer.cornerRadius = 4.0;
        self.nameLabel.layer.masksToBounds = YES;
        self.nameLabel.layer.borderColor = [[UIColor whiteColor] CGColor];
        self.nameLabel.layer.borderWidth = 1.0;
    }else{
        
        [self.headPortraitImageV sd_setImageWithURL:[NSURL URLWithString:[UserConfig headimgurl]]];
        self.nameLabel.text = [UserConfig nick];
        self.nameLabel.layer.cornerRadius = 0.0;
        self.nameLabel.layer.masksToBounds = YES;
        self.nameLabel.layer.borderColor = [[UIColor clearColor] CGColor];
        self.nameLabel.layer.borderWidth = 0.0;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

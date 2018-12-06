//
//  MyHeadView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/7.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "MyHeadView.h"
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>
#import <Masonry.h>
@implementation MyHeadView

- (UIImageView *)backImageV{
    
    if (_backImageV == nil) {
        
        _backImageV = [[UIImageView alloc] init];
        _backImageV.image = [UIImage imageNamed:@"ic_ground"];
    }
    return _backImageV;
}

- (UIButton *)headPortraitBtn{
    
    if (_headPortraitBtn == nil) {
        
        _headPortraitBtn = [UIButton buttonWithType:UIButtonTypeCustom];

    }
    return _headPortraitBtn;
}

- (UIButton *)nameBtn{
    
    if (_nameBtn == nil) {
        
        _nameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _nameLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        [_nameBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nameBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _nameBtn;
}

- (UIButton *)myQuotaBtn{
    
    if (_myQuotaBtn == nil) {
        
        _myQuotaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_myQuotaBtn setBackgroundColor:[UIColor whiteColor]];
        [_myQuotaBtn setTitle:@"我的额度" forState:UIControlStateNormal];
        [_myQuotaBtn setTitleColor:TEXTCOLOR64 forState:UIControlStateNormal];
        _myQuotaBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
    }
    return _myQuotaBtn;
}

- (UIButton *)creditLineBtn{
    
    if (_creditLineBtn == nil) {
        
        _creditLineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_creditLineBtn setBackgroundColor:[UIColor whiteColor]];
        [_creditLineBtn setTitle:@"车辆额度列表" forState:UIControlStateNormal];
        [_creditLineBtn setTitleColor:TEXTCOLOR64 forState:UIControlStateNormal];
        _creditLineBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
    }
    return _creditLineBtn;
}
-(UIView *)lineView{
    
    if (!_lineView) {
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [PublicClass colorWithHexString:@"#ececec"];
    }
    return _lineView;
}
-(UIView *)spacingView{
    
    if (!_spacingView) {
        
        _spacingView = [[UIView alloc] init];
        _spacingView.backgroundColor = [PublicClass colorWithHexString:@"#ececec"];
    }
    return _spacingView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addChangeView];
    }
    return self;
}

- (void)addChangeView{
    
    [self addSubview:self.backImageV];
    [self addSubview:self.headPortraitBtn];
    [self addSubview:self.nameBtn];
    [self addSubview:self.myQuotaBtn];
    [self addSubview:self.creditLineBtn];
    [self addSubview:self.lineView];
    [self addSubview:self.spacingView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.backImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.mas_top);
        make.left.and.right.mas_equalTo(self);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.8);
    }];
    [self.headPortraitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.backImageV.mas_centerX);
        make.centerY.mas_equalTo(self.backImageV.mas_centerY);
        make.width.height.mas_equalTo(self.backImageV.mas_height).multipliedBy(0.4);
    }];
    
    _headPortraitBtn.layer.cornerRadius = (self.frame.size.height*0.8*0.4)/2;
    _headPortraitBtn.layer.masksToBounds = YES;
    
    [self.nameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.headPortraitBtn.mas_bottom).inset(3);
        make.centerX.mas_equalTo(self.headPortraitBtn.mas_centerX);
        make.height.mas_equalTo(25);
        
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.mas_bottom);
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(2);
    }];
    [self.spacingView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(2);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.2);
        make.bottom.mas_equalTo(self.lineView.mas_top);
    }];
    [self.myQuotaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.lineView.mas_bottom);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.spacingView.mas_left);
        make.height.mas_equalTo(self.spacingView.mas_height).offset(2);
    }];
    [self.creditLineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.lineView.mas_bottom);
        make.left.mas_equalTo(self.spacingView.mas_right);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(self.spacingView.mas_height).offset(2);
    }];
  
}

- (void)setDatatoHeadView{
    
    if ([UserConfig user_id] == NULL || [[NSString stringWithFormat:@"%@", [UserConfig user_id]] isEqualToString:@""]) {
        
        [self.headPortraitBtn setImage:[UIImage imageNamed:@"ic_notlogged"] forState:UIControlStateNormal];
        [self.nameBtn setTitle:@" 立 即 登 录 " forState:UIControlStateNormal];
        self.nameBtn.layer.cornerRadius = 12.5;
        self.nameBtn.layer.masksToBounds = YES;
        self.nameBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
        self.nameBtn.layer.borderWidth = 1.0;
    }else{
        
        [self.headPortraitBtn sd_setImageWithURL:[NSURL URLWithString:[UserConfig headimgurl]] forState:UIControlStateNormal];
        [self.nameBtn setTitle:[UserConfig nick] forState:UIControlStateNormal];
        self.nameBtn.layer.cornerRadius = 0.0;
        self.nameBtn.layer.masksToBounds = YES;
        self.nameBtn.layer.borderColor = [[UIColor clearColor] CGColor];
        self.nameBtn.layer.borderWidth = 0.0;
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

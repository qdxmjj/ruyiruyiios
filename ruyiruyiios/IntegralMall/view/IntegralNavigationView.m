//
//  IntegralNavigationView.m
//  Menu
//
//  Created by 姚永敏 on 2018/12/19.
//  Copyright © 2018 YYM. All rights reserved.
//

#import "IntegralNavigationView.h"
#import <Masonry.h>

@interface IntegralNavigationView ()

@property(nonatomic,strong)UIImageView *backGroundView;
@property(nonatomic,strong)UIButton *couponBtn;
@property (nonatomic, strong) UIImageView *rightView;

@end
@implementation IntegralNavigationView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.backGroundView];
        [self addSubview:self.numberLab];
        [self addSubview:self.couponBtn];
        [self addSubview:self.rightView];
    }
    return self;
}

- (void)layoutSubviews{
    
    [self.backGroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.mas_equalTo(self);
    }];
    
    [self.numberLab mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.mas_equalTo(self.mas_centerX);
//        当前高度 - 导航栏高度  / 2 为此控件的 中心点
        make.centerY.mas_equalTo(self.mas_centerY).offset(30);
        make.height.mas_equalTo(35);
    }];
    
    [self.couponBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.numberLab.mas_bottom).inset(2);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    [self.rightView mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.leading.mas_equalTo(self.couponBtn.mas_trailing).inset(3);
        make.centerY.mas_equalTo(self.couponBtn.mas_centerY);
        make.width.height.mas_equalTo(CGSizeMake(20, 20));
    }];
}

- (void)didSelectMyIntegral:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(integralNavigationView:didSelectMyIntegral:)]) {
        
        [self.delegate integralNavigationView:self didSelectMyIntegral:@""];
    }
}

- (UIImageView *)backGroundView{
    
    if (!_backGroundView) {
        
        _backGroundView = [[UIImageView alloc] init];
        _backGroundView.image = [UIImage imageNamed:@"ic_ground"];
    }
    return _backGroundView;
}

- (UILabel *)numberLab{
    
    if (!_numberLab) {
        
        _numberLab = [[UILabel alloc] init];
        _numberLab.text = @"0";
        _numberLab.font = [UIFont fontWithName:@"Avenir-Heavy" size:40.f];
        _numberLab.textColor = [UIColor whiteColor];
    }
    return _numberLab;
}

- (UIButton *)couponBtn{
    
    if (!_couponBtn) {
        
        _couponBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_couponBtn setTitle:@"我的积分" forState:UIControlStateNormal];
        [_couponBtn.titleLabel setFont:[UIFont systemFontOfSize:19.f]];
        [_couponBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_couponBtn addTarget:self action:@selector(didSelectMyIntegral:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _couponBtn;
}
- (UIImageView *)rightView{
    if (!_rightView) {
        
        _rightView = [[UIImageView alloc] init];
        _rightView.image = [UIImage imageNamed:@"ic_bai"];
        _rightView.contentMode = UIViewContentModeCenter;
    }
    return _rightView;
}
@end

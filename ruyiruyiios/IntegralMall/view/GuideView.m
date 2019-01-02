//
//  GuideView.m
//  Menu
//
//  Created by 姚永敏 on 2018/12/19.
//  Copyright © 2018 YYM. All rights reserved.
//

#import "GuideView.h"
#import <Masonry.h>
@interface GuideView ()

@property(nonatomic,strong)UIImageView *leftImg;
@property(nonatomic,strong)UILabel *titleLab;

@property(nonatomic,strong)UIButton *plateBtn;

@property(nonatomic,strong)UIButton *RealThingBtn;

@property(nonatomic,strong)UIButton *couponBtn;


@end
@implementation GuideView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.leftImg];
        [self addSubview:self.titleLab];
        [self addSubview:self.plateBtn];

        [self addSubview:self.RealThingBtn];

        [self addSubview:self.couponBtn];

    }
    return self;
}

- (void)clickEvent:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(GuideView:didSelectRowAtIndex:)]) {
        
        [self.delegate GuideView:self didSelectRowAtIndex:sender.tag-1000];
    }
}

- (void)layoutSubviews{
    
    [self.leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.mas_left).inset(16);
        make.top.mas_equalTo(self.mas_top).inset(5);
        make.width.mas_equalTo(5);
        make.height.mas_equalTo(30);
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.leftImg.mas_right).inset(5);
        make.centerY.mas_equalTo(self.leftImg.mas_centerY);
    }];
    
    [self.plateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.leftImg.mas_bottom).inset(5);
        make.left.mas_equalTo(self.mas_left).inset(10);
        make.height.mas_equalTo(self.frame.size.height-10-30-3);
        make.width.mas_equalTo((self.frame.size.height-10-30-3));
    }];
    
    [self.RealThingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.plateBtn.mas_top);
        make.left.mas_equalTo(self.plateBtn.mas_right).inset(5);
        make.right.mas_equalTo(self.mas_right).inset(10);
        make.bottom.mas_equalTo(self.plateBtn.mas_centerY).offset(-2.5);
    }];
    
    [self.couponBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.plateBtn.mas_centerY).inset(2.5);
        make.left.mas_equalTo(self.plateBtn.mas_right).inset(5);
        make.right.mas_equalTo(self.mas_right).inset(10);
        make.bottom.mas_equalTo(self.plateBtn.mas_bottom);
    }];
}

- (UIImageView *)leftImg{
    
    if (!_leftImg) {
        
        _leftImg = [[UIImageView alloc] init];
//        _leftImg.image = [UIImage imageNamed:@""];
        _leftImg.backgroundColor = [UIColor redColor];
    }
    return _leftImg;
}

- (UILabel *)titleLab{
    
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.text = @"积分兑好礼";
        _titleLab.font = [UIFont systemFontOfSize:18.f];
    }
    return _titleLab;
}

- (UIButton *)plateBtn{
    if (!_plateBtn) {
        _plateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _plateBtn.tag = 1000;
        [_plateBtn setBackgroundImage:[UIImage imageNamed:@"ic_zhuanpan"] forState:UIControlStateNormal];
        [_plateBtn setContentMode:UIViewContentModeScaleToFill];
        [_plateBtn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _plateBtn;
}

- (UIButton *)RealThingBtn{
    if (!_RealThingBtn) {
        _RealThingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _RealThingBtn.tag = 1001;
        [_RealThingBtn setBackgroundImage:[UIImage imageNamed:@"ic_duishangpin"] forState:UIControlStateNormal];
        [_RealThingBtn setContentMode:UIViewContentModeScaleAspectFit];
        [_RealThingBtn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _RealThingBtn;
}

- (UIButton *)couponBtn{
    if (!_couponBtn) {
        _couponBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _couponBtn.tag = 1002;
        [_couponBtn setBackgroundImage:[UIImage imageNamed:@"ic_duiquan"] forState:UIControlStateNormal];
        [_couponBtn setContentMode:UIViewContentModeScaleToFill];
        [_couponBtn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _couponBtn;
}

@end

//
//  AddAddressView.m
//  ruyiruyiios
//
//  Created by 姚永敏 on 2019/1/4.
//  Copyright © 2019 ruyiruyi. All rights reserved.
//

#import "AddAddressView.h"
@interface AddAddressView ()

@property(nonatomic, strong)UIImageView *imgView;
@property(nonatomic, strong)UILabel *titleLab;
@property(nonatomic, strong)UILabel *subTitleLab;
@end
@implementation AddAddressView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.imgView];
        [self addSubview:self.titleLab];
        [self addSubview:self.subTitleLab];
        [self addSubview:self.rightBtn];
    }
    return self;
}

- (void)layoutSubviews{
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(self.mas_height).multipliedBy(0.5);
        make.left.mas_equalTo(self.mas_left).inset(16);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.imgView.mas_right).inset(10);
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(40);
        make.right.mas_equalTo(self.mas_right).inset(16);
    }];
    
    [self.subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(self.rightBtn.mas_left).inset(5);
        make.left.mas_equalTo(self.imgView.mas_right).inset(10);
    }];
}
- (UIImageView *)imgView{
    
    if (!_imgView) {
        
        _imgView = [[UIImageView alloc] init];
        _imgView.image = [UIImage imageNamed:@"ic_tianjiaAddress"];
    }
    return _imgView;
}

- (UILabel *)titleLab{
    
    if (!_titleLab) {
        
        _titleLab = [[UILabel alloc] init];
        _titleLab.text = @"添加收货地址";
        _titleLab.font = [UIFont systemFontOfSize:18.f];
    }
    return _titleLab;
}

- (UILabel *)subTitleLab{
    
    if (!_subTitleLab) {
        
        _subTitleLab = [[UILabel alloc] init];
        _subTitleLab.text = @"积分兑换的商品将直接邮寄到您的收货地";
        _subTitleLab.font = [UIFont systemFontOfSize:15.f];
        _subTitleLab.numberOfLines = 0;
    }
    return _subTitleLab;
}

- (UIButton *)rightBtn{
    
    if (!_rightBtn) {
        
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setImage:[UIImage imageNamed:@"ic_right"] forState:UIControlStateNormal];
    }
    return _rightBtn;
}

@end

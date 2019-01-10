//
//  AddressView.m
//  ruyiruyiios
//
//  Created by 姚永敏 on 2019/1/4.
//  Copyright © 2019 ruyiruyi. All rights reserved.
//

#import "AddressView.h"
@interface AddressView()

@property(nonatomic, strong)UIImageView *imgView;
@property(nonatomic, strong)UILabel *consigneeLab;


@end
@implementation AddressView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.consigneeLab];
        [self addSubview:self.userNameLab];
        [self addSubview:self.phoneLab];
        [self addSubview:self.imgView];
        [self addSubview:self.addressLab];
        [self addSubview:self.rightBtn];
    }
    return self;
}

- (void)layoutSubviews{
    
    [self.consigneeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.mas_top).inset(15);
        make.left.mas_equalTo(self.mas_left).inset(16);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(50);
    }];
    
    [self.userNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.consigneeLab.mas_right).inset(10);
        make.centerY.mas_equalTo(self.consigneeLab.mas_centerY);
    }];
    
    [self.phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.userNameLab.mas_right).inset(10);
        make.centerY.mas_equalTo(self.consigneeLab.mas_centerY);
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        //父视图高度固定110
        make.left.mas_equalTo(self.mas_left).inset(16);
        make.width.mas_equalTo(50);
        make.top.mas_equalTo(self.consigneeLab.mas_bottom).inset(10);
        make.bottom.mas_equalTo(self.mas_bottom).inset(10);
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(40);
        make.right.mas_equalTo(self.mas_right).inset(16);
    }];
    
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.imgView.mas_right).inset(10);
        make.right.mas_equalTo(self.rightBtn.mas_left).inset(5);
        make.top.mas_equalTo(self.imgView.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom).inset(10);
    }];
}
- (UIImageView *)imgView{
    
    if (!_imgView) {
        
        _imgView = [[UIImageView alloc] init];
        _imgView.backgroundColor = [UIColor lightGrayColor];
    }
    return _imgView;
}
- (UILabel *)consigneeLab{
    
    if (!_consigneeLab) {
        
        _consigneeLab = [[UILabel alloc] init];
        _consigneeLab.backgroundColor = [UIColor colorWithRed:240.f/255.f green:240.f/255.f blue:240.f/255.f alpha:1.f];
        _consigneeLab.text = @"收货人";
        _consigneeLab.textColor = TEXTCOLOR64;
        _consigneeLab.font = [UIFont systemFontOfSize:14.f];
    }
    return _consigneeLab;
}
- (UILabel *)userNameLab{
    
    if (!_userNameLab) {
        
        _userNameLab = [[UILabel alloc] init];
        _userNameLab.font = [UIFont systemFontOfSize:20.f];
        _userNameLab.textAlignment = NSTextAlignmentLeft;
    }
    return _userNameLab;
}

- (UILabel *)phoneLab{
    
    if (!_phoneLab) {
        
        _phoneLab = [[UILabel alloc] init];
        _phoneLab.font = [UIFont systemFontOfSize:15.f];
    }
    return _phoneLab;
}

- (UILabel *)addressLab{
    
    if (!_addressLab) {
        
        _addressLab = [[UILabel alloc] init];
        _addressLab.font = [UIFont systemFontOfSize:15.f];
        _addressLab.numberOfLines = 0;
        _addressLab.textAlignment = NSTextAlignmentLeft;
        _addressLab.textColor = TEXTCOLOR64;

    }
    return _addressLab;
}
- (UIButton *)rightBtn{
    
    if (!_rightBtn) {
        
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setImage:[UIImage imageNamed:@"ic_right"] forState:UIControlStateNormal];
    }
    return _rightBtn;
}


@end

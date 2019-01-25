//
//  BootView.m
//  TestCommodityInfo
//
//  Created by 小马驾驾 on 2018/5/30.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "BootView.h"
#import "YMTools.h"
@interface BootView ()

@property(nonatomic,strong)UIButton *shopCartBtn;

@end

@implementation BootView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.isDisplay = YES;

        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.shopCartBtn];
        [self addSubview:self.numberLab];
        [self addSubview:self.submitBtn];
    }
    return self;
}

- (void)layoutSubviews{
    
    [self.shopCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.mas_equalTo(self.mas_leading).inset(20);
        make.top.mas_equalTo(self.mas_top).offset(-10);
        make.width.height.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    _shopCartBtn.layer.cornerRadius = 25;
    _shopCartBtn.layer.masksToBounds = YES;
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.trailing.mas_equalTo(self.mas_trailing);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.333);
        make.height.mas_equalTo(self.mas_height);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    [self.numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.trailing.mas_equalTo(self.submitBtn.mas_leading).inset(10);
        make.top.mas_equalTo(self.mas_top);
        make.height.mas_equalTo(self.mas_height);
    }];
}

-(void)showShopCartViewEvent{
    
    self.showBlcok(self.isDisplay);

    self.isDisplay = !self.isDisplay;
    
}

-(void)setTotalPrice:(NSString *)totalPrice{
    
    _totalPrice = totalPrice;
    self.numberLab.attributedText = [YMTools priceWithRedString:totalPrice];
    
}

-(UIButton *)shopCartBtn{
    
    if (!_shopCartBtn) {
        
        _shopCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shopCartBtn setImage:[UIImage imageNamed:@"ic_car"] forState:UIControlStateNormal];

        [_shopCartBtn addTarget:self action:@selector(showShopCartViewEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _shopCartBtn;
}

-(UILabel *)numberLab{
    
    if (!_numberLab ) {
        
        _numberLab = [[UILabel alloc] init];
        _numberLab.textAlignment = NSTextAlignmentRight;
        _numberLab.font = [UIFont systemFontOfSize:15.f];
        _numberLab.numberOfLines = 0;
        _numberLab.attributedText = [YMTools priceWithRedString:@"0"];
    }
    return _numberLab;
}

-(UIButton *)submitBtn{
    
    if (!_submitBtn) {
        
        _submitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//        [_submitBtn setFrame:CGRectMake(self.frame.size.width-self.frame.size.width/3, 0, self.frame.size.width/3, self.frame.size.height)];
        [_submitBtn setTitle:@"提交订单" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn setBackgroundColor:[UIColor colorWithRed:255.f/255.f green:102.f/255.f blue:35.f/255.f alpha:1.f]];
    }
    
    
    return _submitBtn;
}
@end

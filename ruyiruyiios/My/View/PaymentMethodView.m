//
//  PaymentMethodView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/22.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "PaymentMethodView.h"
#import "WXApi.h"
@implementation PaymentMethodView

- (UILabel *)methodLabel{
    
    if (_methodLabel == nil) {
        
        _methodLabel = [[UILabel alloc] init];
        _methodLabel.text = @"支付方式";
        _methodLabel.textColor = TEXTCOLOR64;
        _methodLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _methodLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _methodLabel;
}

- (UIButton *)weixinBtn{
    
    if (_weixinBtn == nil) {
        
        _weixinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _weixinBtn.selected = NO;
        [_weixinBtn setImage:[UIImage imageNamed:@"ic_no"] forState:UIControlStateNormal];
        [_weixinBtn setImage:[UIImage imageNamed:@"ic_yes"] forState:UIControlStateSelected];
    }
    return _weixinBtn;
}

- (UIButton *)alipayBtn{
    
    if (_alipayBtn == nil) {
        
        _alipayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _alipayBtn.selected = YES;
        [_alipayBtn setImage:[UIImage imageNamed:@"ic_no"] forState:UIControlStateNormal];
        [_alipayBtn setImage:[UIImage imageNamed:@"ic_yes"] forState:UIControlStateSelected];
    }
    return _alipayBtn;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addUnchangeViews];
        [self addChangeViews];
    }
    return self;
}

- (void)addUnchangeViews{
    
    NSArray *nameArray;
    NSArray *imgArray;
    if (![WXApi isWXAppInstalled]){

        nameArray = @[@"支付宝支付"];
        imgArray = @[@"ic_pay"];
    }else{
        nameArray = @[@"微信支付", @"支付宝支付"];
        imgArray = @[@"ic_wechat", @"ic_pay"];
    }
    for (int i = 0; i<nameArray.count; i++) {
        
        UIImageView *iconImageV = [[UIImageView alloc] initWithFrame:CGRectMake(35, 50+40*i, 33, 33)];
        iconImageV.image = [UIImage imageNamed:imgArray[i]];
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 56+40*i, 80, 20)];
        nameLabel.text = nameArray[i];
        nameLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.textColor = TEXTCOLOR64;
        [self addSubview:iconImageV];
        [self addSubview:nameLabel];
    }
}

- (void)addChangeViews{
    
    [self addSubview:self.methodLabel];
    if ([WXApi isWXAppInstalled]){
        [self addSubview:self.weixinBtn];
    }
    [self addSubview:self.alipayBtn];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.methodLabel.frame = CGRectMake(20, 20, MAINSCREEN.width - 20, 20);
    if ([WXApi isWXAppInstalled]){
        self.weixinBtn.frame = CGRectMake(MAINSCREEN.width - 45, 56, 25, 25);
        self.alipayBtn.frame = CGRectMake(MAINSCREEN.width - 45, 96, 25, 25);
    }else{
        self.alipayBtn.frame = CGRectMake(MAINSCREEN.width - 45, 56, 25, 25);
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

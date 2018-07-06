//
//  CashierPayView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/6.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "CashierPayView.h"

@implementation CashierPayView

- (UILabel *)blanceLabel{
    
    if (_blanceLabel == nil) {
        
        _blanceLabel = [[UILabel alloc] init];
        _blanceLabel.frame = CGRectMake(165, 15, MAINSCREEN.width - 165 - 45, 20);
        _blanceLabel.textColor = TEXTCOLOR64;
//        _blanceLabel.text = @"余额：10000";
        _blanceLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _blanceLabel.textAlignment = NSTextAlignmentRight;
    }
    return _blanceLabel;
}

- (UIButton *)blanceBtn{
    
    if (_blanceBtn == nil) {
        
        _blanceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _blanceBtn.frame = CGRectMake(MAINSCREEN.width - 45, 12, 25, 25);
        _blanceBtn.selected = YES;
        [_blanceBtn setImage:[UIImage imageNamed:@"ic_no"] forState:UIControlStateNormal];
        [_blanceBtn setImage:[UIImage imageNamed:@"ic_yes"] forState:UIControlStateSelected];
    }
    return _blanceBtn;
}

- (UIButton *)wxBtn{
    
    if (_wxBtn == nil) {
        
        _wxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _wxBtn.frame = CGRectMake(MAINSCREEN.width - 45, 102, 25, 25);
        _wxBtn.selected = NO;
        [_wxBtn setImage:[UIImage imageNamed:@"ic_no"] forState:UIControlStateNormal];
        [_wxBtn setImage:[UIImage imageNamed:@"ic_yes"] forState:UIControlStateSelected];
    }
    return _wxBtn;
}

- (UIButton *)alipayBtn{
    
    if (_alipayBtn == nil) {
        
        _alipayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _alipayBtn.frame = CGRectMake(MAINSCREEN.width - 45, 150, 25, 25);
        _alipayBtn.selected = NO;
        [_alipayBtn setImage:[UIImage imageNamed:@"ic_no"] forState:UIControlStateNormal];
        [_alipayBtn setImage:[UIImage imageNamed:@"ic_yes"] forState:UIControlStateSelected];
    }
    return _alipayBtn;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addOtherPayView];
        [self addView];
    }
    return self;
}

- (void)addBlanceView:(NSString *)priceStr{
    
    self.blanceLabel.text = [NSString stringWithFormat:@"%@ 元", priceStr];
    UIView *h_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, 0.5)];
    h_view.backgroundColor = [UIColor lightGrayColor];
    
    UIImageView *groomImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 42, 42)];
    groomImageV.image = [UIImage imageNamed:@"ic_Recommend"];
    
    UIImageView *blanceImageV = [[UIImageView alloc] initWithFrame:CGRectMake(45, 8, 33, 33)];
    blanceImageV.image = [UIImage imageNamed:@"ic_overplus"];
    
    UILabel *blancePayLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 15, 65, 20)];
    blancePayLabel.text = @"余额支付";
    blancePayLabel.textColor = TEXTCOLOR64;
    blancePayLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
    
    UIView *b_view = [[UIView alloc] initWithFrame:CGRectMake(0, 48, MAINSCREEN.width, 0.5)];
    b_view.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:h_view];
    [self addSubview:groomImageV];
    [self addSubview:blanceImageV];
    [self addSubview:blancePayLabel];
    [self addSubview:b_view];
}

- (void)addOtherPayView{
    
    self.otherLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 65, MAINSCREEN.width-20, 20)];
    self.otherLabel.text = @"其他支付方式";
    self.otherLabel.font = [UIFont fontWithName:TEXTFONT size:20.0];
    self.otherLabel.textColor = [UIColor blackColor];
    [self addSubview:self.otherLabel];
    
    NSArray *nameArray = @[@"微信支付", @"支付宝支付"];
    NSArray *imgArray = @[@"ic_wechat", @"ic_pay"];
    for (int i = 0; i<nameArray.count; i++) {
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(45, 95+(15+33)*i, 33, 33)];
        imageV.image = [UIImage imageNamed:imgArray[i]];
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 102+(15+33)*i, 80, 20)];
        nameLabel.text = nameArray[i];
        nameLabel.textColor = TEXTCOLOR64;
        nameLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        [self addSubview:imageV];
        [self addSubview:nameLabel];
    }
}

- (void)addView{
    
    [self addSubview:self.blanceLabel];
    [self addSubview:self.blanceBtn];
    [self addSubview:self.wxBtn];
    [self addSubview:self.alipayBtn];
}

- (void)setdatoViews:(NSString *)orderTypeStr price:(NSString *)priceStr{
    
    if (![orderTypeStr isEqualToString:@"1"]) {
        
        self.otherLabel.hidden = YES;
        self.blanceLabel.hidden = YES;
        self.blanceBtn.hidden = YES;
        self.wxBtn.selected = YES;
    }else{
        
        [self addBlanceView:priceStr];
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

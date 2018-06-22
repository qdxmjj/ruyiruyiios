//
//  MyQuotaHeadView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/22.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "MyQuotaHeadView.h"
#import <UIImageView+WebCache.h>

@implementation MyQuotaHeadView

- (UIImageView *)backImageV{
    
    if (_backImageV == nil) {
        
        _backImageV = [[UIImageView alloc] init];
        _backImageV.image = [UIImage imageNamed:@"ic_ground"];
    }
    return _backImageV;
}

- (UILabel *)creditLabel{
    
    if (_creditLabel == nil) {
        
        _creditLabel = [[UILabel alloc] init];
        _creditLabel.textColor = [UIColor whiteColor];
        _creditLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _creditLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _creditLabel;
}

- (UILabel *)realCreditLabel{
    
    if (_realCreditLabel == nil) {
        
        _realCreditLabel = [[UILabel alloc] init];
        _realCreditLabel.textColor = [UIColor whiteColor];
        _realCreditLabel.font = [UIFont boldSystemFontOfSize:50];
        _realCreditLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _realCreditLabel;
}

- (UILabel *)shouldRepayLabel{
    
    if (_shouldRepayLabel == nil) {
        
        _shouldRepayLabel = [[UILabel alloc] init];
        _shouldRepayLabel.textColor = TEXTCOLOR64;
        _shouldRepayLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _shouldRepayLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _shouldRepayLabel;
}

- (UILabel *)realShouldLabel{
    
    if (_realShouldLabel == nil) {
        
        _realShouldLabel = [[UILabel alloc] init];
        _realShouldLabel.textColor = TEXTCOLOR64;
        _realShouldLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _realShouldLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _realShouldLabel;
}

- (UILabel *)remainPayLabel{
    
    if (_remainPayLabel == nil) {
        
        _remainPayLabel = [[UILabel alloc] init];
        _remainPayLabel.textColor = TEXTCOLOR64;
        _remainPayLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _remainPayLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _remainPayLabel;
}

- (UILabel *)realRemainLabel{
    
    if (_realRemainLabel == nil) {
        
        _realRemainLabel = [[UILabel alloc] init];
        _realRemainLabel.textColor = TEXTCOLOR64;
        _realRemainLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _realRemainLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _realRemainLabel;
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
    
    UIView *midView = [[UIView alloc] initWithFrame:CGRectMake(MAINSCREEN.width/2, 140, 1, 65)];
    midView.backgroundColor = [PublicClass colorWithHexString:@"#ececec"];
    [self addSubview:midView];
    
    UIView *underLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 205, MAINSCREEN.width, 5)];
    underLineView.backgroundColor = [PublicClass colorWithHexString:@"#ececec"];
    [self addSubview:underLineView];
}

- (void)addChangeView{
    
    [self addSubview:self.backImageV];
    [self addSubview:self.creditLabel];
    [self addSubview:self.realCreditLabel];
    [self addSubview:self.shouldRepayLabel];
    [self addSubview:self.realShouldLabel];
    [self addSubview:self.remainPayLabel];
    [self addSubview:self.realRemainLabel];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.backImageV.frame = CGRectMake(0, 0, MAINSCREEN.width, 140);
    self.creditLabel.frame = CGRectMake(0, 30, MAINSCREEN.width, 20);
    self.realCreditLabel.frame = CGRectMake(0, 70, MAINSCREEN.width, 50);
    self.shouldRepayLabel.frame = CGRectMake(0, 150, MAINSCREEN.width/2, 20);
    self.realShouldLabel.frame = CGRectMake(0, 175, MAINSCREEN.width/2, 20);
    self.remainPayLabel.frame = CGRectMake(MAINSCREEN.width/2, 150, MAINSCREEN.width/2, 20);
    self.realRemainLabel.frame = CGRectMake(MAINSCREEN.width/2, 175, MAINSCREEN.width/2, 20);
}

- (void)setDatatoHeadView:(float)creditFloat remainCredit:(float)remainCreditFloat{
    
    float shouldFloat = creditFloat - remainCreditFloat;
    self.creditLabel.text = @"信用额度";
    self.realCreditLabel.text = [NSString stringWithFormat:@"%.2f", creditFloat];
    self.shouldRepayLabel.text = @"应还金额";
    self.remainPayLabel.text = @"剩余信用额度";
    self.realRemainLabel.text = [NSString stringWithFormat:@"%.2f", remainCreditFloat];
    self.realShouldLabel.text = [NSString stringWithFormat:@"%.2f", shouldFloat];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

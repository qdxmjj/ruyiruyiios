//
//  OderBottomView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/5.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "OderBottomView.h"

@implementation OderBottomView

- (UILabel *)tireTotalPriceLabel{
    
    if (_tireTotalPriceLabel == nil) {
        
        _tireTotalPriceLabel = [[UILabel alloc] init];
        _tireTotalPriceLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _tireTotalPriceLabel.textColor = LOGINBACKCOLOR;
        _tireTotalPriceLabel.textAlignment = NSTextAlignmentRight;
    }
    return _tireTotalPriceLabel;
}

- (UILabel *)cxwyTotalPriceLabel{
    
    if (_cxwyTotalPriceLabel == nil) {
        
        _cxwyTotalPriceLabel = [[UILabel alloc] init];
        _cxwyTotalPriceLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _cxwyTotalPriceLabel.textColor = LOGINBACKCOLOR;
        _cxwyTotalPriceLabel.textAlignment = NSTextAlignmentRight;
    }
    return _cxwyTotalPriceLabel;
}

- (UIView *)underView{
    
    if (_underView == nil) {
        
        _underView = [[UIView alloc] init];
        _underView.backgroundColor = [UIColor lightGrayColor];
    }
    return _underView;
}

- (UILabel *)totalPriceLabel{
    
    if (_totalPriceLabel == nil) {
        
        _totalPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 478, MAINSCREEN.width - 120, 20)];
        _totalPriceLabel = [[UILabel alloc] init];
        _totalPriceLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _totalPriceLabel.textColor = LOGINBACKCOLOR;
        _totalPriceLabel.textAlignment = NSTextAlignmentRight;
    }
    return _totalPriceLabel;
}

- (UIButton *)sureBtn{
    
    if (_sureBtn == nil) {
        
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sureBtn setTitle:@"确认购买" forState:UIControlStateNormal];
    }
    return _sureBtn;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        NSArray *nameArray = @[@"轮胎金额", @"畅行无忧"];
        for (int i = 0; i<2; i++) {
            
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(20, 15+35*i, MAINSCREEN.width/2, 20);
            label.font = [UIFont fontWithName:TEXTFONT size:16.0];
            label.textColor = TEXTCOLOR64;
            label.text = [nameArray objectAtIndex:i];
            [self addSubview:label];
        }
        [self addView];
    }
    return self;
}

- (void)addView{
    
    [self addSubview:self.tireTotalPriceLabel];
    [self addSubview:self.cxwyTotalPriceLabel];
    [self addSubview:self.underView];
    [self addSubview:self.totalPriceLabel];
    [self addSubview:self.sureBtn];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.tireTotalPriceLabel.frame = CGRectMake(MAINSCREEN.width/2, 15, MAINSCREEN.width/2 - 20, 20);
    self.cxwyTotalPriceLabel.frame = CGRectMake(MAINSCREEN.width/2, 50, MAINSCREEN.width/2 - 20, 20);
    self.underView.frame = CGRectMake(0, 83, MAINSCREEN.width, 0.5);
    self.totalPriceLabel.frame = CGRectMake(0, 93, MAINSCREEN.width - 120, 20);
    self.sureBtn.frame = CGRectMake(MAINSCREEN.width - 110, 83, 110, 40);
}

- (void)setBottomViewData:(NSString *)tireTotalPriceStr cxwyTotalPrice:(NSString *)cxwyTotalPriceStr{
    
    self.tireTotalPriceLabel.text = [NSString stringWithFormat:@"¥ %@", tireTotalPriceStr];
    self.cxwyTotalPriceLabel.text = [NSString stringWithFormat:@"¥ %@", cxwyTotalPriceStr];
    self.totalPriceLabel.text = [NSString stringWithFormat:@"¥ %.2f", ([tireTotalPriceStr floatValue] + [cxwyTotalPriceStr floatValue])];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

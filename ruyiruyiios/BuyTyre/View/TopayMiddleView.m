//
//  TopayMiddleView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/6.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "TopayMiddleView.h"

@implementation TopayMiddleView

- (UILabel *)nameLabel{
    
    if (_nameLabel == nil) {
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentRight;
        _nameLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _nameLabel.textColor = [UIColor lightGrayColor];
    }
    return _nameLabel;
}

- (UILabel *)telephoneLabel{
    
    if (_telephoneLabel == nil) {
        
        _telephoneLabel = [[UILabel alloc] init];
        _telephoneLabel.textAlignment = NSTextAlignmentRight;
        _telephoneLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _telephoneLabel.textColor = [UIColor lightGrayColor];
    }
    return _telephoneLabel;
}

- (UILabel *)platLabel{
    
    if (_platLabel == nil) {
        
        _platLabel = [[UILabel alloc] init];
        _platLabel.textAlignment = NSTextAlignmentRight;
        _platLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _platLabel.textColor = [UIColor lightGrayColor];
    }
    return _platLabel;
}

- (UILabel *)totalPriceLabel{
    
    if (_totalPriceLabel == nil) {
        
        _totalPriceLabel = [[UILabel alloc] init];
        _totalPriceLabel.textAlignment = NSTextAlignmentRight;
        _totalPriceLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _totalPriceLabel.textColor = [UIColor lightGrayColor];
    }
    return _totalPriceLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        NSArray *nameArray = @[@"联系人", @"联系电话", @"车牌号", @"订单总价"];
        for (int i = 0; i<nameArray.count; i++) {
            
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(20, 15+35*i, MAINSCREEN.width/2 - 20, 20);
            label.text = nameArray[i];
            label.textColor = TEXTCOLOR64;
            label.font = [UIFont fontWithName:TEXTFONT size:14.0];
            [self addSubview:label];
        }
        UIView *underView = [[UIView alloc] initWithFrame:CGRectMake(0, 148, MAINSCREEN.width, 0.5)];
        underView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:underView];
        [self addView];
    }
    return self;
}

- (void)addView{
    
    [self addSubview:self.nameLabel];
    [self addSubview:self.telephoneLabel];
    [self addSubview:self.platLabel];
    [self addSubview:self.totalPriceLabel];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.nameLabel.frame = CGRectMake(MAINSCREEN.width/2, 15, MAINSCREEN.width/2 - 20, 20);
    self.telephoneLabel.frame = CGRectMake(MAINSCREEN.width/2, 50, MAINSCREEN.width/2 - 20, 20);
    self.platLabel.frame = CGRectMake(MAINSCREEN.width/2, 85, MAINSCREEN.width/2 - 20, 20);
    self.totalPriceLabel.frame = CGRectMake(MAINSCREEN.width/2, 120, MAINSCREEN.width/2 - 20, 20);
}

- (void)setPayMiddleViewData:(ShoeOrderInfo *)shoeOrderInfo{
    
    self.nameLabel.text = shoeOrderInfo.name;
    self.telephoneLabel.text = shoeOrderInfo.phone;
    self.totalPriceLabel.text = [NSString stringWithFormat:@"¥ %@", shoeOrderInfo.totalPrice];
    self.platLabel.text = shoeOrderInfo.platNumber;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

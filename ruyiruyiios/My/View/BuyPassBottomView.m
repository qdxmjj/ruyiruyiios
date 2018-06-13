//
//  BuyPassBottomView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/12.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "BuyPassBottomView.h"

@implementation BuyPassBottomView

- (UIButton *)selectBtn{
    
    if (_selectBtn == nil) {
        
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setImage:[UIImage imageNamed:@"ic_no"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"ic_yes"] forState:UIControlStateSelected];
        [_selectBtn addTarget:self action:@selector(chickSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}

- (void)chickSelectBtn:(UIButton *)button{
    
    button.selected = !button.selected;
}

- (JJUILabel *)agreementLabel{
    
    if (_agreementLabel == nil) {
        
        _agreementLabel = [[JJUILabel alloc] init];
        NSString *agreeStr = @"选择即代表您已同意《如驿如意畅行无忧使用协议》";
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:agreeStr];
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(agreeStr.length-14, 14)];
        [attrStr addAttribute:NSForegroundColorAttributeName value:TEXTCOLOR64 range:NSMakeRange(0, agreeStr.length - 14)];
        _agreementLabel.attributedText = attrStr;
        _agreementLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _agreementLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _agreementLabel.numberOfLines = 0;
        [_agreementLabel setVerticalAlignment:VerticalAlignmentTop];
//        [_agreementLabel yb_addAttributeTapActionWithStrings:@[@"《如驿如意畅行无忧使用协议》"] delegate:self];
    }
    return _agreementLabel;
}

- (UIButton *)sureBuyBtn{
    
    if (_sureBuyBtn == nil) {
        
        _sureBuyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBuyBtn.layer.cornerRadius = 6.0;
        _sureBuyBtn.layer.masksToBounds = YES;
        [_sureBuyBtn setTitle:@"确认购买" forState:UIControlStateNormal];
        [_sureBuyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _sureBuyBtn;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.selectBtn];
        [self addSubview:self.agreementLabel];
        [self addSubview:self.sureBuyBtn];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.selectBtn.frame = CGRectMake(15, 5, 25, 25);
    self.agreementLabel.frame = CGRectMake(45, 7, MAINSCREEN.width - 45, 40);
    self.sureBuyBtn.frame = CGRectMake(10, 50, MAINSCREEN.width - 20, 34);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

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

-(UITextView *)agreementTextView{
    
    if (!_agreementTextView) {
        
        _agreementTextView = [[UITextView alloc] init];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:@"选择即代表您已同意《如驿如意畅行无忧使用协议》"];
        
        [attStr addAttribute:NSLinkAttributeName
                       value:@"xmjjProtocol://"
                       range:[[attStr string] rangeOfString:@"《如驿如意畅行无忧使用协议》"]];
        _agreementTextView.attributedText = attStr;
        _agreementTextView.delegate = self;
        _agreementTextView.editable = NO;
        _agreementTextView.font = [UIFont systemFontOfSize:14.f];
    }
    
    
    return _agreementTextView;
}

- (UILabel *)passPriceLabel{
    
    if (_passPriceLabel == nil) {
        
        _passPriceLabel = [[UILabel alloc] init];
        _passPriceLabel.textAlignment = NSTextAlignmentRight;
        _passPriceLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _passPriceLabel.textColor = LOGINBACKCOLOR;
    }
    return _passPriceLabel;
}

- (UIButton *)sureBuyBtn{
    
    if (_sureBuyBtn == nil) {
        
        _sureBuyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBuyBtn setTitle:@"确认购买" forState:UIControlStateNormal];
        [_sureBuyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _sureBuyBtn;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.selectBtn];
        [self addSubview:self.agreementTextView];
        [self addSubview:self.passPriceLabel];
        [self addSubview:self.sureBuyBtn];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.selectBtn.frame = CGRectMake(15, 5, 25, 25);
    self.agreementTextView.frame = CGRectMake(45, 0, MAINSCREEN.width - 45, 25);
    self.passPriceLabel.frame = CGRectMake(0, 62, MAINSCREEN.width - 120, 20);
    self.sureBuyBtn.frame = CGRectMake(MAINSCREEN.width - 100, 50, 100, 44);
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange{
    
    if ([[URL scheme] isEqualToString:@"xmjjProtocol"]) {
        
        if (self.eventBlock) {
            self.eventBlock(YES);
        }
        return NO;
    }
    return YES;
}

- (void)setdatatoViews:(NSString *)priceStr{
    
    self.passPriceLabel.text = [NSString stringWithFormat:@"合计: %ld 元", [priceStr integerValue]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

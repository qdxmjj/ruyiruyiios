//
//  MyQuotaMiddleView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/22.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "MyQuotaMiddleView.h"

@implementation MyQuotaMiddleView

- (UILabel *)repayLabel{
    
    if (_repayLabel == nil) {
        
        _repayLabel = [[UILabel alloc] init];
        _repayLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _repayLabel.textColor = TEXTCOLOR64;
        _repayLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _repayLabel;
}

- (UITextField *)realRepayTF{
    
    if (_realRepayTF == nil) {
        
        _realRepayTF = [[UITextField alloc] init];
        _realRepayTF.userInteractionEnabled = NO;
        _realRepayTF.font = [UIFont fontWithName:TEXTFONT size:30];
        _realRepayTF.delegate = self;
        _realRepayTF.textColor = [UIColor blackColor];
        _realRepayTF.textAlignment = NSTextAlignmentLeft;
    }
    return _realRepayTF;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (UIButton *)removeTFBtn{
    
    if (_removeTFBtn == nil) {
        
        _removeTFBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_removeTFBtn addTarget:self action:@selector(chickRemoveTFBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _removeTFBtn;
}

- (void)chickRemoveTFBtn:(UIButton *)button{
    
    self.realRepayTF.userInteractionEnabled = YES;
    self.realRepayTF.text = @"0.00";
    [self.realRepayTF becomeFirstResponder];
}

- (UIButton *)updateMoneyNumberBtn{
    
    if (_updateMoneyNumberBtn == nil) {
        
        _updateMoneyNumberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _updateMoneyNumberBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        [_updateMoneyNumberBtn setTitleColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [_updateMoneyNumberBtn addTarget:self action:@selector(chickUpdateBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _updateMoneyNumberBtn;
}

- (void)chickUpdateBtn:(UIButton *)button{
    
    self.realRepayTF.userInteractionEnabled = YES;
    [self.realRepayTF becomeFirstResponder];
}

- (UILabel *)mostRepayLabel{
    
    if (_mostRepayLabel == nil) {
        
        _mostRepayLabel = [[UILabel alloc] init];
        _mostRepayLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _mostRepayLabel.textAlignment = NSTextAlignmentLeft;
        _mostRepayLabel.textColor = TEXTCOLOR64;
    }
    return _mostRepayLabel;
}

- (UIView *)underLineView{
    
    if (_underLineView == nil) {
        
        _underLineView = [[UIView alloc] init];
    }
    return _underLineView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addViews];
    }
    return self;
}

- (void)addViews{
    
    [self addSubview:self.repayLabel];
    [self addSubview:self.realRepayTF];
    [self addSubview:self.removeTFBtn];
    [self addSubview:self.updateMoneyNumberBtn];
    [self addSubview:self.mostRepayLabel];
    [self addSubview:self.underLineView];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.repayLabel.frame = CGRectMake(15, 15, MAINSCREEN.width - 15, 20);
    self.realRepayTF.frame = CGRectMake(15, 45, MAINSCREEN.width - 140, 30);
    self.removeTFBtn.frame = CGRectMake(MAINSCREEN.width - 125, 53, 14, 14);
    self.updateMoneyNumberBtn.frame = CGRectMake(MAINSCREEN.width - 90, 51, 70, 20);
    self.mostRepayLabel.frame = CGRectMake(15, 85, MAINSCREEN.width - 15, 20);
    self.underLineView.frame = CGRectMake(0, 115, MAINSCREEN.width, 5);
}

- (void)setDatatoHeadView:(float)creditFloat remainCredit:(float)remainCreditFloat{
    
    float realRepayFoat = creditFloat - remainCreditFloat;
    self.repayLabel.text = @"还款";
    self.realRepayTF.text = [NSString stringWithFormat:@"%.2f", realRepayFoat];
    [self.removeTFBtn setImage:[UIImage imageNamed:@"删除照片"] forState:UIControlStateNormal];
    [self.updateMoneyNumberBtn setTitle:@"修改金额" forState:UIControlStateNormal];
    self.mostRepayLabel.text = [NSString stringWithFormat:@"最多还款 %.2f 元", realRepayFoat];
    self.underLineView.backgroundColor = [PublicClass colorWithHexString:@"#eeeeee"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  TopayBottomView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/6.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "TopayBottomView.h"
#import <UIImageView+WebCache.h>

@implementation TopayBottomView

- (UIImageView *)downImageV{
    
    if (_downImageV == nil) {
        
        _downImageV = [[UIImageView alloc] init];
    }
    return _downImageV;
}

- (JJUILabel *)detailLabel{
    
    if (_detailLabel == nil) {
        
        _detailLabel = [[JJUILabel alloc] init];
        _detailLabel.font = [UIFont fontWithName:TEXTFONT size:18.0];
        _detailLabel.textColor = [UIColor blackColor];
        [_detailLabel setVerticalAlignment:VerticalAlignmentTop];
        [_detailLabel setNumberOfLines:0];
        _detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _detailLabel;
}

- (UILabel *)tirePositionLabel{
    
    if (_tirePositionLabel == nil) {
        
        _tirePositionLabel = [[UILabel alloc] init];
        _tirePositionLabel.textColor = TEXTCOLOR64;
        _tirePositionLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _tirePositionLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _tirePositionLabel;
}

- (UILabel *)piceLabel{
    
    if (_piceLabel == nil) {
        
        _piceLabel = [[UILabel alloc] init];
        _piceLabel.textColor = LOGINBACKCOLOR;
        _piceLabel.font = [UIFont fontWithName:TEXTFONT size:22.0];
    }
    return _piceLabel;
}

- (UILabel *)countLabel{
    
    if (_countLabel == nil) {
        
        _countLabel = [[UILabel alloc] init];
        _countLabel.textColor = [UIColor blackColor];
        _countLabel.font = [UIFont fontWithName:TEXTFONT size:18.0];
        _countLabel.textAlignment = NSTextAlignmentRight;
    }
    return _countLabel;
}

- (UIView *)b_lineView{
    
    if (_b_lineView == nil) {
        
        _b_lineView = [[UIView alloc] init];
        _b_lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _b_lineView;
}

- (UIButton *)cxwyBtn{
    
    if (_cxwyBtn == nil) {
        
        _cxwyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cxwyBtn setTitleColor:TEXTCOLOR64 forState:UIControlStateNormal];
        [_cxwyBtn setImage:[UIImage imageNamed:@"ic_plus"] forState:UIControlStateNormal];
        [_cxwyBtn setImage:[UIImage imageNamed:@"ic_plus"] forState:UIControlStateHighlighted];
        _cxwyBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _cxwyBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_cxwyBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    }
    return _cxwyBtn;
}

- (UILabel *)cxwyCountLabel{
    
    if (_cxwyCountLabel == nil) {
        
        _cxwyCountLabel = [[UILabel alloc] init];
        _cxwyCountLabel.textColor = [UIColor blackColor];
        _cxwyCountLabel.font = [UIFont fontWithName:TEXTFONT size:18.0];
        _cxwyCountLabel.textAlignment = NSTextAlignmentRight;
    }
    return _cxwyCountLabel;
}

- (UIView *)cb_underView{
    
    if (_cb_underView == nil) {
        
        _cb_underView = [[UIView alloc] init];
        _cb_underView.backgroundColor = [UIColor lightGrayColor];
    }
    return _cb_underView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addView];
    }
    return self;
}

- (void)addView{
    
    [self addSubview:self.downImageV];
    [self addSubview:self.detailLabel];
    [self addSubview:self.tirePositionLabel];
    [self addSubview:self.piceLabel];
    [self addSubview:self.countLabel];
    [self addSubview:self.b_lineView];
    [self addSubview:self.cxwyBtn];
    [self addSubview:self.cxwyCountLabel];
    [self addSubview:self.cb_underView];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.downImageV.frame = CGRectMake(20, 10, 100, 120);
    self.detailLabel.frame = CGRectMake(130, 10, MAINSCREEN.width - 150, 80);
    self.tirePositionLabel.frame = CGRectMake(130, 90, MAINSCREEN.width - 190, 17);
    self.piceLabel.frame = CGRectMake(130, 108, MAINSCREEN.width - 190, 22);
    self.countLabel.frame = CGRectMake(MAINSCREEN.width - 60, 90, 40, 20);
    self.b_lineView.frame = CGRectMake(0, 140, MAINSCREEN.width, 0.5);
    self.cxwyBtn.frame = CGRectMake(20, 155, MAINSCREEN.width - 80, 20);
    self.cxwyCountLabel.frame = CGRectMake(MAINSCREEN.width - 60, 155, 40, 20);
    self.cb_underView.frame = CGRectMake(0, 193, MAINSCREEN.width, 0.5);
}

- (void)setTopayBottomViewData:(ShoeOrderVo *)shoeOrdervo tobePayinfo:(TobepayInfo *)tobePayinfo;{
    
    if ([shoeOrdervo.fontRearFlag isEqualToString:@"0"] || [shoeOrdervo.fontRearFlag isEqualToString:@"1"]) {
        
        [self.downImageV sd_setImageWithURL:[NSURL URLWithString:tobePayinfo.orderImg]];
        self.detailLabel.text = shoeOrdervo.fontShoeName;
        self.piceLabel.text = [NSString stringWithFormat:@"¥ %@", shoeOrdervo.fontPrice];
        self.countLabel.text = [NSString stringWithFormat:@"x%@", shoeOrdervo.fontAmount];
        [self.cxwyBtn setTitle:[NSString stringWithFormat:@"畅行无忧 ¥ %@", shoeOrdervo.cxwyPrice] forState:UIControlStateNormal];
        self.cxwyCountLabel.text = [NSString stringWithFormat:@"x%@", shoeOrdervo.cxwyAmount];
        if ([shoeOrdervo.fontRearFlag isEqualToString:@"0"]) {
            
            self.tirePositionLabel.text = [NSString stringWithFormat:@"位置: 前轮/后轮"];
        }else{
            
            self.tirePositionLabel.text = [NSString stringWithFormat:@"位置: 前轮"];
        }
    }else{
        
        [self.downImageV sd_setImageWithURL:[NSURL URLWithString:tobePayinfo.orderImg]];
        self.detailLabel.text = shoeOrdervo.rearShoeName;
        self.piceLabel.text = [NSString stringWithFormat:@"¥ %@", shoeOrdervo.rearPrice];
        self.countLabel.text = [NSString stringWithFormat:@"x%@", shoeOrdervo.rearAmount];
        [self.cxwyBtn setTitle:[NSString stringWithFormat:@"畅行无忧 ¥ %@", shoeOrdervo.cxwyPrice] forState:UIControlStateNormal];
        self.cxwyCountLabel.text = [NSString stringWithFormat:@"x%@", shoeOrdervo.cxwyAmount];
        self.tirePositionLabel.text = [NSString stringWithFormat:@"位置: 后轮"];
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

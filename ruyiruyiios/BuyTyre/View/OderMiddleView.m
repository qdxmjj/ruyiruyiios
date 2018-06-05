//
//  OderMiddleView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/5.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "OderMiddleView.h"
#import <UIImageView+WebCache.h>

@implementation OderMiddleView

- (UIView *)h_lineView{
    
    if (_h_lineView == nil) {
        
        _h_lineView = [[UIView alloc] init];
        _h_lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _h_lineView;
}

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
        [_cxwyBtn setTitle:@"畅行无忧" forState:UIControlStateNormal];
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

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addView];
    }
    return self;
}

- (void)addView{
    
    [self addSubview:self.h_lineView];
    [self addSubview:self.downImageV];
    [self addSubview:self.detailLabel];
    [self addSubview:self.piceLabel];
    [self addSubview:self.countLabel];
    [self addSubview:self.b_lineView];
    [self addSubview:self.cxwyBtn];
    [self addSubview:self.cxwyCountLabel];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.h_lineView.frame = CGRectMake(0, 0, MAINSCREEN.width, 0.5);
    self.downImageV.frame = CGRectMake(20, 10, 100, 120);
    self.detailLabel.frame = CGRectMake(130, 10, MAINSCREEN.width - 150, 90);
    self.piceLabel.frame = CGRectMake(130, 90, MAINSCREEN.width - 190, 22);
    self.countLabel.frame = CGRectMake(MAINSCREEN.width - 60, 90, 40, 20);
    self.b_lineView.frame = CGRectMake(0, 140, MAINSCREEN.width, 0.5);
    self.cxwyBtn.frame = CGRectMake(20, 155, MAINSCREEN.width - 80, 20);
    self.cxwyCountLabel.frame = CGRectMake(MAINSCREEN.width - 60, 155, 40, 20);
}

- (void)setMiddleViewData:(BuyTireData *)buyTireData cxwyCount:(NSString *)cxwyCount priceCount:(NSString *)priceCount price:(NSString *)priceStr{
    
    [self.downImageV sd_setImageWithURL:[NSURL URLWithString:buyTireData.shoeDownImg]];
    self.detailLabel.text = buyTireData.detailStr;
    self.piceLabel.text = [NSString stringWithFormat:@"¥ %@", priceStr];
    self.countLabel.text = [NSString stringWithFormat:@"x%@", priceCount];
    self.cxwyCountLabel.text = [NSString stringWithFormat:@"x%@", cxwyCount];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

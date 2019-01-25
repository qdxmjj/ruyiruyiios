//
//  CouponRightView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/20.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "CouponRightView.h"

@implementation CouponRightView

- (UILabel *)titleLabel{
    
    if (_titleLabel == nil) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont fontWithName:TEXTFONT size:15.0];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UILabel *)limitLabel{
    
    if (_limitLabel == nil) {
        
        _limitLabel = [[UILabel alloc] init];
        _limitLabel.font = [UIFont fontWithName:TEXTFONT size:12.0];
        _limitLabel.textColor = TEXTCOLOR64;
        _limitLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _limitLabel;
}

- (UILabel *)startLabel{
    
    if (_startLabel == nil) {
        
        _startLabel = [[UILabel alloc] init];
        _startLabel.font = [UIFont fontWithName:TEXTFONT size:10.0];
        _startLabel.textColor = [UIColor lightGrayColor];
        _startLabel.numberOfLines = 0;
        _startLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _startLabel;
}

- (UILabel *)fullReductionLab{
    
    if (_fullReductionLab == nil) {
        
        _fullReductionLab = [[UILabel alloc] init];
        _fullReductionLab.font = [UIFont fontWithName:TEXTFONT size:10.0];
        _fullReductionLab.textColor = [UIColor lightGrayColor];
        _fullReductionLab.numberOfLines = 0;
        _fullReductionLab.textAlignment = NSTextAlignmentLeft;
    }
    return _fullReductionLab;
}

- (UILabel *)endLabel{
    
    if (_endLabel == nil) {
        
        _endLabel = [[UILabel alloc] init];
        _endLabel.font = [UIFont fontWithName:TEXTFONT size:10.0];
        _endLabel.textColor = [UIColor lightGrayColor];
        _endLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _endLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.limitLabel];
        [self addSubview:self.startLabel];
        [self addSubview:self.fullReductionLab];
        [self addSubview:self.endLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.mas_top).inset(10);
        make.leading.mas_equalTo(self.mas_leading).inset(10);
        make.trailing.mas_equalTo(self.mas_trailing).inset(10);
        make.height.mas_equalTo(@20);
    }];
    
    [self.limitLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.titleLabel.mas_bottom).inset(3);
        make.leading.mas_equalTo(self.mas_leading).inset(10);
        make.trailing.mas_equalTo(self.mas_trailing).inset(10);
    }];
    
    [self.startLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.limitLabel.mas_bottom).inset(3);
        make.leading.mas_equalTo(self.mas_leading).inset(10);
        make.trailing.mas_equalTo(self.mas_trailing).inset(10);
    }];
    
    [self.fullReductionLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.startLabel.mas_bottom);
        make.leading.mas_equalTo(self.mas_leading).inset(10);
        make.trailing.mas_equalTo(self.mas_trailing).inset(10);
    }];
    
    [self.endLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.mas_bottom).inset(10);
        make.leading.mas_equalTo(self.mas_leading).inset(10);
        make.trailing.mas_equalTo(self.mas_trailing).inset(10);
    }];
}

- (void)setdatatoViews:(CouponInfo *)counponInfo{
    
    self.titleLabel.text = counponInfo.couponName;
    
    if ([counponInfo.type intValue] == 1 || [counponInfo.type intValue] ==3 || [counponInfo.type intValue] == 4 || [counponInfo.type intValue] == 5) {
        
        self.limitLabel.text = [NSString stringWithFormat:@"仅限%@车辆使用", counponInfo.platNumber];
        
        if ([counponInfo.type integerValue] == 3) {
            
            self.fullReductionLab.text = [NSString stringWithFormat:@"满%@减%@",counponInfo.moneyFull,counponInfo.moneyMinus];
        }else{
         
            self.fullReductionLab.text = @"";
        }
    }else{
     
        self.limitLabel.text = @"";
    }
    if (!counponInfo.storesName || [counponInfo.storesName isEqual:[NSNull null]] || counponInfo.storesName == nil) {
        
    }else{
        self.startLabel.text = [NSString stringWithFormat:@"仅限%@门店使用",[counponInfo.storesName componentsJoinedByString:@","]];
    }
    
    self.endLabel.text = [NSString stringWithFormat:@"使用时间：%@~%@", counponInfo.startTime,counponInfo.endTime];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

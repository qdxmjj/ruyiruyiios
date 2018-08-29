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
        [self addSubview:self.endLabel];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(20, 10, self.frame.size.width - 20, 20);
    self.limitLabel.frame = CGRectMake(20, 35, self.titleLabel.frame.size.width, 20);
    self.startLabel.frame = CGRectMake(20, 65, self.titleLabel.frame.size.width, 30);
    self.endLabel.frame = CGRectMake(20, 90, self.titleLabel.frame.size.width, 20);
}

- (void)setdatatoViews:(CouponInfo *)counponInfo{
    
    self.titleLabel.text = counponInfo.couponName;
    if ([counponInfo.type intValue] == 1) {
        self.limitLabel.text = [NSString stringWithFormat:@"仅限%@车辆使用", counponInfo.platNumber];
    }
    if (!counponInfo.storesName || [counponInfo.storesName isEqual:[NSNull null]] || counponInfo.storesName == nil) {
        
    }else{
        self.startLabel.text = [NSString stringWithFormat:@"仅限%@门店使用",[counponInfo.storesName componentsJoinedByString:@","]];
    }
    self.endLabel.text = [NSString stringWithFormat:@"结束时间：%@~%@", counponInfo.startTime,counponInfo.endTime];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

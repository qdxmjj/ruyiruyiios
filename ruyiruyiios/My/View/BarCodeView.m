//
//  BarCodeView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/7/1.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "BarCodeView.h"

@implementation BarCodeView

- (UILabel *)titleLabel{
    
    if (_titleLabel == nil) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"轮胎条码";
        _titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _titleLabel.textColor = TEXTCOLOR64;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (NSArray *)countArray{
    
    if (_countArray == nil) {
        
        _countArray = [[NSArray alloc] init];
    }
    return _countArray;
}

- (instancetype)initWithFrame:(CGRect)frame number:(NSArray *)numberArray{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.titleLabel];
        [self addUnchangeViews:numberArray];
    }
    return self;
}

- (void)addUnchangeViews:(NSArray *)numberArray{

    for (int i = 0; i<numberArray.count; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 40+30*i, MAINSCREEN.width - 40, 20)];
        label.text = numberArray[i];
        label.textColor = TEXTCOLOR64;
        label.font = [UIFont fontWithName:TEXTFONT size:14.0];
        label.textAlignment = NSTextAlignmentLeft;
        [self addSubview:label];
    }
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(20, 10, MAINSCREEN.width - 20, 20);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

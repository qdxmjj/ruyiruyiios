//
//  MyBottomCollectionViewCell.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/7.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "MyBottomCollectionViewCell.h"

@implementation MyBottomCollectionViewCell

- (UIImageView *)iconImageView{
    
    if (_iconImageView == nil) {
        
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel{
    
    if (_titleLabel == nil) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _titleLabel.textColor = TEXTCOLOR64;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.iconImageView];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.iconImageView.frame = CGRectMake((self.frame.size.width - 56)/2, 4, 56, 56);
    self.titleLabel.frame = CGRectMake(0, 60, (MAINSCREEN.width - 40)/3, 20);
}

@end

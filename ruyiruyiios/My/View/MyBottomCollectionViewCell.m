//
//  MyBottomCollectionViewCell.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/7.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "MyBottomCollectionViewCell.h"
#import <Masonry.h>
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
//        _titleLabel.textAlignment = NSTextAlignmentCenter;
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
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.mas_top);
        make.width.height.mas_equalTo(self.mas_height).multipliedBy(0.7);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.iconImageView.mas_bottom);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
//    self.iconImageView.frame = CGRectMake((self.frame.size.width - 56)/2, 4, 56, 56);
//    self.titleLabel.frame = CGRectMake(0, 60, (MAINSCREEN.width - 40)/3, 20);
}

@end

//
//  HomeFirstView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/15.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "HomeFirstView.h"
#import <Masonry.h>
@interface HomeFirstView()

@end

@implementation HomeFirstView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *iconImageV = [[UIImageView alloc] init];

        self.iconImageV = iconImageV;
        [self addSubview:iconImageV];
        
        UILabel *top = [[UILabel alloc] init];

        top.textColor = [UIColor blackColor];
        top.textAlignment = NSTextAlignmentLeft;
        top.font = [UIFont fontWithName:TEXTFONT size:15.f];
        self.topLabel = top;
        [self addSubview:top];
        
        UILabel *bottom = [[UILabel alloc] init];

        bottom.textColor = [UIColor lightGrayColor];
        bottom.textAlignment = NSTextAlignmentLeft;
        bottom.font = [UIFont fontWithName:TEXTFONT size:14.f];
        [self addSubview:bottom];
        self.bottomLabel = bottom;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    [self.iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.mas_left).inset(16);
        make.width.height.mas_equalTo(self.mas_height).multipliedBy(0.65);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.iconImageV.mas_top);
        make.left.mas_equalTo(self.iconImageV.mas_right).inset(5);
        make.right.mas_equalTo(self.mas_right).inset(16);
        make.height.mas_equalTo(self.iconImageV.mas_height).multipliedBy(0.5);
    }];
    
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.topLabel.mas_bottom);
        make.left.mas_equalTo(self.topLabel.mas_left);
        make.right.mas_equalTo(self.topLabel.mas_right);
        make.bottom.mas_equalTo(self.iconImageV.mas_bottom);
    }];
}
@end

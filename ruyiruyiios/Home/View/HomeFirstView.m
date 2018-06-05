//
//  HomeFirstView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/15.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "HomeFirstView.h"

@interface HomeFirstView()

@end

@implementation HomeFirstView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *iconImageV = [[UIImageView alloc] init];
//        iconImageV.image = [UIImage imageNamed:@"注册"];
        self.iconImageV = iconImageV;
        [self addSubview:iconImageV];
        
        UILabel *top = [[UILabel alloc] init];
//        top.text = @"新人注册享好礼";
        top.textColor = [UIColor blackColor];
        top.textAlignment = NSTextAlignmentLeft;
        top.font = [UIFont fontWithName:TEXTFONT size:16.0];
        self.topLabel = top;
        [self addSubview:top];
        
        UILabel *bottom = [[UILabel alloc] init];
//        bottom.text = @"注册享受价值xx元礼包";
        bottom.textColor = [UIColor lightGrayColor];
        bottom.textAlignment = NSTextAlignmentLeft;
        bottom.font = [UIFont fontWithName:TEXTFONT size:14.0];
        [self addSubview:bottom];
        self.bottomLabel = bottom;
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    CGFloat iconImageVX = 20.0;
    CGFloat iconImageVY = 10.0;
    CGFloat iconImageVW = 40.0;
    CGFloat iconImageVH = 40.0;
    self.iconImageV.frame = CGRectMake(iconImageVX, iconImageVY, iconImageVW, iconImageVH);
    
    CGFloat topX = iconImageVX + iconImageVW + 10;
    CGFloat topY = 12.0;
    CGFloat topW = MAINSCREEN.width - topX;
    CGFloat topH = 20.0;
    self.topLabel.frame = CGRectMake(topX, topY, topW, topH);
    
    CGFloat bottomX = iconImageVX + iconImageVW + 10;
    CGFloat bottomY = topY + topH;
    CGFloat bottomW = MAINSCREEN.width - topX;
    CGFloat bottomH = 16.0;
    self.bottomLabel.frame = CGRectMake(bottomX, bottomY, bottomW, bottomH);
}

//设置模型数据
//- (void)setModel{
//
//
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

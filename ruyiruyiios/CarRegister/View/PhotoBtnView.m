//
//  PhotoBtnView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/19.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "PhotoBtnView.h"

@implementation PhotoBtnView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *iconImageV = [[UIImageView alloc] init];
//        iconImageV.image = [UIImage imageNamed:@"添加照片"];
        self.iconImageV = iconImageV;
        [self addSubview:iconImageV];
        
        UILabel *bottom = [[UILabel alloc] init];
        bottom.textColor = [UIColor lightGrayColor];
        bottom.textAlignment = NSTextAlignmentCenter;
        bottom.font = [UIFont fontWithName:TEXTFONT size:14.0];
        self.bottomLabel = bottom;
        [self addSubview:bottom];
    }
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    CGFloat iconImageVY = 10.0;
    CGFloat iconImageVW = 30.0;
    CGFloat iconImageVH = 30.0;
    CGFloat iconImageVX = (MAINSCREEN.width/2 - 40)/2 - iconImageVW/2;
    self.iconImageV.frame = CGRectMake(iconImageVX, iconImageVY, iconImageVW, iconImageVH);

    CGFloat nameX = 0;
    CGFloat nameY = 45.0;
    CGFloat nameW = MAINSCREEN.width/2 - 40;
    CGFloat nameH = 20.0;
    self.bottomLabel.frame = CGRectMake(nameX, nameY, nameW, nameH);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

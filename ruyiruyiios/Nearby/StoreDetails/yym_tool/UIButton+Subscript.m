//
//  UIButton+Subscript.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/12.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "UIButton+Subscript.h"
#import <objc/runtime.h>

static NSString *badgeLabelKey = @"badgeLabelKey";


@implementation UIButton (Subscript)

/**
 设置角标的个数（右上角）
 
 @param badgeValue <#badgeValue description#>
 */
- (void)setBadgeValue:(NSInteger)badgeValue{
    
    CGFloat badgeW   = 15;
    
    self.badgeLable = [[UILabel alloc]init];
    self.badgeLable.text = [NSString stringWithFormat:@"%ld",badgeValue];
    self.badgeLable.textAlignment = NSTextAlignmentCenter;
    self.badgeLable.textColor = [UIColor whiteColor];
    self.badgeLable.font = [UIFont systemFontOfSize:12];
    self.badgeLable.layer.cornerRadius = badgeW*0.5;
    self.badgeLable.clipsToBounds = YES;
    self.badgeLable.backgroundColor = [UIColor redColor];
    self.badgeLable.hidden = YES;

    CGFloat badgeX = MAINSCREEN.width/4-15;

    self.badgeLable.frame = CGRectMake(badgeX, 0, badgeW, badgeW);

    [self addSubview:self.badgeLable];
}

-(void)setBadgeLable:(UILabel *)badgeLable{
    
    objc_setAssociatedObject(self, &badgeLabelKey, badgeLable, OBJC_ASSOCIATION_RETAIN);
}

-(UILabel *)badgeLable{
    
    return objc_getAssociatedObject(self, &badgeLabelKey);
}


@end

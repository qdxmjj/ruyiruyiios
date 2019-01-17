//
//  UIView+RoundAngleBorder.m
//  ruyiruyiios
//
//  Created by 姚永敏 on 2019/1/15.
//  Copyright © 2019 ruyiruyi. All rights reserved.
//

#import "UIView+RoundAngleBorder.h"

@implementation UIView (RoundAngleBorder)

-(void)roundAngleForSize:(CGSize)sisze roundAnglePath:(UIRectCorner)corner borderForColor:(UIColor *)color borderWidth:(CGFloat)borderWidth{
    
    //    UIRectCorner corner = UIRectCornerTopRight | UIRectCornerBottomRight;
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:sisze];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = path.CGPath;
    maskLayer.strokeColor = color.CGColor;
    maskLayer.lineWidth = borderWidth;
    maskLayer.fillColor = [UIColor whiteColor].CGColor;//填充色
    [self.layer addSublayer:maskLayer];
}

@end

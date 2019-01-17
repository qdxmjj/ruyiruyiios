//
//  UIView+RoundAngleBorder.h
//  ruyiruyiios
//
//  Created by 姚永敏 on 2019/1/15.
//  Copyright © 2019 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (RoundAngleBorder)

- (void)roundAngleForSize:(CGSize)sisze roundAnglePath:(UIRectCorner)corner borderForColor:(UIColor *)color borderWidth:(CGFloat)borderWidth;

@end

NS_ASSUME_NONNULL_END

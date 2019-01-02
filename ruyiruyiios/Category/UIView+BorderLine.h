//
//  UIView+BorderLine.h
//  LML
//
//  Created by 姚永敏 on 2018/12/15.
//  Copyright © 2018 YYM. All rights reserved.
//


#import "UIKit/UIKit.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, UIBorderSideType) {
    UIBorderSideTypeAll  = 0,
    UIBorderSideTypeTop = 1 << 0,
    UIBorderSideTypeBottom = 1 << 1,
    UIBorderSideTypeLeft = 1 << 2,
    UIBorderSideTypeRight = 1 << 3,
};

@interface UIView (BorderLine)

/**
 @param color 线的颜色
 @param borderWidth 线宽
 @param borderType 绘制的方向
 @return 请务必保证 在 self frame 设置完毕 并已经生效 后调用此方法 不然无效
 */
- (UIView *)borderForColor:(UIColor *)color borderWidth:(CGFloat)borderWidth borderType:(UIBorderSideType)borderType;

@end

NS_ASSUME_NONNULL_END

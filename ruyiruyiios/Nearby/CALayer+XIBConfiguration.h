//
//  CALayer+XIBConfiguration.h
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/8.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (XIBConfiguration)

/**
 *设置阴影的颜色类型为CGColor
 *xib设置颜色只是UIColor
 *所以需要此扩展
 */

@property(nonatomic, assign) UIColor *borderUIColor;
@property(nonatomic, assign) UIColor *shadowUIColor;

@end

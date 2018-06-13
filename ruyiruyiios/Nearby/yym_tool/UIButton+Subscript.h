//
//  UIButton+Subscript.h
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/12.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Subscript)


- (void)setBadgeValue:(NSInteger)badgeValue;

@property(nonatomic,strong)UILabel *badgeLable;

@end

//
//  PrivateNavigationView.h
//  TestOrdersType
//
//  Created by 小马驾驾 on 2018/5/29.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^backViewBlock)(BOOL isBack);

@interface PrivateNavigationView : UIView


@property(nonatomic,copy)backViewBlock backBlock;

@end

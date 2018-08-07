//
//  JJSliderView.h
//  ThreadTest+
//
//  Created by 小马驾驾 on 2018/8/1.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface JJSliderView : UIView

@property(nonatomic,assign)CGFloat minimum;

@property(nonatomic,assign)CGFloat maximum;

@property(nonatomic,assign)CGFloat value;

@property(nonatomic,strong)UIImage *thumbImage;

@property(nonatomic,assign,readonly)CGFloat currentValue;

@property(nonatomic,copy,readonly)NSString *currentValueStr;

@end

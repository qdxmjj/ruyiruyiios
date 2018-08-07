//
//  JJSliderView.h
//  ThreadTest+
//
//  Created by 小马驾驾 on 2018/8/1.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface JJSliderView : UIView

@property(nonatomic,assign)CGFloat miniNum;

@property(nonatomic,assign)CGFloat maxiNum;

@property(nonatomic,assign)CGFloat value;

@property(nonatomic,strong)UIImage *thumbImage;

@property(nonatomic,assign)CGFloat currentValue;

@property(nonatomic,copy)NSString *currentValueStr;
@end

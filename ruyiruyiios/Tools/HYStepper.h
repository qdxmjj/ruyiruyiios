//
//  HYStepper.h
//  HYStepper
//
//  Created by zhuxuhong on 2017/7/16.
//  Copyright © 2017年 zhuxuhong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYStepper;
//typedef void(^HYStepperCallback)(double value);

@protocol valueChangdDelegate<NSObject>

-(void)valueChangedWithValue:(CGFloat )value stepper:(HYStepper *)stepper;

@end

@interface HYStepper : UIView

@property(nonatomic,assign)BOOL isValueEditable;
@property(nonatomic,assign)CGFloat minValue;
@property(nonatomic,assign)CGFloat maxValue;
@property(nonatomic,assign)CGFloat value;
@property(nonatomic,assign)CGFloat stepValue;
//@property(nonatomic,copy)HYStepperCallback valueChanged;

@property(nonatomic,assign)id <valueChangdDelegate> delagate;

@end

//
//  VTCodeView.h
//  ruyiRuyi
//
//  Created by 姚永敏 on 2018/10/16.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^successfulVerificationBlock)(BOOL status);
@interface VTCodeView : UIView


@property(nonatomic,copy)successfulVerificationBlock block;

-(void)showWithSuperView:(UIView *)view;

-(void)dismiss;

@end

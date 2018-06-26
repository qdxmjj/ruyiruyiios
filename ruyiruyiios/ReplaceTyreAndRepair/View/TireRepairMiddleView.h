//
//  TireRepairMiddleView.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/26.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TireRepairMiddleView : UIView

@property(nonatomic, strong)UILabel *userNameLabel;
@property(nonatomic, strong)UILabel *userPhoneLabel;
@property(nonatomic, strong)UILabel *userPlatNumberLabel;
@property(nonatomic, strong)UIView *underLineView;

- (void)setdatatoViews:(NSString *)platNumberStr;

@end

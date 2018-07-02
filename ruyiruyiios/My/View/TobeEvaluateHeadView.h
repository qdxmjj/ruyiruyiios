//
//  TobeEvaluateHeadView.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/7/2.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TobeEvaluateHeadView : UIView

@property(nonatomic, strong)UIImageView *iconImageV;
@property(nonatomic, strong)UILabel *serviceLabel;
@property(nonatomic, strong)NSMutableArray *startMutableA;

- (void)setdatatoViews;

@end

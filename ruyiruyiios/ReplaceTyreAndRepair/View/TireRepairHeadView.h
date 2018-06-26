//
//  TireRepairHeadView.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/26.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RepairHeadAlertView.h"

@interface TireRepairHeadView : UIView

@property(nonatomic, strong)RepairHeadAlertView *alertView;
@property(nonatomic, strong)UILabel *freeRepairLabel;
@property(nonatomic, strong)UIView *underLineView;

- (void)setdatatoViews;

@end

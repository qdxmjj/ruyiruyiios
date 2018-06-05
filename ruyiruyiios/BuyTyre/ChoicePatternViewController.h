//
//  ChoicePatternViewController.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/30.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "RootViewController.h"
#import "YUFoldingTableView.h"
@interface ChoicePatternViewController : RootViewController

@property(nonatomic, strong)NSString *tireSize;
@property(nonatomic, strong)NSString *fontRearFlag;

@property (nonatomic, assign) YUFoldingSectionHeaderArrowPosition arrowPosition;

@end

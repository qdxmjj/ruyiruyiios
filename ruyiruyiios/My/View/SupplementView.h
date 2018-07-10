//
//  SupplementView.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/7/9.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NumberSelectView.h"

@interface SupplementView : UIView<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UILabel *needSuppleLabel;
@property(nonatomic, strong)UITableView *suppleTableV;
@property(nonatomic, strong)NumberSelectView *passnotWorryView;
@property(nonatomic, strong)UILabel *needMoneyLabel;
@property(nonatomic, strong)NSMutableArray *suppleNumberMutableA;
@property(nonatomic, assign)NSInteger tirePriceInteger;
@property(nonatomic, assign)NSInteger needPriceInteger;

- (instancetype)initWithFrame:(CGRect)frame numberOfSupplement:(NSMutableArray *)numberMutableA;
- (void)setdatatoSupplementViews:(NSString *)numberStr;

@end

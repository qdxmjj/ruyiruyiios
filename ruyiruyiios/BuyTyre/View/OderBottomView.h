//
//  OderBottomView.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/5.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OderBottomView : UIView

@property(nonatomic, strong)UILabel *tireTotalPriceLabel;
@property(nonatomic, strong)UILabel *cxwyTotalPriceLabel;
@property(nonatomic, strong)UIView *underView;
@property(nonatomic, strong)UILabel *totalPriceLabel;
@property(nonatomic, strong)UIButton *sureBtn;

- (void)setBottomViewData:(NSString *)tireTotalPriceStr cxwyTotalPrice:(NSString *)cxwyTotalPriceStr;

@end

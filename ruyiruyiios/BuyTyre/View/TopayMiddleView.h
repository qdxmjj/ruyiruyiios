//
//  TopayMiddleView.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/6.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoeOrderInfo.h"

@interface TopayMiddleView : UIView

@property(nonatomic, strong)UILabel *nameLabel;
@property(nonatomic, strong)UILabel *telephoneLabel;
@property(nonatomic, strong)UILabel *platLabel;
@property(nonatomic, strong)UILabel *totalPriceLabel;

- (void)setPayMiddleViewData:(ShoeOrderInfo *)shoeOrderInfo;

@end

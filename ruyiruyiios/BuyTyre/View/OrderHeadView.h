//
//  OrderHeadView.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/5.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuyTireData.h"

@interface OrderHeadView : UIView

@property(nonatomic, strong)UILabel *nameLabel;
@property(nonatomic, strong)UILabel *telephoneLabel;
@property(nonatomic, strong)UILabel *platNumberLabel;

- (void)setHeadViewData:(BuyTireData *)buyTireData;

@end

//
//  CreditLineTableViewCell.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/21.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreditLineCarInfo.h"

@interface CreditLineTableViewCell : UITableViewCell

@property(nonatomic, strong)UIImageView *carImageV;
@property(nonatomic, strong)UILabel *carNameLabel;
@property(nonatomic, strong)UILabel *carPlatLabel;
@property(nonatomic, strong)UILabel *creditLineLabel;
@property(nonatomic, strong)UILabel *residueCreditLabel;
@property(nonatomic, strong)UILabel *realLineLabel;
@property(nonatomic, strong)UILabel *realResidueLabel;
@property(nonatomic, strong)UIView *underLineView;

- (void)setdatatoViews:(CreditLineCarInfo *)creditCarInfo;

@end

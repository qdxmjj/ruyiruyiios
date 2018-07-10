//
//  SupplementTableViewCell.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/7/9.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserCarShoeOldBarCodeInfo.h"

@interface SupplementTableViewCell : UITableViewCell

@property(nonatomic, strong)UIImageView *tireImageV;
@property(nonatomic, strong)UILabel *tireNameLabel;
@property(nonatomic, strong)UILabel *tirePositionLabel;
@property(nonatomic, strong)UILabel *tireBarCodeLabel;
@property(nonatomic, strong)UILabel *tirePriceLabel;
@property(nonatomic, strong)UILabel *tireNumberLabel;
@property(nonatomic, strong)UIView *underLineView;

- (void)setdatatoViews:(UserCarShoeOldBarCodeInfo *)userInfo;

@end

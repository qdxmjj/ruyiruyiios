//
//  ToDeliveryTableViewCell.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/29.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TireChaneOrderInfo.h"

@interface ToDeliveryTableViewCell : UITableViewCell

@property(nonatomic, strong)UIImageView *tireImageV;
@property(nonatomic, strong)UILabel *tireNameLabel;
@property(nonatomic, strong)UILabel *tirePositionLabel;
@property(nonatomic, strong)UILabel *tireCountLabel;
@property(nonatomic, strong)UIView *underLineView;

- (void)setdatatoCellViews:(TireChaneOrderInfo *)tireChaneInfo img:(NSString *)imgUrlStr;

@end

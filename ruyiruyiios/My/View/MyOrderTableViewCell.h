//
//  MyOrderTableViewCell.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/8.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJUILabel.h"
#import "OrderInfo.h"

@interface UIButton(FillColor)

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
+ (UIImage *)imageWithColor:(UIColor *)color;
@end

@interface MyOrderTableViewCell : UITableViewCell

@property(nonatomic, strong)UIImageView *iconImageV;
@property(nonatomic, strong)JJUILabel *nameLabel;
@property(nonatomic, strong)UILabel *orderNumberLabel;
@property(nonatomic, strong)UILabel *orderTimeLabel;
@property(nonatomic, strong)UILabel *priceLabel;
@property(nonatomic, strong)UIButton *orderStatusBtn;
@property(nonatomic, copy)void(^orderBlock)(NSString *);

- (void)setCellviewData:(OrderInfo *)orderInfo;

@end

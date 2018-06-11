//
//  TobeReplacedTableViewCell.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/11.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TobeReplaceTireInfo.h"

@interface TobeReplacedTableViewCell : UITableViewCell

@property(nonatomic, strong)UIImageView *tireImageV;
@property(nonatomic, strong)UILabel *tireNameLabel;
@property(nonatomic, strong)UILabel *userNameLabel;
@property(nonatomic, strong)UILabel *buyNumberLabel;
@property(nonatomic, strong)UILabel *usableNumberLabel;
@property(nonatomic, strong)UILabel *serviceObjLabel;
@property(nonatomic, strong)UILabel *positionLabel;
@property(nonatomic, strong)UILabel *orderNumberLabel;
@property(nonatomic, strong)UIButton *cancelOrderBtn;
@property(nonatomic, strong)UIView *underLineView;

- (void)setDatatoSubviews:(TobeReplaceTireInfo *)tobeReplaceInfo;

@end

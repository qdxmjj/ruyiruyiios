//
//  PersonHeadImgTableViewCell.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/14.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonHeadImgTableViewCell : UITableViewCell

@property(nonatomic, strong)UIImageView *headImgV;
@property(nonatomic, strong)UILabel *alertLabel;
@property(nonatomic, strong)UIImageView *rightImgV;
@property(nonatomic, strong)UIView *b_view;

- (void)setDatatoCellViews;

@end

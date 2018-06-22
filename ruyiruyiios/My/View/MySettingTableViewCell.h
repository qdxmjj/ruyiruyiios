//
//  MySettingTableViewCell.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/19.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySettingTableViewCell : UITableViewCell

@property(nonatomic, strong)UIImageView *iconImageV;
@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UIImageView *rightImageV;
@property(nonatomic, strong)UIView *underLineView;
@property(nonatomic, strong)NSArray *imgArray;
@property(nonatomic, strong)NSArray *titleArray;

- (void)setDatatoViews:(NSInteger)index;
@end

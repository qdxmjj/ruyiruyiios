//
//  SelectBrandTableViewCell.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/21.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectBrandTableViewCell : UITableViewCell

@property(nonatomic, strong)UIImageView *iconImageV;
@property(nonatomic, strong)UILabel *nameLabel;
@property(nonatomic, strong)UIView *underLineV;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end

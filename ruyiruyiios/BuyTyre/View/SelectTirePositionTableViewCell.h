//
//  SelectTirePositionTableViewCell.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/30.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectTirePositionTableViewCell : UITableViewCell

@property(nonatomic, strong)UILabel *nameLabel;
@property(nonatomic, strong)UIImageView *arrowImageV;
@property(nonatomic, strong)UIView *underLineV;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end

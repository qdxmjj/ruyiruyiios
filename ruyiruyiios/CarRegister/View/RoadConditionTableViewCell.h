//
//  RoadConditionTableViewCell.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/21.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoadConditionTableViewCell : UITableViewCell

@property(nonatomic, strong)UIImageView *selectImageV;
@property(nonatomic, strong)UIImageView *pictureImageV;
@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UILabel *detailLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end

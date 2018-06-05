//
//  LocationTableViewCell.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/29.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationTableViewCell : UITableViewCell

@property(nonatomic, strong)UILabel *nameLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end

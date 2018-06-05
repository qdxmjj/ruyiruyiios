//
//  SelectBrandTableViewCell.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/21.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "SelectBrandTableViewCell.h"

@implementation SelectBrandTableViewCell

- (UIImageView *)iconImageV{
    
    if (_iconImageV == nil) {
        
        _iconImageV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
//        _iconImageV.backgroundColor = [UIColor redColor];
    }
    return _iconImageV;
}

- (UILabel *)nameLabel{
    
    if (_nameLabel == nil) {
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 20, MAINSCREEN.width - 95, 20)];
        _nameLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _nameLabel.textColor = [UIColor blackColor];
    }
    return _nameLabel;
}

- (UIView *)underLineV{
    
    if (_underLineV == nil) {
        
        _underLineV = [[UIView alloc] initWithFrame:CGRectMake(0, 59, MAINSCREEN.width, 0.5)];
        _underLineV.backgroundColor = [UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:0.1];
    }
    return _underLineV;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.iconImageV];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.underLineV];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

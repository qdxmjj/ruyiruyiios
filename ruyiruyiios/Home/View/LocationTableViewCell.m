//
//  LocationTableViewCell.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/29.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "LocationTableViewCell.h"

@implementation LocationTableViewCell

- (UILabel *)nameLabel{
    
    if (_nameLabel == nil) {
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, MAINSCREEN.width - 20, 20)];
        _nameLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.nameLabel];
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

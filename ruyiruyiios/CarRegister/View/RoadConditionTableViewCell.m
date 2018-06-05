//
//  RoadConditionTableViewCell.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/21.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "RoadConditionTableViewCell.h"

@implementation RoadConditionTableViewCell

- (UIImageView *)selectImageV{
    
    if (_selectImageV == nil) {
        
        _selectImageV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 100/2 - 16/2, 16, 16)];
        _selectImageV.image = [UIImage imageNamed:@"未选中"];
    }
    return _selectImageV;
}

- (UIImageView *)pictureImageV{
    
    if (_pictureImageV == nil) {
        
        _pictureImageV = [[UIImageView alloc] initWithFrame:CGRectMake(50, 10, (MAINSCREEN.width - 50)*7/12, 90)];
    }
    return _pictureImageV;
}

- (UILabel *)titleLabel{
    
    if (_titleLabel == nil) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50+(MAINSCREEN.width - 50)*7/12+5, 10, MAINSCREEN.width-(50+(MAINSCREEN.width-50)*7/12 + 5) - 10, 20)];
        _titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)detailLabel{
    
    if (_detailLabel == nil) {
        
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(50+(MAINSCREEN.width - 50)*7/12+5, 30, MAINSCREEN.width-(50+(MAINSCREEN.width-50)*7/12 + 5) - 10, 70)];
        _detailLabel.font = [UIFont fontWithName:TEXTFONT size:10.0];
        _detailLabel.textColor = [UIColor lightGrayColor];
        _detailLabel.numberOfLines = 0;
        _detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _detailLabel;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.selectImageV];
        [self.contentView addSubview:self.pictureImageV];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.detailLabel];
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

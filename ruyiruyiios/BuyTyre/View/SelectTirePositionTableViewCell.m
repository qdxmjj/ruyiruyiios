//
//  SelectTirePositionTableViewCell.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/30.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "SelectTirePositionTableViewCell.h"

@implementation SelectTirePositionTableViewCell

- (UILabel *)nameLabel{
    
    if (_nameLabel == nil) {
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, MAINSCREEN.width - 55, 20)];
        _nameLabel.textColor = TEXTCOLOR64;
        _nameLabel.font = [UIFont fontWithName:TEXTFONT size:18.0];
    }
    return _nameLabel;
}

- (UIImageView *)arrowImageV{
    
    if (_arrowImageV == nil) {
        
        _arrowImageV = [[UIImageView alloc] initWithFrame:CGRectMake(MAINSCREEN.width - 35, 15, 10, 15)];
        _arrowImageV.image = [UIImage imageNamed:@"ic_right"];
    }
    return _arrowImageV;
}

- (UIView *)underLineV{
    
    if (_underLineV == nil) {
        
        _underLineV = [[UIView alloc] initWithFrame:CGRectMake(0, 48, MAINSCREEN.width, 0.5)];
        _underLineV.backgroundColor = [PublicClass colorWithHexString:@"#ececec"];
    }
    return _underLineV;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.arrowImageV];
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

//
//  CarInfoTableViewCell.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/18.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "CarInfoTableViewCell.h"

@implementation CarInfoTableViewCell

- (UILabel *)leftLabel{
    
    if (_leftLabel == nil) {
        
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, MAINSCREEN.width/2 - 20, 20)];
        _leftLabel.textAlignment = NSTextAlignmentLeft;
        _leftLabel.textColor = [UIColor blackColor];
        _leftLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
    }
    return _leftLabel;
}

- (UILabel *)rightLabel{
    
    if (_rightLabel == nil) {
        
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(MAINSCREEN.width/2, 10, MAINSCREEN.width/2 -20, 20)];
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.textColor = [UIColor blackColor];
        _rightLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
    }
    return _rightLabel;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.leftLabel];
        [self.contentView addSubview:self.rightLabel];
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

//delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

@end

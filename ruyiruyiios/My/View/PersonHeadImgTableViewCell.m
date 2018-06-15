//
//  PersonHeadImgTableViewCell.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/14.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "PersonHeadImgTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation PersonHeadImgTableViewCell

- (UIImageView *)headImgV{
    
    if (_headImgV == nil) {
        
        _headImgV = [[UIImageView alloc] init];
    }
    return _headImgV;
}

- (UILabel *)alertLabel{
    
    if (_alertLabel == nil) {
        
        _alertLabel = [[UILabel alloc] init];
        _alertLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _alertLabel.textColor = TEXTCOLOR64;
        _alertLabel.textAlignment = NSTextAlignmentRight;
    }
    return _alertLabel;
}

- (UIImageView *)rightImgV{
    
    if (_rightImgV == nil) {
        
        _rightImgV = [[UIImageView alloc] init];
    }
    return _rightImgV;
}

- (UIView *)b_view{
    
    if (_b_view == nil) {
        
        _b_view = [[UIView alloc] init];
    }
    return _b_view;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.headImgV];
        [self.contentView addSubview:self.alertLabel];
        [self.contentView addSubview:self.rightImgV];
        [self.contentView addSubview:self.b_view];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.headImgV.frame = CGRectMake(20, 15, 50, 50);
    self.alertLabel.frame = CGRectMake(MAINSCREEN.width/2, 30, MAINSCREEN.width/2 - 40, 20);
    self.rightImgV.frame = CGRectMake(MAINSCREEN.width - 30 , 33, 10, 15);
    self.b_view.frame = CGRectMake(20, 78, MAINSCREEN.width - 20, 0.5);
}

- (void)setDatatoCellViews{
    
    [self.headImgV sd_setImageWithURL:[NSURL URLWithString:[UserConfig headimgurl]]];
    self.alertLabel.text = @"修改";
    self.rightImgV.image = [UIImage imageNamed:@"ic_right"];
    self.b_view.backgroundColor = [UIColor lightGrayColor];
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

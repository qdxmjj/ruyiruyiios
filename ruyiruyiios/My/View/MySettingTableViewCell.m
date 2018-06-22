//
//  MySettingTableViewCell.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/19.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "MySettingTableViewCell.h"

@implementation MySettingTableViewCell


- (UIImageView *)iconImageV{
    
    if (_iconImageV == nil) {
        
        _iconImageV = [[UIImageView alloc] init];
    }
    return _iconImageV;
}

- (UILabel *)titleLabel{
    
    if (_titleLabel == nil) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _titleLabel.textColor = TEXTCOLOR64;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UIImageView *)rightImageV{
    
    if (_rightImageV == nil) {
        
        _rightImageV = [[UIImageView alloc] init];
    }
    return _rightImageV;
}

- (UIView *)underLineView{
    
    if (_underLineView == nil) {
        
        _underLineView = [[UIView alloc] init];
        _underLineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _underLineView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.iconImageV];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.rightImageV];
        [self.contentView addSubview:self.underLineView];
        self.imgArray = @[@"ic_gaimima", @"ic_lianxi", @"ic_about"];
        self.titleArray = @[@"修改密码", @"联系客服", @"关于我们"];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.iconImageV.frame = CGRectMake(20, 22, 15, 15);
    self.titleLabel.frame = CGRectMake(40, 20, MAINSCREEN.width - 80, 20);
    self.rightImageV.frame = CGRectMake(MAINSCREEN.width - 32, 20, 12, 17);
    self.underLineView.frame = CGRectMake(20, 53, MAINSCREEN.width - 20, 0.5);
}

- (void)setDatatoViews:(NSInteger)index{
    
    self.iconImageV.image = [UIImage imageNamed:self.imgArray[index]];
    self.titleLabel.text = self.titleArray[index];
    self.rightImageV.image = [UIImage imageNamed:@"ic_right"];
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

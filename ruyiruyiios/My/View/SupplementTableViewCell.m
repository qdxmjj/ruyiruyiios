//
//  SupplementTableViewCell.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/7/9.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "SupplementTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation SupplementTableViewCell

- (UIImageView *)tireImageV{
    
    if (_tireImageV == nil) {
        
        _tireImageV = [[UIImageView alloc] init];
    }
    return _tireImageV;
}

- (UILabel *)tireNameLabel{
    
    if (_tireNameLabel == nil) {
        
        _tireNameLabel = [[UILabel alloc] init];
        _tireNameLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _tireNameLabel.numberOfLines = 0;
        _tireNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _tireNameLabel.textColor = [UIColor blackColor];
        _tireNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _tireNameLabel;
}

- (UILabel *)tirePositionLabel{
    
    if (_tirePositionLabel == nil) {
        
        _tirePositionLabel = [[UILabel alloc] init];
        _tirePositionLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _tirePositionLabel.textColor = TEXTCOLOR64;
        _tirePositionLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _tirePositionLabel;
}

- (UILabel *)tireBarCodeLabel{
    
    if (_tireBarCodeLabel == nil) {
        
        _tireBarCodeLabel = [[UILabel alloc] init];
        _tireBarCodeLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _tireBarCodeLabel.textColor = TEXTCOLOR64;
        _tireBarCodeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _tireBarCodeLabel;
}

- (UILabel *)tirePriceLabel{
    
    if (_tirePriceLabel == nil) {
        
        _tirePriceLabel = [[UILabel alloc] init];
        _tirePriceLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _tirePriceLabel.textColor = LOGINBACKCOLOR;
        _tirePriceLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _tirePriceLabel;
}

- (UILabel *)tireNumberLabel{
    
    if (_tireNumberLabel == nil) {
        
        _tireNumberLabel = [[UILabel alloc] init];
        _tireNumberLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _tireNumberLabel.textColor = TEXTCOLOR64;
        _tireNumberLabel.textAlignment = NSTextAlignmentRight;
    }
    return _tireNumberLabel;
}

- (UIView *)underLineView{
    
    if (_underLineView == nil) {
        
        _underLineView = [[UIView alloc] init];
    }
    return _underLineView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addViews];
    }
    return self;
}

- (void)addViews{
    
    [self.contentView addSubview:self.tireImageV];
    [self.contentView addSubview:self.tireNameLabel];
    [self.contentView addSubview:self.tirePositionLabel];
    [self.contentView addSubview:self.tireBarCodeLabel];
    [self.contentView addSubview:self.tirePriceLabel];
    [self.contentView addSubview:self.tireNumberLabel];
    [self.contentView addSubview:self.underLineView];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.tireImageV.frame = CGRectMake(20, 10, MAINSCREEN.width/3, 160);
    self.tireNameLabel.frame = CGRectMake(20 + MAINSCREEN.width/3 + 10, 15, MAINSCREEN.width*2/3 - 50, 60);
    self.tirePositionLabel.frame = CGRectMake(self.tireNameLabel.frame.origin.x, self.tireNameLabel.frame.size.height + self.tireNameLabel.frame.origin.y + 10, self.tireNameLabel.frame.size.width, 20);
    self.tireBarCodeLabel.frame = CGRectMake(self.tireNameLabel.frame.origin.x, self.tirePositionLabel.frame.origin.y + self.tirePositionLabel.frame.size.height + 10, self.tireNameLabel.frame.size.width, 20);
    self.tirePriceLabel.frame = CGRectMake(self.tireNameLabel.frame.origin.x, self.tireBarCodeLabel.frame.origin.y + self.tireBarCodeLabel.frame.size.height + 10, self.tireNameLabel.frame.size.width/2, 20);
    self.tireNumberLabel.frame = CGRectMake(self.tirePriceLabel.frame.size.width + self.tirePriceLabel.frame.origin.x, self.tirePriceLabel.frame.origin.y, self.tireNameLabel.frame.size.width/2, 20);
    self.underLineView.frame = CGRectMake(0, 178, MAINSCREEN.width, 1);
}

- (void)setdatatoViews:(UserCarShoeOldBarCodeInfo *)userInfo{
    
    [self.tireImageV sd_setImageWithURL:[NSURL URLWithString:userInfo.shoeImgUrl]];
    self.tireNameLabel.text = userInfo.shoeName;
    self.tireBarCodeLabel.text = [NSString stringWithFormat:@"条形码: %@", userInfo.barCode];
    self.tirePriceLabel.text = [NSString stringWithFormat:@"¥ %@", userInfo.price];
    self.tireNumberLabel.text = @"X1";
    if ([userInfo.fontRearFlag intValue] == 0) {
        
        self.tirePositionLabel.text = [NSString stringWithFormat:@"位置：前轮/后轮"];
    }else if ([userInfo.fontRearFlag intValue] == 1){
        
        self.tirePositionLabel.text = [NSString stringWithFormat:@"位置：前轮"];
    }else{
        
        self.tirePositionLabel.text = [NSString stringWithFormat:@"位置：后轮"];
    }
    self.underLineView.backgroundColor = [PublicClass colorWithHexString:@"#ececec"];
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

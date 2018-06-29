//
//  ToDeliveryTableViewCell.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/29.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "ToDeliveryTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation ToDeliveryTableViewCell

- (UIImageView *)tireImageV{
    
    if (_tireImageV == nil) {
        
        _tireImageV = [[UIImageView alloc] init];
    }
    return _tireImageV;
}

- (UILabel *)tireNameLabel{
    
    if (_tireNameLabel == nil) {
        
        _tireNameLabel = [[UILabel alloc] init];
        _tireNameLabel.textColor = [UIColor blackColor];
        _tireNameLabel.numberOfLines = 0;
        _tireNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _tireNameLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _tireNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _tireNameLabel;
}

- (UILabel *)tirePositionLabel{
    
    if (_tirePositionLabel == nil) {
        
        _tirePositionLabel = [[UILabel alloc] init];
        _tirePositionLabel.textColor = [UIColor blackColor];
        _tirePositionLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _tirePositionLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _tirePositionLabel;
}

- (UILabel *)tireCountLabel{
    
    if (_tireCountLabel == nil) {
        
        _tireCountLabel = [[UILabel alloc] init];
        _tireCountLabel.textColor = [UIColor blackColor];
        _tireCountLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _tireCountLabel.textAlignment = NSTextAlignmentRight;
    }
    return _tireCountLabel;
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
        
        [self.contentView addSubview:self.tireImageV];
        [self.contentView addSubview:self.tireNameLabel];
        [self.contentView addSubview:self.tirePositionLabel];
        [self.contentView addSubview:self.tireCountLabel];
        [self.contentView addSubview:self.underLineView];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.tireImageV.frame = CGRectMake(20, 10, MAINSCREEN.width/3, 130);
    self.tireNameLabel.frame = CGRectMake(MAINSCREEN.width/3+30, 10, MAINSCREEN.width*2/3 - 30 - 20, 60);
    self.tirePositionLabel.frame = CGRectMake(self.tireNameLabel.frame.origin.x, 70, self.tireNameLabel.frame.size.width, 20);
    self.tireCountLabel.frame = CGRectMake(self.tireNameLabel.frame.origin.x+self.tireNameLabel.frame.size.width/2, 110, self.tireNameLabel.frame.size.width/2, 20);
    self.underLineView.frame = CGRectMake(0, 148, MAINSCREEN.width, 1);
}

- (void)setdatatoCellViews:(TireChaneOrderInfo *)tireChaneInfo img:(NSString *)imgUrlStr{
    
    if ([tireChaneInfo.fontRearFlag intValue] == 0) {
        
        self.tirePositionLabel.text = @"位置：前轮/后轮";
        self.tireCountLabel.text = [NSString stringWithFormat:@"x%@", tireChaneInfo.fontAmount];
    }else if ([tireChaneInfo.fontRearFlag intValue] == 1){
        
        self.tirePositionLabel.text = @"位置：前轮";
        self.tireCountLabel.text = [NSString stringWithFormat:@"x%@", tireChaneInfo.fontAmount];
    }else{
        
        self.tirePositionLabel.text = @"位置：后轮";
        self.tireCountLabel.text = [NSString stringWithFormat:@"x%@", tireChaneInfo.rearAmount];
    }
    [self.tireImageV sd_setImageWithURL:[NSURL URLWithString:imgUrlStr]];
    self.tireNameLabel.text = tireChaneInfo.shoeName;
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

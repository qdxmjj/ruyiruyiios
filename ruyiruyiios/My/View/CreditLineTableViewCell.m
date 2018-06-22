//
//  CreditLineTableViewCell.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/21.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "CreditLineTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation CreditLineTableViewCell

- (UIImageView *)carImageV{
    
    if (_carImageV == nil) {
        
        _carImageV = [[UIImageView alloc] init];
    }
    return _carImageV;
}

- (UILabel *)carNameLabel{
    
    if (_carNameLabel == nil) {
        
        _carNameLabel = [[UILabel alloc] init];
        _carNameLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _carNameLabel.textAlignment = NSTextAlignmentCenter;
        _carNameLabel.textColor = [UIColor blackColor];
    }
    return _carNameLabel;
}

- (UILabel *)carPlatLabel{
    
    if (_carPlatLabel == nil) {
        
        _carPlatLabel = [[UILabel alloc] init];
        _carPlatLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _carPlatLabel.textAlignment = NSTextAlignmentCenter;
        _carPlatLabel.textColor = TEXTCOLOR64;
    }
    return _carPlatLabel;
}

- (UILabel *)creditLineLabel{
    
    if (_creditLineLabel == nil) {
        
        _creditLineLabel = [[UILabel alloc] init];
        _creditLineLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _creditLineLabel.textAlignment = NSTextAlignmentCenter;
        _creditLineLabel.textColor = [UIColor lightGrayColor];
    }
    return _creditLineLabel;
}

- (UILabel *)residueCreditLabel{
    
    if (_residueCreditLabel == nil) {
        
        _residueCreditLabel = [[UILabel alloc] init];
        _residueCreditLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _residueCreditLabel.textAlignment = NSTextAlignmentCenter;
        _residueCreditLabel.textColor = [UIColor lightGrayColor];
    }
    return _residueCreditLabel;
}

- (UILabel *)realLineLabel{
    
    if (_realLineLabel == nil) {
        
        _realLineLabel = [[UILabel alloc] init];
        _realLineLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _realLineLabel.textAlignment = NSTextAlignmentCenter;
        _realLineLabel.textColor = [UIColor lightGrayColor];
    }
    return _realLineLabel;
}

- (UILabel *)realResidueLabel{
    
    if (_realResidueLabel == nil) {
        
        _realResidueLabel = [[UILabel alloc] init];
        _realResidueLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _realResidueLabel.textAlignment = NSTextAlignmentCenter;
        _realResidueLabel.textColor = [UIColor lightGrayColor];
    }
    return _realResidueLabel;
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
    
    [self.contentView addSubview:self.carImageV];
    [self.contentView addSubview:self.carNameLabel];
    [self.contentView addSubview:self.carPlatLabel];
    [self.contentView addSubview:self.creditLineLabel];
    [self.contentView addSubview:self.residueCreditLabel];
    [self.contentView addSubview:self.realLineLabel];
    [self.contentView addSubview:self.realResidueLabel];
    [self.contentView addSubview:self.underLineView];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.carImageV.frame = CGRectMake(20, 40, 60, 60);
    self.carNameLabel.frame = CGRectMake(100, 20, MAINSCREEN.width - 100, 20);
    self.carPlatLabel.frame = CGRectMake(100, 50, MAINSCREEN.width - 100, 20);
    self.creditLineLabel.frame = CGRectMake(100, 80, (MAINSCREEN.width - 100)/2, 20);
    self.residueCreditLabel.frame = CGRectMake(self.creditLineLabel.frame.origin.x+self.creditLineLabel.frame.size.width, 80, self.creditLineLabel.frame.size.width, 20);
    self.realLineLabel.frame = CGRectMake(100, 110, self.creditLineLabel.frame.size.width, 20);
    self.realResidueLabel.frame = CGRectMake(self.creditLineLabel.frame.origin.x+self.creditLineLabel.frame.size.width, 110, self.creditLineLabel.frame.size.width, 20);
    self.underLineView.frame = CGRectMake(0, 148, MAINSCREEN.width, 0.5);
}

- (void)setdatatoViews:(CreditLineCarInfo *)creditCarInfo{
    
    [self.carImageV sd_setImageWithURL:[NSURL URLWithString:creditCarInfo.logoUrl]];
    self.carNameLabel.text = creditCarInfo.carName;
    self.carPlatLabel.text = [NSString stringWithFormat:@"车牌号: %@", creditCarInfo.platNumber];
    self.creditLineLabel.text = @"信用额度";
    self.residueCreditLabel.text = @"剩余信用额度";
    self.realLineLabel.text = [NSString stringWithFormat:@"%.1f", [creditCarInfo.credit floatValue]];
    self.realResidueLabel.text = [NSString stringWithFormat:@"%.1f", [creditCarInfo.remain floatValue]];
    self.underLineView.backgroundColor = [UIColor lightGrayColor];
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

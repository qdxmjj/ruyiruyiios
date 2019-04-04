//
//  ManageCarTableViewCell.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/25.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "ManageCarTableViewCell.h"

@implementation ManageCarTableViewCell

- (UIImageView *)carImageV{
    
    if (_carImageV == nil) {
        
        _carImageV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 50, 50)];
    }
    return _carImageV;
}

- (UILabel *)carNameLabel{
    
    if (_carNameLabel == nil) {
        
        _carNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 25, 80, 20)];
        _carNameLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _carNameLabel.textColor = [UIColor blackColor];
        _carNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _carNameLabel;
}
- (UIImageView *)authenticatedImgView{
    if (!_authenticatedImgView) {
        _authenticatedImgView = [[UIImageView alloc] initWithFrame:CGRectMake(180, 25, 80, 25)];
    }
    return _authenticatedImgView;
}
- (UILabel *)platNumberLabel{
    
    if (_platNumberLabel == nil) {
        
        _platNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 45, MAINSCREEN.width - 80, 20)];
        _platNumberLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _platNumberLabel.textColor = [UIColor lightGrayColor];
        _platNumberLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _platNumberLabel;
}

- (UIView *)underLineV{
    
    if (_underLineV == nil) {
        
        _underLineV = [[UIView alloc] initWithFrame:CGRectMake(20, 89, MAINSCREEN.width-20, 0.5)];
        _underLineV.backgroundColor = [UIColor lightGrayColor];
    }
    return _underLineV;
}

- (UIImageView *)defultImageV{
    
    if (_defultImageV == nil) {
        
        _defultImageV = [[UIImageView alloc] initWithFrame:CGRectMake(MAINSCREEN.width-50, 0, 50, 50)];
        _defultImageV.image = [UIImage imageNamed:@"默认"];
        _defultImageV.hidden = YES;
    }
    return _defultImageV;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.carImageV];
        [self.contentView addSubview:self.carNameLabel];
        [self.contentView addSubview:self.authenticatedImgView];
        [self.contentView addSubview:self.platNumberLabel];
        [self.contentView addSubview:self.underLineV];
        [self.contentView addSubview:self.defultImageV];
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

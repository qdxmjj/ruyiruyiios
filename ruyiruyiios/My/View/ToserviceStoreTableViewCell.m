//
//  ToserviceStoreTableViewCell.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/7/1.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "ToserviceStoreTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation ToserviceStoreTableViewCell

- (UIImageView *)storeImageV{
    
    if (_storeImageV == nil) {
        
        _storeImageV = [[UIImageView alloc] init];
    }
    return _storeImageV;
}

- (UILabel *)storeNameLabel{
    
    if (_storeNameLabel == nil) {
        
        _storeNameLabel = [[UILabel alloc] init];
        _storeNameLabel.textColor = [UIColor blackColor];
        _storeNameLabel.numberOfLines = 0;
        _storeNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _storeNameLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _storeNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _storeNameLabel;
}

- (UILabel *)storePriceLabel{
    
    if (_storePriceLabel == nil) {
        
        _storePriceLabel = [[UILabel alloc] init];
        _storePriceLabel.textColor = LOGINBACKCOLOR;
        _storePriceLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _storePriceLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _storePriceLabel;
}

- (UILabel *)storeCountLabel{
    
    if (_storeCountLabel == nil) {
        
        _storeCountLabel = [[UILabel alloc] init];
        _storeCountLabel.textColor = [UIColor blackColor];
        _storeCountLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _storeCountLabel.textAlignment = NSTextAlignmentRight;
    }
    return _storeCountLabel;
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
        
        [self.contentView addSubview:self.storeImageV];
        [self.contentView addSubview:self.storeNameLabel];
        [self.contentView addSubview:self.storePriceLabel];
        [self.contentView addSubview:self.storeCountLabel];
        [self.contentView addSubview:self.underLineView];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.storeImageV.frame = CGRectMake(20, 10, MAINSCREEN.width/3, 130);
    self.storeNameLabel.frame = CGRectMake(MAINSCREEN.width/3+30, 10, MAINSCREEN.width*2/3 - 30 - 20, 20);
    self.storePriceLabel.frame = CGRectMake(self.storeNameLabel.frame.origin.x, 110, self.storeNameLabel.frame.size.width, 20);
    self.storeCountLabel.frame = CGRectMake(self.storeNameLabel.frame.origin.x+self.storeNameLabel.frame.size.width/2, 110, self.storeNameLabel.frame.size.width/2, 20);
    self.underLineView.frame = CGRectMake(0, 148, MAINSCREEN.width, 1);
}

- (void)setdatatoCellViews:(StockOrderVoInfo *)stockOrderInfo{
    
    [self.storeImageV sd_setImageWithURL:[NSURL URLWithString:stockOrderInfo.detailImage]];
    self.storeNameLabel.text = stockOrderInfo.detailName;
    self.storePriceLabel.text = [NSString stringWithFormat:@"¥ %@", stockOrderInfo.detailPrice];
    self.storeCountLabel.text = [NSString stringWithFormat:@"x %@", stockOrderInfo.amount];
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

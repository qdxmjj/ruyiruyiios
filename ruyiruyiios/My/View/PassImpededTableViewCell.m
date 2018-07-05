//
//  PassImpededTableViewCell.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/12.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "PassImpededTableViewCell.h"

@implementation PassImpededTableViewCell

- (UIImageView *)backGroundImageV{
    
    if (_backGroundImageV == nil) {
        
        _backGroundImageV = [[UIImageView alloc] init];
    }
    return _backGroundImageV;
}

- (UILabel *)controlTimeLabel{
    
    if (_controlTimeLabel == nil) {
        
        _controlTimeLabel = [[UILabel alloc] init];
        _controlTimeLabel.textColor = TEXTCOLOR64;
        _controlTimeLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _controlTimeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _controlTimeLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.backGroundImageV];
        [self.contentView addSubview:self.controlTimeLabel];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.backGroundImageV.frame = CGRectMake(10, 10, MAINSCREEN.width - 20, 100);
    self.controlTimeLabel.frame = CGRectMake(30, 80, MAINSCREEN.width - 40, 20);
}

- (void)setdatatoCellViews:(CarCXWYInfo *)carCXWYInfo{
    
    if ([carCXWYInfo.getWay isEqualToNumber:[NSNumber numberWithInt:1]]) {
        
        self.backGroundImageV.image = [UIImage imageNamed:@"活动赠送"];
    }else{
        
        self.backGroundImageV.image = [UIImage imageNamed:@"正常购买"];
    }
    
    if (carCXWYInfo.cxwyEndtime == NULL) {
        
        self.controlTimeLabel.text = @"以前的数据";
    }else{
        
        NSString *startTimeStr = [PublicClass timestampSwitchTime:[carCXWYInfo.cxwyStarttime integerValue] andFormatter:@"YYYY-MM-dd"];
        NSString *endTimeStr = [PublicClass timestampSwitchTime:[carCXWYInfo.cxwyEndtime integerValue] andFormatter:@"YYYY-MM-dd"];
        self.controlTimeLabel.text = [NSString stringWithFormat:@"限制使用时间:%@-%@", startTimeStr, endTimeStr];
    }
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

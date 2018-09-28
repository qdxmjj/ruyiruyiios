//
//  PassImpededTableViewCell.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/12.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "PassImpededTableViewCell.h"
#import <Masonry.h>
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
    
    [self.backGroundImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView.mas_top).inset(10);
        make.height.mas_equalTo(@100);
    }];
    
    [self.controlTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.contentView.mas_left).inset(20);
        make.right.mas_equalTo(self.contentView.mas_right).inset(20);
        make.top.mas_equalTo(self.contentView.mas_top).inset(80);
        make.height.mas_equalTo(@20);
        
    }];
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
        
//        NSString *startTimeStr = [PublicClass timestampSwitchTime:[carCXWYInfo.cxwyStarttime integerValue] andFormatter:@"YYYY-MM-dd"];
//        NSString *endTimeStr = [PublicClass timestampSwitchTime:[carCXWYInfo.cxwyEndtime integerValue] andFormatter:@"YYYY-MM-dd"];
//        self.controlTimeLabel.text = [NSString stringWithFormat:@"限制使用时间:%@-%@", startTimeStr, endTimeStr];
        self.controlTimeLabel.text = [NSString stringWithFormat:@"限制使用时间：车辆服务年限内有效"];

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

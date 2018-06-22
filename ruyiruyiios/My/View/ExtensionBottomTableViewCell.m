//
//  ExtensionBottomTableViewCell.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/20.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "ExtensionBottomTableViewCell.h"

@implementation ExtensionBottomTableViewCell

- (UILabel *)userphoneLabel{
    
    if (_userphoneLabel == nil) {
        
        _userphoneLabel = [[UILabel alloc] init];
        _userphoneLabel.textColor = TEXTCOLOR64;
        _userphoneLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _userphoneLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _userphoneLabel;
}

- (UILabel *)statusLabel{
    
    if (_statusLabel == nil) {
        
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.textColor = TEXTCOLOR64;
        _statusLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _statusLabel;
}

- (UILabel *)joinLabel{
    
    if (_joinLabel == nil) {
        
        _joinLabel = [[UILabel alloc] init];
        _joinLabel.textColor = TEXTCOLOR64;
        _joinLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _joinLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _joinLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.userphoneLabel];
        [self.contentView addSubview:self.statusLabel];
        [self.contentView addSubview:self.joinLabel];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.userphoneLabel.frame = CGRectMake(0, 5, MAINSCREEN.width/3, 20);
    self.statusLabel.frame = CGRectMake(MAINSCREEN.width/3, 5, MAINSCREEN.width/3, 20);
    self.joinLabel.frame = CGRectMake(MAINSCREEN.width*2/3, 5, MAINSCREEN.width/3, 20);
}

- (void)setdatatoCellSubviews:(SharePersonInfo *)sharePersonInfo{
    
    self.userphoneLabel.text = sharePersonInfo.phone;
    self.joinLabel.text = [PublicClass timestampSwitchTime:[sharePersonInfo.lastUpdatedTime integerValue] andFormatter:@"YYYY-MM-dd"];
    if ([sharePersonInfo.status isEqualToNumber:[NSNumber numberWithInt:1]]) {
        
        self.statusLabel.text = @"已邀请";
    }else if ([sharePersonInfo.status isEqualToNumber:[NSNumber numberWithInt:2]]){
        
        self.statusLabel.text = @"已注册app";
    }else if ([sharePersonInfo.status isEqualToNumber:[NSNumber numberWithInt:3]]){
        
        self.statusLabel.text = @"已注册车辆信息";
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

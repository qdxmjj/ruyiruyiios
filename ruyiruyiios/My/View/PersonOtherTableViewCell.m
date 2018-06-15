//
//  PersonOtherTableViewCell.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/14.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "PersonOtherTableViewCell.h"

@implementation PersonOtherTableViewCell
@synthesize flagStr;
@synthesize isemail;

- (UILabel *)titleLabel{
    
    if (_titleLabel == nil) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = TEXTCOLOR64;
    }
    return _titleLabel;
}

- (UITextField *)nameTF{
    
    if (_nameTF == nil) {
        
        _nameTF = [[UITextField alloc] init];
        _nameTF.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _nameTF.textColor = TEXTCOLOR64;
        _nameTF.textAlignment = NSTextAlignmentRight;
        _nameTF.delegate = self;
    }
    return _nameTF;
}

- (UILabel *)dataLabel{
    
    if (_dataLabel == nil) {
        
        _dataLabel = [[UILabel alloc] init];
        _dataLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _dataLabel.textAlignment = NSTextAlignmentRight;
        _dataLabel.textColor = TEXTCOLOR64;
    }
    return _dataLabel;
}

- (UIImageView *)rightImageV{
    
    if (_rightImageV == nil) {
        
        _rightImageV = [[UIImageView alloc] init];
    }
    return _rightImageV;
}

- (UIView *)b_view{
    
    if (_b_view == nil) {
        
        _b_view = [[UIView alloc] init];
    }
    return _b_view;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier flag:(NSString *)flagStr email:(NSString *)isemail{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.flagStr = flagStr;
        self.isemail = isemail;
        [self addViews:flagStr];
    }
    return self;
}

- (void)addViews:(NSString *)flag{
    
    if ([flag isEqualToString:@"0"]) {
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.nameTF];
    }else{
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.dataLabel];
        [self.contentView addSubview:self.rightImageV];
    }
    [self.contentView addSubview:self.b_view];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    if ([isemail isEqualToString:@"1"]) {
        
        self.titleLabel.frame = CGRectMake(20, 15, 40, 20);
        self.dataLabel.frame = CGRectMake(60, 15, MAINSCREEN.width - 100, 20);
    }else{
        
        self.titleLabel.frame = CGRectMake(20, 15, MAINSCREEN.width/2 - 20, 20);
        self.dataLabel.frame = CGRectMake(MAINSCREEN.width/2, 15, MAINSCREEN.width/2 - 40, 20);
    }
    self.nameTF.frame = CGRectMake(MAINSCREEN.width/2, 15, MAINSCREEN.width/2 - 40, 20);
    self.rightImageV.frame = CGRectMake(MAINSCREEN.width - 30, 17, 10, 15);
    self.b_view.frame = CGRectMake(20, 48, MAINSCREEN.width - 20, 0.5);
}

- (void)setdatatoCellViewstitleStr:(NSString *)titleStr data:(NSString *)dataStr{
    
    if ([self.flagStr isEqualToString:@"0"]) {
        
        self.titleLabel.text = titleStr;
        self.nameTF.text = dataStr;
    }else{
        
        self.titleLabel.text = titleStr;
        if ([dataStr integerValue] == 1) {
            
            self.dataLabel.text = @"男";
        }else if ([dataStr integerValue] == 2){
            
            self.dataLabel.text = @"女";
        }else{
            
            self.dataLabel.text = dataStr;
        }
        self.rightImageV.image = [UIImage imageNamed:@"ic_right"];
    }
    self.b_view.backgroundColor = [UIColor lightGrayColor];
}

//UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
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

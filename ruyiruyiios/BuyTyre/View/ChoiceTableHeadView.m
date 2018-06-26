//
//  ChoiceTableHeadView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/23.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "ChoiceTableHeadView.h"

@implementation ChoiceTableHeadView

- (UILabel *)nameLabel{
    
    if (_nameLabel == nil) {
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _nameLabel.textColor = TEXTCOLOR64;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}

- (UIImageView *)rightImageV{
    
    if (_rightImageV == nil) {
        
        _rightImageV = [[UIImageView alloc] init];
        _rightImageV.contentMode = UIViewContentModeCenter;
    }
    return _rightImageV;
}

- (UIButton *)statusBtn{
    
    if (_statusBtn == nil) {
        
        _statusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _statusBtn;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.nameLabel];
        [self addSubview:self.rightImageV];
        [self addSubview:self.statusBtn];
    }
    return self;
}

- (void)layoutSubviews{
    
    self.nameLabel.frame = CGRectMake(20, 15, MAINSCREEN.width - 20 - 40, 20);
    self.rightImageV.frame = CGRectMake(MAINSCREEN.width - 40, 15, 20, 20);
    self.statusBtn.frame = CGRectMake(0, 0, MAINSCREEN.width, 50);
}

- (void)setdatatoViews:(NSString *)nameStr img:(NSString *)imgStr{
    
    self.nameLabel.text = nameStr;
    self.rightImageV.image = [UIImage imageNamed:imgStr];
}

- (void)setbackgroundAndTitleColorAndRightImg:(NSString *)flagStr{
    
    //flagStr:1----selected   0----unselected
    if ([flagStr isEqualToString:@"0"]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.nameLabel.textColor = TEXTCOLOR64;
        self.rightImageV.image = [UIImage imageNamed:@"ic_right"];
    }else{
        
        self.backgroundColor = LOGINBACKCOLOR;
        self.nameLabel.textColor = [UIColor whiteColor];
        self.rightImageV.image = [UIImage imageNamed:@"bic_down"];
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

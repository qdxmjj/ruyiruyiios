//
//  TireRepairHeadView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/26.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "TireRepairHeadView.h"

@implementation TireRepairHeadView

- (RepairHeadAlertView *)alertView{
    
    if (_alertView == nil) {
        
        _alertView = [[RepairHeadAlertView alloc] init];
    }
    return _alertView;
}

- (UILabel *)freeRepairLabel{
    
    if (_freeRepairLabel == nil) {
        
        _freeRepairLabel = [[UILabel alloc] init];
        _freeRepairLabel.textColor = [UIColor blackColor];
        _freeRepairLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _freeRepairLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _freeRepairLabel;
}

- (UIView *)underLineView{
    
    if (_underLineView == nil) {
        
        _underLineView = [[UIView alloc] init];
    }
    return _underLineView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        NSArray *nameArray = @[@"胎面破损直径小于6MM", @"该条轮胎修补小于3处"];
        [self addUnchangeViews:nameArray];
        [self addChangeViews];
    }
    return self;
}

- (void)addUnchangeViews:(NSArray *)array{
    
    for (int i = 0; i<array.count; i++) {
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(20, 80+30*i, 16, 16)];
        img.image = [UIImage imageNamed:@"ic_check"];
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 80+30*i, MAINSCREEN.width - 45, 20)];
        nameLabel.text = array[i];
        nameLabel.textColor = TEXTCOLOR64;
        nameLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:img];
        [self addSubview:nameLabel];
    }
}

- (void)addChangeViews{
    
    [self addSubview:self.alertView];
    [self addSubview:self.freeRepairLabel];
    [self addSubview:self.underLineView];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.alertView.frame = CGRectMake(0, 0, MAINSCREEN.width, 40);
    self.freeRepairLabel.frame = CGRectMake(20, 50, MAINSCREEN.width - 20, 20);
    self.underLineView.frame = CGRectMake(0, 138, MAINSCREEN.width, 1);
}


- (void)setdatatoViews{
    
    self.alertView.backgroundColor = [PublicClass colorWithHexString:@"#ececec"];
    self.freeRepairLabel.text = @"免费修补标准";
    self.underLineView.backgroundColor = [PublicClass colorWithHexString:@"#ececec"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

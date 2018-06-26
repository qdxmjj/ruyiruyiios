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
        
        _alertView = [[RepairHeadAlertView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, 50)];
    }
    return _alertView;
}

- (UIView *)freeRepireView{
    
    if (_freeRepireView == nil) {
        
        _freeRepireView = [[UIView alloc] init];
    }
    return _freeRepireView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.alertView];
        [self addSubview:self.freeRepireView];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.alertView.frame = CGRectMake(0, 0, MAINSCREEN.width, 50);
    self.freeRepireView.frame = CGRectMake(0, 50, MAINSCREEN.width, 120);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

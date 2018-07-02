//
//  TobeEvaluateHeadView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/7/2.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "TobeEvaluateHeadView.h"
#import <UIImageView+WebCache.h>

@implementation TobeEvaluateHeadView

- (UIImageView *)iconImageV{
    
    if (_iconImageV == nil) {
        
        _iconImageV = [[UIImageView alloc] init];
        _iconImageV.layer.cornerRadius = 45.0;
        _iconImageV.layer.masksToBounds = YES;
    }
    return _iconImageV;
}

- (UILabel *)serviceLabel{
    
    if (_serviceLabel == nil) {
        
        _serviceLabel = [[UILabel alloc] init];
        _serviceLabel.textColor = TEXTCOLOR64;
        _serviceLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _serviceLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _serviceLabel;
}

- (NSMutableArray *)startMutableA{
    
    if (_startMutableA == nil) {
        
        _startMutableA = [[NSMutableArray alloc] init];
    }
    return _startMutableA;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addUnchangeViews];
        [self addChangeViews];
    }
    return self;
}

- (void)addUnchangeViews{
    
    for (int i = 0; i<5; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(115+26*i, 60, 24, 24);
        button.tag = 1000+i;
        [button setBackgroundImage:[UIImage imageNamed:@"ic_huistar"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"ic_star"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(chickButton:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            
            button.selected = YES;
        }
        [self addSubview:button];
    }
}

- (void)chickButton:(UIButton *)btn{
    
    [self.startMutableA removeAllObjects];
    int number = (int)(btn.tag - 1000);
    for (int s = 1; s<5; s++) {
        
        UIButton *unselectBtn = (UIButton *)[self viewWithTag:(s+1000)];
        unselectBtn.selected = NO;
    }
    for (int p = 1; p<number+1; p++) {
        
        UIButton *selectBtn = (UIButton *)[self viewWithTag:(p+1000)];
        selectBtn.selected = YES;
        [self.startMutableA addObject:selectBtn];
    }
}

- (void)addChangeViews{
    
    [self addSubview:self.iconImageV];
    [self addSubview:self.serviceLabel];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.iconImageV.frame = CGRectMake(15, 15, 90, 90);
    self.serviceLabel.frame = CGRectMake(115, 30, MAINSCREEN.width - 80, 20);
}

- (void)setdatatoViews{
    
    [self.iconImageV sd_setImageWithURL:[NSURL URLWithString:[UserConfig headimgurl]]];
    self.serviceLabel.text = @"服务满意程度";
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

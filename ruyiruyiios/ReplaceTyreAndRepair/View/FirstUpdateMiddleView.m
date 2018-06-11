//
//  FirstUpdateMiddleView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/11.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "FirstUpdateMiddleView.h"

@implementation FirstUpdateMiddleView
@synthesize f_limitNumberStr;
@synthesize r_limitNumberStr;

- (NumberSelectView *)fontSelectView{
    
    if (_fontSelectView == nil) {
        
        _fontSelectView = [[NumberSelectView alloc] init];
        _fontSelectView.limitNumberStr = f_limitNumberStr;
    }
    return _fontSelectView;
}

- (NumberSelectView *)rearSelectView{
    
    if (_rearSelectView == nil) {
        
        _rearSelectView = [[NumberSelectView alloc] init];
        _rearSelectView.limitNumberStr = r_limitNumberStr;
    }
    return _rearSelectView;
}

- (UIButton *)updateProcessBtn{
    
    if (_updateProcessBtn == nil) {
        
        _updateProcessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _updateProcessBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        [_updateProcessBtn setTitle:@"更换流程" forState:UIControlStateNormal];
        [_updateProcessBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_updateProcessBtn setImage:[UIImage imageNamed:@"ic_right"] forState:UIControlStateNormal];
        [_updateProcessBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        [_updateProcessBtn setImageEdgeInsets:UIEdgeInsetsMake(0, MAINSCREEN.width - 50, 0, 0)];
        _updateProcessBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _updateProcessBtn;
}

- (UIImageView *)processImageV{
    
    if (_processImageV == nil) {
        
        _processImageV = [[UIImageView alloc] init];
        _processImageV.image = [UIImage imageNamed:@"ic_liucheng"];
    }
    return _processImageV;
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
    
    NSArray *nameArray = @[@"前轮数量", @"后轮数量"];
    for (int i = 0; i<nameArray.count; i++) {
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.frame = CGRectMake(20, 15+40*i, MAINSCREEN.width/2-20, 20);
        nameLabel.textColor = TEXTCOLOR64;
        nameLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        nameLabel.text = nameArray[i];
        [self addSubview:nameLabel];
    }
    UIView *h_view = [[UIView alloc] initWithFrame:CGRectMake(0, 90, MAINSCREEN.width, 0.5)];
    h_view.backgroundColor = [PublicClass colorWithHexString:@"#ececec"];
    [self addSubview:h_view];
    
    UIView *b_view = [[UIView alloc] initWithFrame:CGRectMake(0, 199, MAINSCREEN.width, 0.5)];
    b_view.backgroundColor = [PublicClass colorWithHexString:@"#ececec"];
    [self addSubview:b_view];
}

- (void)addChangeViews{
    
    [self addSubview:self.fontSelectView];
    [self addSubview:self.rearSelectView];
    [self addSubview:self.updateProcessBtn];
    [self addSubview:self.processImageV];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.fontSelectView.frame = CGRectMake(MAINSCREEN.width - 130, 10, 110, 30);
    self.rearSelectView.frame = CGRectMake(MAINSCREEN.width - 130, 50, 110, 30);
    self.updateProcessBtn.frame = CGRectMake(20, 100, MAINSCREEN.width - 40, 20);
    self.processImageV.frame = CGRectMake(20, 140, MAINSCREEN.width - 40, 50);
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

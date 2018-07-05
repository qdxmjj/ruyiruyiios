//
//  BuyPassMiddleView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/12.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "BuyPassMiddleView.h"

@implementation BuyPassMiddleView

- (UILabel *)nameLabel{
    
    if (_nameLabel == nil) {
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor lightGrayColor];
        _nameLabel.textAlignment = NSTextAlignmentRight;
        _nameLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
    }
    return _nameLabel;
}

- (UILabel *)phoneLabel{
    
    if (_phoneLabel == nil) {
        
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.textColor = [UIColor lightGrayColor];
        _phoneLabel.textAlignment = NSTextAlignmentRight;
        _phoneLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
    }
    return _phoneLabel;
}

- (UILabel *)platNumberLabel{
    
    if (_platNumberLabel == nil) {
        
        _platNumberLabel = [[UILabel alloc] init];
        _platNumberLabel.textColor = [UIColor lightGrayColor];
        _platNumberLabel.textAlignment = NSTextAlignmentRight;
        _platNumberLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
    }
    return _platNumberLabel;
}

- (NumberSelectView *)buyNumberSelectV{
    
    if (_buyNumberSelectV == nil) {
        
        _buyNumberSelectV = [[NumberSelectView alloc] init];
    }
    return _buyNumberSelectV;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addUnchangeView];
        [self addChangeView];
    }
    return self;
}

- (void)addUnchangeView{
    
    UIView *h_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, 5)];
    h_view.backgroundColor = [PublicClass colorWithHexString:@"#ececec"];
    [self addSubview:h_view];
    NSArray *titleArray = @[@"用户名", @"联系电话", @"车牌号", @"购买数量"];
    for (int i = 0; i<titleArray.count; i++) {
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20+(50*i), MAINSCREEN.width/2 - 20, 20)];
        titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        titleLabel.textColor = TEXTCOLOR64;
        titleLabel.text = titleArray[i];
        [self addSubview:titleLabel];
        
        UIView *b_view = [[UIView alloc] initWithFrame:CGRectMake(0, 54+(50*i), MAINSCREEN.width, 1)];
        b_view.backgroundColor = [PublicClass colorWithHexString:@"#ececec"];
        [self addSubview:b_view];
    }
}

- (void)addChangeView{
    
    [self addSubview:self.nameLabel];
    [self addSubview:self.phoneLabel];
    [self addSubview:self.platNumberLabel];
    [self addSubview:self.buyNumberSelectV];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.nameLabel.frame = CGRectMake(MAINSCREEN.width/2, 20, MAINSCREEN.width/2-20, 20);
    self.phoneLabel.frame = CGRectMake(MAINSCREEN.width/2, 70, MAINSCREEN.width/2-20, 20);
    self.platNumberLabel.frame = CGRectMake(MAINSCREEN.width/2, 120, MAINSCREEN.width/2-20, 20);
    self.buyNumberSelectV.frame = CGRectMake(MAINSCREEN.width - 130, 165, 110, 30);
}

- (void)setdatatoViews:(BuyCXWYUserInfo *)buyCXWYUserInfo{
    
    self.nameLabel.text = buyCXWYUserInfo.userName;
    self.phoneLabel.text = buyCXWYUserInfo.userPhone;
    self.platNumberLabel.text = buyCXWYUserInfo.userPlatnumber;
    self.buyNumberSelectV.limitNumberStr = @"7";
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

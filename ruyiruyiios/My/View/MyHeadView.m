//
//  MyHeadView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/7.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "MyHeadView.h"
#import <UIImageView+WebCache.h>

@implementation MyHeadView

- (UIImageView *)backImageV{
    
    if (_backImageV == nil) {
        
        _backImageV = [[UIImageView alloc] init];
        _backImageV.image = [UIImage imageNamed:@"ic_ground"];
    }
    return _backImageV;
}

- (UIImageView *)headPortraitImageV{
    
    if (_headPortraitImageV == nil) {
        
        _headPortraitImageV = [[UIImageView alloc] init];
        _headPortraitImageV.layer.cornerRadius = 25.0;
        _headPortraitImageV.layer.masksToBounds = YES;
    }
    return _headPortraitImageV;
}

- (UILabel *)nameLabel{
    
    if (_nameLabel == nil) {
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

- (UIButton *)nameAndHeadBtn{
    
    if (_nameAndHeadBtn == nil) {
        
        _nameAndHeadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _nameAndHeadBtn.backgroundColor = [UIColor blackColor];
    }
    return _nameAndHeadBtn;
}

- (UILabel *)myQuotaLabel{
    
    if (_myQuotaLabel == nil) {
        
        _myQuotaLabel = [[UILabel alloc] init];
        _myQuotaLabel.textAlignment = NSTextAlignmentCenter;
        _myQuotaLabel.textColor = TEXTCOLOR64;
        _myQuotaLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
    }
    return _myQuotaLabel;
}

- (UILabel *)creditLineLabel{
    
    if (_creditLineLabel == nil) {
        
        _creditLineLabel = [[UILabel alloc] init];
        _creditLineLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _creditLineLabel.textColor = TEXTCOLOR64;
        _creditLineLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _creditLineLabel;
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
    
    NSArray *nameArray = @[@"我的额度", @"信用额度"];
    for (int i = 0; i<nameArray.count; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0+(MAINSCREEN.width/2)*i, 155, MAINSCREEN.width/2, 20);
        label.font = [UIFont fontWithName:TEXTFONT size:14.0];
        label.text = nameArray[i];
        label.textColor = TEXTCOLOR64;
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
    }
    UIView *midView = [[UIView alloc] initWithFrame:CGRectMake(MAINSCREEN.width/2, 140, 0.5, 70)];
    midView.backgroundColor = [PublicClass colorWithHexString:@"#ececec"];
    [self addSubview:midView];
    
    UIView *underLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 210, MAINSCREEN.width, 5)];
    underLineView.backgroundColor = [PublicClass colorWithHexString:@"#ececec"];
    [self addSubview:underLineView];
}

- (void)addChangeView{
    
    [self addSubview:self.backImageV];
    [self addSubview:self.headPortraitImageV];
    [self addSubview:self.nameLabel];
    [self addSubview:self.nameAndHeadBtn];
    [self addSubview:self.myQuotaLabel];
    [self addSubview:self.creditLineLabel];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.backImageV.frame = CGRectMake(0, 0, MAINSCREEN.width, 140);
    self.headPortraitImageV.frame = CGRectMake(MAINSCREEN.width/2 - 50/2, 40, 50, 50);
    self.nameLabel.frame = CGRectMake(0, 100, MAINSCREEN.width, 20);
    self.nameAndHeadBtn.frame = CGRectMake(self.headPortraitImageV.frame.origin.x, 40, self.headPortraitImageV.frame.size.width, 80);
    self.myQuotaLabel.frame = CGRectMake(0, 180, MAINSCREEN.width/2, 20);
    self.creditLineLabel.frame = CGRectMake(MAINSCREEN.width/2, 180, MAINSCREEN.width/2, 20);
}

- (void)setDatatoHeadView:(NSString *)myQuotaStr creditLine:(NSString *)creditLineStr{
    
    [self.headPortraitImageV sd_setImageWithURL:[NSURL URLWithString:[UserConfig headimgurl]]];
    self.nameLabel.text = [UserConfig nick];
    self.myQuotaLabel.text = myQuotaStr;
    self.creditLineLabel.text = creditLineStr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

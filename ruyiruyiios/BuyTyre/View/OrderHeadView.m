//
//  OrderHeadView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/5.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "OrderHeadView.h"

@implementation OrderHeadView

- (UILabel *)nameLabel{
    
    if (_nameLabel == nil) {
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _nameLabel.textAlignment = NSTextAlignmentRight;
        _nameLabel.textColor = [UIColor lightGrayColor];
    }
    return _nameLabel;
}

- (UILabel *)telephoneLabel{
    
    if (_telephoneLabel == nil) {
        
        _telephoneLabel = [[UILabel alloc] init];
        _telephoneLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _telephoneLabel.textAlignment = NSTextAlignmentRight;
        _telephoneLabel.textColor = [UIColor lightGrayColor];
    }
    return _telephoneLabel;
}

- (UILabel *)platNumberLabel{
    
    if (_platNumberLabel == nil) {
        
        _platNumberLabel = [[UILabel alloc] init];
        _platNumberLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _platNumberLabel.textAlignment = NSTextAlignmentRight;
        _platNumberLabel.textColor = [UIColor lightGrayColor];
    }
    return _platNumberLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        NSArray *nameArray = @[@"联系人", @"联系电话", @"车牌号码"];
        for (int i = 0; i<3; i++) {
            
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(20, 15 + i*35, MAINSCREEN.width/2 - 20, 20);
            label.textColor = TEXTCOLOR64;
            label.font = [UIFont fontWithName:TEXTFONT size:16.0];
            label.text = [nameArray objectAtIndex:i];
            [self addSubview:label];
        }
        [self addView];
    }
    return self;
}

- (void)addView{
    
    [self addSubview:self.nameLabel];
    [self addSubview:self.telephoneLabel];
    [self addSubview:self.platNumberLabel];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.nameLabel.frame = CGRectMake(MAINSCREEN.width/2, 15, MAINSCREEN.width/2 - 20, 20);
    self.telephoneLabel.frame = CGRectMake(MAINSCREEN.width/2, 50, MAINSCREEN.width/2 - 20, 20);
    self.platNumberLabel.frame = CGRectMake(MAINSCREEN.width/2, 85, MAINSCREEN.width/2 - 20, 20);
}

- (void)setHeadViewData:(BuyTireData *)buyTireData{
    
    NSLog(@"%@", buyTireData.userName);
    self.nameLabel.text = buyTireData.userName;
    self.telephoneLabel.text = buyTireData.userPhone;
    self.platNumberLabel.text = buyTireData.platNumber;
    NSLog(@"%@", self.nameLabel.text);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

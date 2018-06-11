//
//  FirstUpdateCollectionViewCell.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/11.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "FirstUpdateCollectionViewCell.h"

@implementation FirstUpdateCollectionViewCell

- (UIButton *)functionBtn{
    
    if (_functionBtn == nil) {
        
        _functionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _functionBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _functionBtn.layer.cornerRadius = 4.0;
        _functionBtn.layer.masksToBounds = YES;
        _functionBtn.layer.borderWidth = 1.0;
    }
    return _functionBtn;
}

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.functionBtn];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.functionBtn.frame = CGRectMake(0, 0, 64, 20);
}

- (void)setDatatoBtn:(StoreServiceInfo *)serviceInfo{
    
    [self.functionBtn setTitle:serviceInfo.name forState:UIControlStateNormal];
    [self.functionBtn setTitleColor:[PublicClass colorWithHexString:serviceInfo.color] forState:UIControlStateNormal];
    self.functionBtn.layer.borderColor = [[PublicClass colorWithHexString:serviceInfo.color] CGColor];
}

@end

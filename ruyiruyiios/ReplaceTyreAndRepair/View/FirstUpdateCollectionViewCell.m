//
//  FirstUpdateCollectionViewCell.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/11.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "FirstUpdateCollectionViewCell.h"

@implementation FirstUpdateCollectionViewCell

- (UILabel *)functionLabel{
    
    if (_functionLabel == nil) {
        
        _functionLabel = [[UILabel alloc] init];
        _functionLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _functionLabel.layer.cornerRadius = 4.0;
        _functionLabel.layer.masksToBounds = YES;
        _functionLabel.layer.borderWidth = 1.0;
        _functionLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _functionLabel;
}

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.functionLabel];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.functionLabel.frame = self.bounds;
}

- (void)setDatatoBtn:(StoreServiceInfo *)serviceInfo{
    
    self.functionLabel.text = serviceInfo.name;
    self.functionLabel.textColor = [PublicClass colorWithHexString:serviceInfo.color];
    self.functionLabel.layer.borderColor = [[PublicClass colorWithHexString:serviceInfo.color] CGColor];
}

@end

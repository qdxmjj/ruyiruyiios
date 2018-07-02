//
//  MyEvaluateCollectionViewCell.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/26.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "MyEvaluateCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@implementation MyEvaluateCollectionViewCell

- (UIImageView *)imgview{
    
    if (_imgview == nil) {
        
        _imgview = [[UIImageView alloc] init];
    }
    return _imgview;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.imgview];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.imgview.frame = CGRectMake(0, 0, (MAINSCREEN.width - 80)/5, 60);
}

- (void)setdatatoCollectionCell:(NSString *)imgStr{
    
    [self.imgview sd_setImageWithURL:[NSURL URLWithString:imgStr]];
}

@end

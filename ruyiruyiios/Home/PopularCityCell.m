//
//  PopularCityCell.m
//  ruyiruyiios
//
//  Created by 姚永敏 on 2018/10/24.
//  Copyright © 2018 ruyiruyi. All rights reserved.
//

#import "PopularCityCell.h"

@implementation PopularCityCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.cityNameLab];
    }
    return self;
}

-(UILabel *)cityNameLab{
    
    if (!_cityNameLab) {
        
        _cityNameLab = [[UILabel alloc] initWithFrame:self.contentView.frame];
        _cityNameLab.textAlignment = NSTextAlignmentCenter;
        _cityNameLab.backgroundColor = [UIColor colorWithRed:240.f/255.f green:240.f/255.f blue:240.f/255.f alpha:1.f];
        CAShapeLayer *dottedLineBorder  = [[CAShapeLayer alloc] init];
        dottedLineBorder.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
        [dottedLineBorder setLineWidth:2];
        [dottedLineBorder setStrokeColor:[UIColor colorWithRed:220.f/255.f green:220.f/255.f blue:220.f/255.f alpha:1.f].CGColor];
        [dottedLineBorder setFillColor:[UIColor clearColor].CGColor];
//        dottedLineBorder.lineDashPattern = @[@10,@20];//10 - 线段长度 ，20 － 线段与线段间距
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:dottedLineBorder.frame];
        dottedLineBorder.path = path.CGPath;
        [_cityNameLab.layer addSublayer:dottedLineBorder];

    }
    return _cityNameLab;
}

@end

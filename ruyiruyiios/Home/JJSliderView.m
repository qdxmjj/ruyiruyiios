//
//  JJSliderView.m
//  ThreadTest+
//
//  Created by 小马驾驾 on 2018/8/1.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "JJSliderView.h"
#import <Masonry.h>
@interface JJSliderView ()

@property(nonatomic,strong)UISlider *slider;

@property(nonatomic,strong)UILabel *label;

@end

@implementation JJSliderView

-(instancetype)init{
    
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];

    if (self) {
        
        self.minimum = 0.f;
        self.maximum = 10.f;
        self.value = 0.f;
        self.thumbImage = [UIImage imageNamed:@"ic_xiaoyuan"];
        [self addSubview:self.slider];
        [self addSubview:self.label];
        
        [self setSubViewFrame];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        self.minimum = 0.f;
        self.maximum = 10.f;
        self.value = 0.f;
        self.thumbImage = [UIImage imageNamed:@"ic_xiaoyuan"];
        [self addSubview:self.slider];
        [self addSubview:self.label];
        
        [self setSubViewFrame];
    }
    return self;
}


-(void)setSubViewFrame{

    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.leading.and.trailing.mas_equalTo(self).inset(20);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.5);
        make.bottom.mas_equalTo(self.mas_bottom).inset(5);
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.slider.mas_left);
        make.height.mas_equalTo(@14);// 字体12 高度大约为14 差值约为 2
        make.width.mas_equalTo(@20);
        make.bottom.mas_equalTo(self.slider.mas_top).inset(3);
    }];
}

-(void)sliderValueChangedEvent:(UISlider *)slider{
    
    self.label.text = [NSString stringWithFormat:@"%.0f年",slider.value];
    [self.label sizeToFit];//立即修改更改size

    if (self.maximum == 0.f) {
        
        //防止  宽度 * 0  出现的异常报错
        return;
    }
    
    //可能slider嵌套，求出slider在最外层的frame
    CGRect trackRect = [slider convertRect:slider.bounds toView:nil];
    //得到滑块的frame
    CGRect thumbRect = [slider thumbRectForBounds:slider.bounds trackRect:trackRect value:slider.value];
    
    //两种写法
    //    CGRect rect = self.label.frame;
    //    rect.origin.x = (thumbRect.origin.x) - ceil(CGRectGetWidth(self.label.frame) / 2) ;
    //    self.label.frame = rect;
    
    //第二种
    CGPoint point = self.label.center;
    
    point.x = thumbRect.origin.x;

    self.label.center = point;
}

-(CGFloat )currentValue{
    
    return self.slider.value;
}
-(NSString *)currentValueStr{
    
    NSString *string = [self.label.text stringByReplacingOccurrencesOfString:@"年" withString:@""];
    return string;
}

-(void)setMaximum:(CGFloat)maximum{
    _maximum = maximum;
    
    self.slider.maximumValue = maximum;
}

-(void)setMinimum:(CGFloat)minimum{
    _minimum = minimum;
    
    self.slider.minimumValue = minimum;
}

-(void)setValue:(CGFloat)value{
    _value = value;
    
    self.slider.value = value;
}

-(void)setThumbImage:(UIImage *)thumbImage{
    _thumbImage = thumbImage;
    
    [self.slider setThumbImage:self.thumbImage forState:UIControlStateNormal];
}

-(UISlider *)slider{
    
    if (!_slider) {
        
        _slider = [[UISlider alloc] init];
        _slider.maximumTrackTintColor = [UIColor colorWithRed:240.f/255.f green:240.f/255.f blue:240.f/255.f alpha:1.f];
        
        _slider.minimumTrackTintColor = [UIColor colorWithRed:255.0/255 green:102.0/255 blue:35.0/255 alpha:1.0];
        _slider.minimumValue = self.minimum;
        _slider.maximumValue = self.maximum;
        _slider.value        = self.value;
        
        [_slider setThumbImage:self.thumbImage forState:UIControlStateNormal];
        [_slider addTarget:self action:@selector(sliderValueChangedEvent:) forControlEvents:UIControlEventValueChanged];
    }
    return _slider;
}

-(UILabel *)label{
    
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.backgroundColor = [UIColor colorWithRed:255.0/255 green:102.0/255 blue:35.0/255 alpha:1.0];
        _label.textColor = [UIColor whiteColor];
        _label.layer.masksToBounds = YES;
        _label.layer.cornerRadius = 3;
        _label.text = [NSString stringWithFormat:@"0年"];
        _label.font = [UIFont systemFontOfSize:12.f];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

@end

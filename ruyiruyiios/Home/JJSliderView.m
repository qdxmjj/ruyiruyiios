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
        
        self.miniNum = 0.f;
        self.maxiNum = 10.f;
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
        
        make.centerX.mas_equalTo(self.slider.mas_leading);
        make.top.mas_equalTo(self.mas_top);
        make.height.mas_equalTo(@15);
        make.width.mas_equalTo(35);
    }];
    
    [self layoutIfNeeded];
}

-(void)sliderValueChangedEvent:(UISlider *)slider{
    
    self.label.text = [NSString stringWithFormat:@"%.0f年",slider.value];
//    CGSize sizeNew = [self.label.text sizeWithAttributes:@{NSFontAttributeName:self.label.font}];
//    self.label.frame = CGRectMake(0, 0, sizeNew.width, self.frame.size.height/2);
    
    if (self.maxiNum == 0.f) {
        
        return;
    }
    
    
   __block CGFloat changedLength = ( slider.value / self.maxiNum )  * self.slider.frame.size.width ;
    
    [self.label mas_updateConstraints:^(MASConstraintMaker *make) {
        
//        make.centerX.mas_equalTo(self.slider.mas_leading).offset(slider.value * changedLength);
        
        make.centerX.mas_equalTo(self.slider.mas_leading).offset(changedLength);
    }];
}

-(CGFloat )currentValue{
    
    return self.slider.value;
}
-(NSString *)currentValueStr{
    
    NSString *string = [self.label.text stringByReplacingOccurrencesOfString:@"年" withString:@""];
    
    return string;
}

-(void)setMaxiNum:(CGFloat)maxiNum{
    _maxiNum = maxiNum;
    
    self.slider.maximumValue = maxiNum;
}

-(void)setMiniNum:(CGFloat)miniNum{
    _miniNum = miniNum;
    
    self.slider.minimumValue = miniNum;
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
//        _slider.transform = CGAffineTransformMakeScale(1.f, 6.f);
        
        _slider.maximumTrackTintColor = [UIColor colorWithRed:240.f/255.f green:240.f/255.f blue:240.f/255.f alpha:1.f];
        _slider.minimumTrackTintColor = LOGINBACKCOLOR;
        _slider.minimumValue = self.miniNum;
        _slider.maximumValue = self.maxiNum;
        _slider.value        = self.value;
        
        [_slider setThumbImage:self.thumbImage forState:UIControlStateNormal];
        [_slider addTarget:self action:@selector(sliderValueChangedEvent:) forControlEvents:UIControlEventValueChanged];
    }
    return _slider;
}

-(UILabel *)label{
    
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.backgroundColor = LOGINBACKCOLOR;
        _label.textColor = [UIColor whiteColor];
        _label.layer.masksToBounds = YES;
        _label.layer.cornerRadius = 3;
        _label.text = [NSString stringWithFormat:@"0年"];
        _label.font = [UIFont systemFontOfSize:14.f];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

@end

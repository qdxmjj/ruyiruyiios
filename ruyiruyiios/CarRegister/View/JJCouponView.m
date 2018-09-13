//
//  JJCouponView.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/9/12.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "JJCouponView.h"
#import <Masonry.h>
@interface JJCouponView ()

@property(nonatomic,strong)UIImageView *imgView;

@property(nonatomic,strong)UIButton *determineBtn;
@end
@implementation JJCouponView

#pragma mark - Action
-(void)show {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.imgView.transform = CGAffineTransformMakeScale(0.7, 0.7);
    // 弹簧动画，参数分别为：时长，延时，弹性（越小弹性越大），初始速度
    [UIView animateWithDuration: 0.7 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.3 options:0 animations:^{
        // 放大
        self.imgView.transform = CGAffineTransformMakeScale(1, 1);
    } completion:nil];
}
-(void)dismiss {
    
    [UIView animateWithDuration:.3 animations:^{
        
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self removeFromSuperview];
    }];
}
-(void)setImgName:(NSString *)imgName{
    

    self.imgView.image = [UIImage imageNamed:imgName];
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];

        [self addSubview:self.imgView];
        
        [self.imgView addSubview:self.determineBtn];
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.and.height.mas_equalTo(CGSizeMake(232, 249));
        }];
        
        [self.determineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.bottom.mas_equalTo(self.imgView.mas_bottom);
            make.width.and.height.mas_equalTo(CGSizeMake(240, 40));
            make.centerX.mas_equalTo(self.imgView.mas_centerX);
        }];
        
    }
    return self;
}

-(void)jj_popViewController{
    
    [self dismiss];
    self.popBlock();
}

-(UIImageView *)imgView{
    
    if (!_imgView) {
        
        _imgView = [[UIImageView alloc] init];
        _imgView.contentMode = UIViewContentModeCenter;
        _imgView.userInteractionEnabled = YES;
        _imgView.image = [UIImage imageNamed:@"ic_cxwytanchuang"];
    }
    
    return _imgView;
}


-(UIButton *)determineBtn{
    
    if (!_determineBtn) {
        
        _determineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_determineBtn setImage:[UIImage imageNamed:@"ic_tcbutton"] forState:UIControlStateNormal];
        [_determineBtn addTarget:self action:@selector(jj_popViewController) forControlEvents:UIControlEventTouchUpInside];
    }
    return _determineBtn;
}

@end

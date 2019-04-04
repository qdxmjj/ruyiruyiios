//
//  TabbarView.m
//  TestCommodityInfo
//
//  Created by 小马驾驾 on 2018/5/30.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "TabbarView.h"
#import "UIView+extension.h"
#import "UIButton+Subscript.h"
@interface TabbarView ()

@property(nonatomic,strong)UIView *sliderView;//滑块

@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIButton *btn3;
@property (nonatomic, strong) UIButton *btn4;

@end
@implementation TabbarView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];

        self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(3, 3);
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowRadius = 5;
        
        [self addSubview:self.sliderView];

        NSArray *titleArr = @[@"汽车保养",@"美容清洗",@"安装改装",@"轮胎服务"];
        
        for (int i=0; i<=3; i++) {
            
            UIButton *tabbarBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [tabbarBtn setTitle:titleArr[i] forState:UIControlStateNormal];
            [tabbarBtn.titleLabel setFont:[UIFont systemFontOfSize:15.f]];
            [tabbarBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [tabbarBtn setBadgeValue:0];
            
//            if (i==0) {
                tabbarBtn.tag = 100100+i;
//            }
            [tabbarBtn addTarget:self action:@selector(topBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:tabbarBtn];
            
            switch (i) {
                case 0:
                    self.btn1 = tabbarBtn;
                    break;
                case 1:
                    self.btn2 =tabbarBtn;
                    break;
                case 2:
                    self.btn3 = tabbarBtn;
                    break;
                case 3:
                    self.btn4 = tabbarBtn;
                    break;
                    
                default:
                    break;
            }
        }
    }
    return self;
}

- (void)layoutSubviews{
    
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.mas_equalTo(self.mas_leading);
        make.top.mas_equalTo(self.mas_top);
        make.width.mas_equalTo(self.frame.size.width/4);
        make.height.mas_equalTo(self.frame.size.height-2);
    }];
    [self.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.mas_equalTo(self.btn1.mas_trailing);
        make.top.mas_equalTo(self.mas_top);
        make.width.mas_equalTo(self.frame.size.width/4);
        make.height.mas_equalTo(self.frame.size.height-2);
    }];
    [self.btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.mas_equalTo(self.btn2.mas_trailing);
        make.top.mas_equalTo(self.mas_top);
        make.width.mas_equalTo(self.frame.size.width/4);
        make.height.mas_equalTo(self.frame.size.height-2);
    }];
    [self.btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.mas_equalTo(self.btn3.mas_trailing);
        make.top.mas_equalTo(self.mas_top);
        make.width.mas_equalTo(self.frame.size.width/4);
        make.height.mas_equalTo(self.frame.size.height-2);
    }];
    
    [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.leading.mas_equalTo(self.mas_leading).inset(10);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.height.mas_equalTo(2);
        make.width.mas_equalTo(self.frame.size.width/4-20);
    }];
    
    [self layoutIfNeeded];
}

-(void)changeBadgeNumberWithButton:(NSInteger )buttonTag status:(BOOL)badgeStatus{
    
    UIButton *btn = [self viewWithTag:100100+buttonTag];

    btn.badgeLable.hidden = NO;
    
    NSInteger number = [btn.badgeLable.text integerValue];
    
    switch (buttonTag) {
        case 0:
            
            if (badgeStatus) {
                
                number ++;
                btn.badgeLable.text = [NSString stringWithFormat:@"%ld",number];
            }else{
                
                number --;
                
                btn.badgeLable.text = [NSString stringWithFormat:@"%ld",number];
                if (number==0) {
                    
                    btn.badgeLable.hidden = YES;
                    return;
                }
            }
            break;
        case 1:
            
            if (badgeStatus) {
                
                number ++;
                btn.badgeLable.text = [NSString stringWithFormat:@"%ld",number];
            }else{
                
                number --;
                btn.badgeLable.text = [NSString stringWithFormat:@"%ld",number];
                if (number==0) {
                    
                    btn.badgeLable.hidden = YES;
                    return;
                }
            }
            
            break;
        case 2:
            
            if (badgeStatus) {
                
                number ++;
                btn.badgeLable.text = [NSString stringWithFormat:@"%ld",number];
            }else{
                
                number --;
                btn.badgeLable.text = [NSString stringWithFormat:@"%ld",number];
                if (number==0) {
                    
                    btn.badgeLable.hidden = YES;
                    return;
                }
            }
            break;
        case 3:
            
            if (badgeStatus) {
                
                number ++;
                btn.badgeLable.text = [NSString stringWithFormat:@"%ld",number];
            }else{
                
                number --;
                btn.badgeLable.text = [NSString stringWithFormat:@"%ld",number];
                if (number==0) {
                    
                    btn.badgeLable.hidden = YES;
                    return;
                }
            }
            
            break;
            
        default:
            break;
    }
}

-(void)emptyBadgeNumer{
    
    for (int i = 0; i<=3; i++) {
        
        UIButton *btn = [self viewWithTag:100100+i];
        
        btn.badgeLable.hidden = YES;
        btn.badgeLable.text = @"0";
    }
}

-(void)topBtnPressed:(UIButton *)sender{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.sliderView.x = sender.x+10;

    }];
    
    NSInteger row = 0 ;
    
    if ([sender.titleLabel.text isEqualToString:@"汽车保养"]) {
        row = 0;
    }
    if ([sender.titleLabel.text isEqualToString:@"美容清洗"]) {
        row = 1;
    }
    if ([sender.titleLabel.text isEqualToString:@"安装改装"]) {
        row = 2;
    }
    if ([sender.titleLabel.text isEqualToString:@"轮胎服务"]) {
        row = 3;
    }
    
   self.serviceBlcok(row);
}



-(UIView *)sliderView{
    
    if (_sliderView==nil) {
        
        _sliderView = [[UIView alloc] init];
        _sliderView.backgroundColor=[UIColor colorWithRed:255.f/255.f green:102.f/255.0 blue:35.f/255.0 alpha:1];
    }
    return _sliderView;
}
@end

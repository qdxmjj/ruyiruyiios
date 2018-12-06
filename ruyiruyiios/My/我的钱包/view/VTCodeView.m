//
//  VTCodeView.m
//  ruyiRuyi
//
//  Created by 姚永敏 on 2018/10/16.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "VTCodeView.h"
#import "MQVerCodeInputView.h"
#import <Masonry.h>
#import "JJRequest.h"
#import "MBProgressHUD+YYM_category.h"
@interface VTCodeView ()

@property(nonatomic,strong)UIView *mainView;

@property(nonatomic,strong)UILabel *vtCodeLab;

@property(nonatomic,strong)UILabel *phoneTextLab;

@property(nonatomic,strong)MQVerCodeInputView *vtTextField;

@property(nonatomic,strong)UIButton *timeButton;

@property(nonatomic,strong)UIButton *closeBtn;

@property(nonatomic,assign)NSInteger time;

@property(nonatomic,strong)NSTimer *timer;
@end
@implementation VTCodeView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.6f];

        
        [self addSubview:self.mainView];

        MQVerCodeInputView *verView = [[MQVerCodeInputView alloc] init];
        verView.maxLenght = 6;//最大长度
        verView.keyBoardType = UIKeyboardTypeNumberPad;
        [verView mq_verCodeViewWithMaxLenght];
        
        verView.block = ^(NSString *text){
            
            if (text.length>=6) {

                [JJRequest postRequest:@"/verificationCode" params:@{@"reqJson":[PublicClass convertToJsonData:@{@"phone":[UserConfig phone],@"code":text}]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
                    
                    if ([code longLongValue] == 1 || [code longLongValue] == 111111) {
                        
                        [MBProgressHUD showTextMessage:@"验证验证码成功！"];
                        self.block(YES);
                        [self dismiss];
                    }else{
                        [MBProgressHUD showTextMessage:@"验证验证码失败！"];
                    }
                } failure:^(NSError * _Nullable error) {
                }];
            }
        };
        
        [self.mainView addSubview:self.closeBtn];
        [self.mainView addSubview:verView];
        [self.mainView addSubview:self.vtCodeLab];
        [self.mainView addSubview:self.phoneTextLab];
        [self.mainView addSubview:self.timeButton];
        self.vtTextField = verView;
        
        [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.and.height.mas_equalTo(CGSizeMake(self.frame.size.width-40,(self.frame.size.width-20)*0.7));
        }];
        [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.mas_equalTo(self.mainView.mas_right);
            make.width.height.mas_equalTo(CGSizeMake(40, 40));
            make.top.mas_equalTo(self.mainView.mas_top).inset(5);
            
        }];
        
        [verView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.center.mas_equalTo(self.mainView.center);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(self.mainView.mas_width);
        }];
        
        [self.phoneTextLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.mas_equalTo(verView.mas_top).inset(15);
            make.centerX.mas_equalTo(self.mainView.mas_centerX);
            make.width.mas_equalTo(self.mainView.mas_width);
            make.height.mas_equalTo(@25);
        }];
        
        [self.vtCodeLab mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.bottom.mas_equalTo(self.phoneTextLab.mas_top).inset(20);
            make.centerX.mas_equalTo(self.mainView.mas_centerX);
            make.width.mas_equalTo(self.mainView.mas_width);
            make.height.mas_equalTo(@25);
        }];
        
        [self.timeButton mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.bottom.mas_equalTo(self.mainView.mas_bottom).inset(5);
            make.centerX.mas_equalTo(self.mainView.mas_centerX);
            make.width.mas_equalTo(self.mainView.mas_width);
            make.height.mas_equalTo(@20);
        }];
        
        [self.timeButton sendActionsForControlEvents:UIControlEventTouchUpInside];

    }
    return self;
}


-(void)getCodeEvent:(UIButton *)sender{
    
    sender.enabled = NO;
    
    self.time = 59;
    
    [sender setTitleColor:[UIColor colorWithRed:150.f/255.f green:150.f/255.f blue:150.f/255.f alpha:1.f] forState:UIControlStateNormal];

    [self.timeButton setTitle:[NSString stringWithFormat:@"%ld秒后重新获取",(long)self.time] forState:UIControlStateNormal];

    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdownEvent:) userInfo:nil repeats:YES];;
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    [JJRequest postRequest:@"/sendMsgWithoutLimit" params:@{@"reqJson":[PublicClass convertToJsonData:@{@"phone":[UserConfig phone]}]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if ([code longLongValue] == 1) {
            
            [MBProgressHUD showTextMessage:@"发送验证码成功"];
        }else{
            [MBProgressHUD showTextMessage:@"发送验证码失败"];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

-(void)countdownEvent:(NSTimer *)timer{
    
    self.time--;
    
    if (self.time <=0) {
        
        self.timeButton.enabled = YES;
        
        [timer invalidate];
        
        timer = nil;
        
        self.time = 59;
        
        [self.timeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.timeButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        return;
    }
    [self.timeButton setTitle:[NSString stringWithFormat:@"%ld秒后重新获取",(long)self.time] forState:UIControlStateNormal];
}

#pragma mark - Action
-(void)showWithSuperView:(UIView *)view{
    
    [view addSubview:self];
    
    self.mainView.transform = CGAffineTransformMakeScale(0.7, 0.7);
    
    // 弹簧动画，参数分别为：时长，延时，弹性（越小弹性越大），初始速度
    [UIView animateWithDuration: 0.7 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.3 options:0 animations:^{
        // 放大
        self.mainView.transform = CGAffineTransformMakeScale(1, 1);
    } completion:nil];
    
}

-(void)dismiss {
    
    [UIView animateWithDuration:.3 animations:^{

        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
        [self.timer invalidate];
        
        self.timer = nil;
        
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self removeFromSuperview];
    }];
}

-(UIView *)mainView{
    
    if (!_mainView) {
        
        _mainView = [[UIView alloc] init];
        _mainView.backgroundColor = [UIColor whiteColor];
        _mainView.layer.cornerRadius = 3;
        _mainView.layer.masksToBounds = true;
    }
    return _mainView;
}

-(UIButton *)closeBtn{
    
    if (!_closeBtn) {
        
        _closeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_closeBtn setTitle:@"×" forState:UIControlStateNormal];
        [_closeBtn setTitleColor:[UIColor colorWithRed:150.f/255.f green:150.f/255.f blue:150.f/255.f alpha:1.f] forState:UIControlStateNormal];
        [_closeBtn.titleLabel setFont:[UIFont systemFontOfSize:40.f]];
        [_closeBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _closeBtn;
}
-(UILabel *)vtCodeLab{
    
    if (!_vtCodeLab) {
        
        _vtCodeLab = [[UILabel alloc] init];
        _vtCodeLab.text = @"输入验证码";
        _vtCodeLab.font = [UIFont systemFontOfSize:19.f];
        _vtCodeLab.textAlignment = NSTextAlignmentCenter;
    }
    return _vtCodeLab;
}

-(UILabel *)phoneTextLab{
    
    if (!_phoneTextLab) {
        
        _phoneTextLab = [[UILabel alloc] init];
        _phoneTextLab.text = [NSString stringWithFormat:@"短信验证码已发送至 +86 %@",[UserConfig phone]];
        _phoneTextLab.font = [UIFont systemFontOfSize:13.f];
        _phoneTextLab.textColor = [UIColor colorWithRed:150.f/255.f green:150.f/255.f blue:150.f/255.f alpha:1.f];
        _phoneTextLab.textAlignment = NSTextAlignmentCenter;

    }
    return _phoneTextLab;
}

-(UIButton *)timeButton{
    
    if (!_timeButton) {
        
        _timeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_timeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_timeButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_timeButton addTarget:self action:@selector(getCodeEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _timeButton;
}
@end

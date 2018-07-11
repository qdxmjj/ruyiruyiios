//
//  CouponLeftView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/20.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "CouponLeftView.h"

@implementation CouponLeftView

- (UIImageView *)backImageV{
    
    if (_backImageV == nil) {
        
        _backImageV = [[UIImageView alloc] init];
    }
    return _backImageV;
}

- (UILabel *)titleLabel{
    
    if (_titleLabel == nil) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIView *)midView{
    
    if (_midView == nil) {
        
        _midView = [[UIView alloc] init];
    }
    return _midView;
}

- (UILabel *)useStateLabel{
    
    if (_useStateLabel == nil) {
        
        _useStateLabel = [[UILabel alloc] init];
        _useStateLabel.textColor = [UIColor whiteColor];
        _useStateLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _useStateLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _useStateLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.backImageV];
        [self addSubview:self.titleLabel];
        [self addSubview:self.midView];
        [self addSubview:self.useStateLabel];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.backImageV.frame = CGRectMake(0, 0, self.frame.size.width, 120);
    self.titleLabel.frame = CGRectMake(0, 20, self.backImageV.frame.size.width, 20);
    self.midView.frame = CGRectMake(15, 80, self.backImageV.frame.size.width - 30, 2);
    self.useStateLabel.frame = CGRectMake(0, 90, self.backImageV.frame.size.width, 20);
}

- (void)setdatatoViews:(CouponInfo *)counponInfo couponType:(NSString *)couponTypeStr{
    
    self.titleLabel.text = counponInfo.couponName;
    self.midView.backgroundColor = [UIColor whiteColor];
//    NSLog(@"%@", counponInfo.type);
    if ([counponInfo.status isEqualToNumber:[NSNumber numberWithInt:1]]) {
        
        self.useStateLabel.text = @"已使用";
        self.backImageV.image = [UIImage imageNamed:@"ic_huise"];
    }else if ([counponInfo.status isEqualToNumber:[NSNumber numberWithInt:2]]){
        
        self.useStateLabel.text = @"未使用";
//        NSLog(@"%@-----%@", counponInfo.userCarId, [UserConfig userCarId]);
        if ([counponInfo.userCarId integerValue] == [[UserConfig userCarId] integerValue]) {
            
            if ([counponInfo.type intValue] == 1) {
                
                if ([couponTypeStr isEqualToString:@"0"]) {
                    
                    self.backImageV.image = [UIImage imageNamed:@"ic_huise"];
                }else if ([couponTypeStr isEqualToString:@"1"]){
                    
                    if ([counponInfo.couponName isEqualToString:@"精致洗车券"]) {
                        
                        self.backImageV.image = [UIImage imageNamed:@"ic_blue"];
                    }else{
                        
                        self.backImageV.image = [UIImage imageNamed:@"ic_huise"];
                    }
                }else if ([couponTypeStr isEqualToString:@"2"]){
                    
                    if ([counponInfo.couponName isEqualToString:@"四轮定位券"]) {
                        
                        self.backImageV.image = [UIImage imageNamed:@"ic_blue"];
                    }else{
                        
                        self.backImageV.image = [UIImage imageNamed:@"ic_huise"];
                    }
                }else if ([couponTypeStr isEqualToString:@"3"]){
                    
                    if ([counponInfo.viewTypeId isEqualToNumber:[NSNumber numberWithInt:2]]) {
                        
                        self.backImageV.image = [UIImage imageNamed:@"ic_blue"];
                    }else{
                        
                        self.backImageV.image = [UIImage imageNamed:@"ic_red"];
                    }
                }else{
                    
                    if ([counponInfo.viewTypeId isEqualToNumber:[NSNumber numberWithInt:2]]) {
                        
                        self.backImageV.image = [UIImage imageNamed:@"ic_blue"];
                    }else{
                        
                        self.backImageV.image = [UIImage imageNamed:@"ic_red"];
                    }
                }
            }else if ([counponInfo.type intValue] == 2){
                
                if ([counponInfo.viewTypeId isEqualToNumber:[NSNumber numberWithInt:2]]) {
                    
                    self.backImageV.image = [UIImage imageNamed:@"ic_blue"];
                }else{
                    
                    self.backImageV.image = [UIImage imageNamed:@"ic_red"];
                }
            }
        }else{
            
            if ([counponInfo.type integerValue] == 2) {
                
                self.backImageV.image = [UIImage imageNamed:@"ic_red"];
            }else{
                
                self.backImageV.image = [UIImage imageNamed:@"ic_huise"];
            }
        }
    }else{
        
        self.useStateLabel.text = @"已过期";
        self.backImageV.image = [UIImage imageNamed:@"ic_huise"];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

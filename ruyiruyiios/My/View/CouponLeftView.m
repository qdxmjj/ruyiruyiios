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

- (void)setdatatoViews:(CouponInfo *)counponInfo{
    
    self.midView.backgroundColor = [UIColor whiteColor];

    if ([counponInfo.status isEqualToNumber:[NSNumber numberWithInt:1]]) {
        
        self.useStateLabel.text = @"已使用";
        self.backImageV.image = [UIImage imageNamed:@"ic_huise"];
    }else if ([counponInfo.status isEqualToNumber:[NSNumber numberWithInt:2]]){
        self.useStateLabel.text = @"未使用";
        
        NSInteger counponType = [counponInfo.type integerValue];
        
        switch (counponType) {
            case 1:
                
                self.titleLabel.text = @"服务券";
                self.backImageV.image = [UIImage imageNamed:@"ic_blue"];
                break;
            case 2:
                self.backImageV.image = [UIImage imageNamed:@"ic_red"];
                self.titleLabel.text = @"现金券";

                break;
            case 3:
                self.backImageV.image = [UIImage imageNamed:@"ic_yellow"];
                self.titleLabel.text = @"满减券";

                break;
            case 4:
                self.backImageV.image = [UIImage imageNamed:@"ic_zise"];
                self.titleLabel.text = @"小额券";

                break;
            case 5:
                self.backImageV.image = [UIImage imageNamed:@"ic_pink"];
                self.titleLabel.text = @"折扣券";

                break;
            default:
                
                self.titleLabel.text = @"未知类型";
                self.backImageV.image = [UIImage imageNamed:@"ic_green"];
                break;
        }
    }else{

        self.useStateLabel.text = @"已过期";
        self.backImageV.image = [UIImage imageNamed:@"ic_huise"];
    }
}

- (void)setdatatoViews:(CouponInfo *)counponInfo goodsNameArr:(NSArray *)goodsNameArr totalPrice:(NSString *)totalPrice storeID:(NSString *)storeID{

    self.midView.backgroundColor = [UIColor whiteColor];
    
    CGFloat totalPriceFloat = [totalPrice floatValue];

    if ([counponInfo.status isEqualToNumber:[NSNumber numberWithInt:1]]) {
        
        self.useStateLabel.text = @"已使用";
        self.backImageV.image = [UIImage imageNamed:@"ic_huise"];

    }else if ([counponInfo.status isEqualToNumber:[NSNumber numberWithInt:2]]){
        self.useStateLabel.text = @"未使用";
        
        NSInteger counponType = [counponInfo.type integerValue];
        //判断是否是指定门店 门店ID  可以指定多个门店 也就是 可以是多个门店ID
        NSArray *storeIDArr = [counponInfo.storeIdList componentsSeparatedByString:@","];
        
        switch (counponType) {
            case 1:
                if ([counponInfo.userCarId integerValue] == [[UserConfig userCarId] integerValue]) {
                    if ([counponInfo.storeIdList isEqualToString:@""] || [counponInfo.storeIdList isEqual:[NSNull null]]) {
                        
                        //服务券 判断商品名称
                        if ([goodsNameArr containsObject:counponInfo.rule]) {
                            
                            self.backImageV.image = [UIImage imageNamed:@"ic_blue"];
                        }else{
                            self.backImageV.image = [UIImage imageNamed:@"ic_huise"];
                        }
                        
                    }else{
                        if ([storeIDArr containsObject:storeID]) {
                            
                            //服务券 判断商品名称
                            if ([goodsNameArr containsObject:counponInfo.rule]) {
                                
                                self.backImageV.image = [UIImage imageNamed:@"ic_blue"];
                            }else{
                                self.backImageV.image = [UIImage imageNamed:@"ic_huise"];
                            }
                        }else{
                            
                            self.backImageV.image = [UIImage imageNamed:@"ic_huise"];
                        }
                    }
                }else{
                    self.backImageV.image = [UIImage imageNamed:@"ic_huise"];
                }
                self.titleLabel.text = @"服务券";
                break;
            case 2:
                
                self.titleLabel.text = @"现金券";
                self.backImageV.image = [UIImage imageNamed:@"ic_red"];
                break;
            case 3:
                if ([counponInfo.userCarId integerValue] == [[UserConfig userCarId] integerValue]) {
                    if ([counponInfo.storeIdList isEqualToString:@""] || [counponInfo.storeIdList isEqual:[NSNull null]]) {
                        
                        //满减券 判断是否满减
                        if (totalPriceFloat >= [counponInfo.moneyFull integerValue]) {
                            
                            self.backImageV.image = [UIImage imageNamed:@"ic_yellow"];
                        }else{
                            self.backImageV.image = [UIImage imageNamed:@"ic_huise"];
                        }
                        
                    }else{
                        if ([storeIDArr containsObject:storeID]) {
                            
                            //满减券 判断是否满减
                            if (totalPriceFloat >= [counponInfo.moneyFull integerValue]) {
                                
                                self.backImageV.image = [UIImage imageNamed:@"ic_yellow"];
                            }else{
                                self.backImageV.image = [UIImage imageNamed:@"ic_huise"];
                            }
                        }else{
                            
                            self.backImageV.image = [UIImage imageNamed:@"ic_huise"];
                        }
                    }
                }else{
                    self.backImageV.image = [UIImage imageNamed:@"ic_huise"];
                }
                self.titleLabel.text = @"满减券";

                break;
            case 4:
                //判断是否是指定车辆   type == 4 小额券  将指定商品变成小额券 的价格
                if ([counponInfo.userCarId integerValue] == [[UserConfig userCarId] integerValue]) {
                    
                    if ([counponInfo.storeIdList isEqualToString:@""] || [counponInfo.storeIdList isEqual:[NSNull null]]) {
                        
                        //小额券 判断商品名称
                        if ([goodsNameArr containsObject:counponInfo.rule]) {
                            
                            self.backImageV.image = [UIImage imageNamed:@"ic_zise"];
                        }else{
                            self.backImageV.image = [UIImage imageNamed:@"ic_huise"];
                        }
                        
                    }else{
                        if ([storeIDArr containsObject:storeID]) {
                            
                            //小额券 判断商品名称
                            if ([goodsNameArr containsObject:counponInfo.rule]) {
                                
                                self.backImageV.image = [UIImage imageNamed:@"ic_zise"];
                            }else{
                                self.backImageV.image = [UIImage imageNamed:@"ic_huise"];
                            }
                        }else{
                            
                            self.backImageV.image = [UIImage imageNamed:@"ic_huise"];
                        }
                    }
                    
                }else{
                    self.backImageV.image = [UIImage imageNamed:@"ic_huise"];
                }
                
                self.titleLabel.text = @"小额券";
                
                break;
            case 5:
                //判断是否是指定车辆   type == 5 抵扣券  对应商品 抵扣掉 对应金额
                if ([counponInfo.userCarId integerValue] == [[UserConfig userCarId] integerValue]) {
                    
                    if ([counponInfo.storeIdList isEqualToString:@""] || [counponInfo.storeIdList isEqual:[NSNull null]]) {
                        
                        //折扣券 判断商品名称
                        if ([goodsNameArr containsObject:counponInfo.rule]) {
                            
                            self.backImageV.image = [UIImage imageNamed:@"ic_pink"];
                        }else{
                            self.backImageV.image = [UIImage imageNamed:@"ic_huise"];
                        }
                        
                    }else{
                        if ([storeIDArr containsObject:storeID]) {
                            
                            //折扣券 判断商品名称
                            if ([goodsNameArr containsObject:counponInfo.rule]) {
                                
                                self.backImageV.image = [UIImage imageNamed:@"ic_pink"];
                            }else{
                                self.backImageV.image = [UIImage imageNamed:@"ic_huise"];
                            }
                        }else{
                            
                            self.backImageV.image = [UIImage imageNamed:@"ic_huise"];
                        }
                    }
                }else{
                    self.backImageV.image = [UIImage imageNamed:@"ic_huise"];
                }
                self.titleLabel.text = @"折扣券";
                break;
            default:
                
                self.titleLabel.text = @"未知类型";
                self.backImageV.image = [UIImage imageNamed:@"ic_green"];
                break;
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

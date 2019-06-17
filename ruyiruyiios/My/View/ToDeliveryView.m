//
//  ToDeliveryView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/29.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "ToDeliveryView.h"

@implementation ToDeliveryView

- (UILabel *)userNameLabel{
    
    if (_userNameLabel == nil) {
        
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _userNameLabel.textColor = [UIColor lightGrayColor];
        _userNameLabel.textAlignment = NSTextAlignmentRight;
    }
    return _userNameLabel;
}

- (UILabel *)userPhoneLabel{
    
    if (_userPhoneLabel == nil) {
        
        _userPhoneLabel = [[UILabel alloc] init];
        _userPhoneLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _userPhoneLabel.textColor = [UIColor lightGrayColor];
        _userPhoneLabel.textAlignment = NSTextAlignmentRight;
    }
    return _userPhoneLabel;
}

- (UILabel *)userPlatNumberLabel{
    
    if (_userPlatNumberLabel == nil) {
        
        _userPlatNumberLabel = [[UILabel alloc] init];
        _userPlatNumberLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _userPlatNumberLabel.textColor = [UIColor lightGrayColor];
        _userPlatNumberLabel.textAlignment = NSTextAlignmentRight;
    }
    return _userPlatNumberLabel;
}

- (UILabel *)serviceLabel{
    
    if (_serviceLabel == nil) {
        
        _serviceLabel = [[UILabel alloc] init];
        _serviceLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _serviceLabel.textColor = [UIColor lightGrayColor];
        _serviceLabel.textAlignment = NSTextAlignmentRight;
    }
    return _serviceLabel;
}

- (UILabel *)typeLabel{
    
    if (_typeLabel == nil) {
        
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _typeLabel.textColor = TEXTCOLOR64;
        _typeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _typeLabel;
}

- (UIButton *)storeNameBtn{
    
    if (_storeNameBtn == nil) {
        
        _storeNameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _storeNameBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _storeNameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_storeNameBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    return _storeNameBtn;
}

- (UIView *)underView{
    
    if (_underView == nil) {
        
        _underView = [[UIView alloc] init];
    }
    return _underView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        NSArray *nameArray = @[@"联系人", @"联系电话", @"车牌号", @"服务项目"];
        [self addUnchangeViews:nameArray];
        [self addChangeViews];
    }
    return self;
}

- (void)addUnchangeViews:(NSArray *)array{
    
    for (int i = 0; i<array.count; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 15+35*i, MAINSCREEN.width/2 - 20, 20)];
        label.text = array[i];
        label.textColor = TEXTCOLOR64;
        label.font = [UIFont fontWithName:TEXTFONT size:16.0];
        label.textAlignment = NSTextAlignmentLeft;
        [self addSubview:label];
    }
}

- (void)addChangeViews{
    
    [self addSubview:self.userNameLabel];
    [self addSubview:self.userPhoneLabel];
    [self addSubview:self.userPlatNumberLabel];
    [self addSubview:self.serviceLabel];
    [self addSubview:self.typeLabel];
    [self addSubview:self.storeNameBtn];
    [self addSubview:self.underView];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.userNameLabel.frame = CGRectMake(MAINSCREEN.width/2, 15, MAINSCREEN.width/2 - 20, 20);
    self.userPhoneLabel.frame = CGRectMake(MAINSCREEN.width/2, 50, MAINSCREEN.width/2 - 20, 20);
    self.userPlatNumberLabel.frame = CGRectMake(MAINSCREEN.width/2, 85, MAINSCREEN.width/2 - 20, 20);
    self.serviceLabel.frame = CGRectMake(MAINSCREEN.width/2, 120, MAINSCREEN.width/2 - 20, 20);
    self.typeLabel.frame = CGRectMake(20, 15+35*4, MAINSCREEN.width/2 - 20, 20);
    self.storeNameBtn.frame = CGRectMake(MAINSCREEN.width/2, 155, MAINSCREEN.width/2 - 20, 20);
    self.underView.frame = CGRectMake(0, 188, MAINSCREEN.width, 1);
}

- (void)setDatatoDeliveryViews:(FirstUpdateOrFreeChangeInfo *)firstUpdateOrFreeChaneInfo{
    
    self.userNameLabel.text = firstUpdateOrFreeChaneInfo.userName;
    self.userPhoneLabel.text = firstUpdateOrFreeChaneInfo.userPhone;
    self.userPlatNumberLabel.text = firstUpdateOrFreeChaneInfo.platNumber;
    
    if ([firstUpdateOrFreeChaneInfo.orderType longLongValue] == 8) {
        
        self.serviceLabel.text = @"续保";
    }else{
        
        if (firstUpdateOrFreeChaneInfo.firstChangeOrderVoList != NULL) {
            
            self.serviceLabel.text = @"首次更换";
        }else if (![firstUpdateOrFreeChaneInfo.shoeOrderVoList  isEqual: @[]]){
            
            self.serviceLabel.text = @"轮胎购买";
        }else if (![firstUpdateOrFreeChaneInfo.stockOrderVoList  isEqual: @[]]){
            
            self.serviceLabel.text = @"普通商品购买";
        }else if (firstUpdateOrFreeChaneInfo.freeChangeOrderVoList != NULL){
            
            self.serviceLabel.text = @"免费再换";
        }else{
            
            self.serviceLabel.text = @"免费再换";
        }
    }
    if ([self.serviceLabel.text isEqualToString:@"轮胎购买"]) {
        
        NSString *nameStr = [NSString stringWithFormat:@"¥ %@", firstUpdateOrFreeChaneInfo.orderTotalPrice];
        [self.storeNameBtn setTitle:nameStr forState:UIControlStateNormal];
        self.storeNameBtn.enabled = NO;
        self.typeLabel.text = @"订单总价";
    }else{
        
        [self.storeNameBtn setTitle:firstUpdateOrFreeChaneInfo.storeName forState:UIControlStateNormal];
        [self.storeNameBtn setImage:[UIImage imageNamed:@"ic_right"] forState:UIControlStateNormal];
        [self.storeNameBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
        [self.storeNameBtn setImageEdgeInsets:UIEdgeInsetsMake(0, MAINSCREEN.width/2-20-10, 0, 0)];
        self.typeLabel.text = @"店铺名称";
    }
    self.underView.backgroundColor = [PublicClass colorWithHexString:@"#ececec"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

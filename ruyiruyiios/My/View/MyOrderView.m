//
//  MyOrderView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/7.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "MyOrderView.h"

@implementation MyOrderView

- (UIButton *)topayBtn{
    
    if (_topayBtn == nil) {
        
        _topayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _topayBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _topayBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        _topayBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_topayBtn setTitle:@"待支付" forState:UIControlStateNormal];
        [_topayBtn setTitleColor:TEXTCOLOR64 forState:UIControlStateNormal];
        [_topayBtn setImage:[UIImage imageNamed:@"m_ic_wait"] forState:UIControlStateNormal];
        [_topayBtn setTitleEdgeInsets:UIEdgeInsetsMake(30, -((MAINSCREEN.width - 40)/4 - 30)/2, 0, 0)];
        [_topayBtn setImageEdgeInsets:UIEdgeInsetsMake(5, ((MAINSCREEN.width-40)/4 - 32)/2, 0, 0)];
    }
    return _topayBtn;
}

- (UIButton *)todeliveryBtn{
    
    if (_todeliveryBtn == nil) {
        
        _todeliveryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _todeliveryBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _todeliveryBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        _todeliveryBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_todeliveryBtn setTitle:@"待发货" forState:UIControlStateNormal];
        [_todeliveryBtn setTitleColor:TEXTCOLOR64 forState:UIControlStateNormal];
        [_todeliveryBtn setImage:[UIImage imageNamed:@"ic_fahuo"] forState:UIControlStateNormal];
        [_todeliveryBtn setTitleEdgeInsets:UIEdgeInsetsMake(30, -((MAINSCREEN.width - 40)/4 - 30)/2, 0, 0)];
        [_todeliveryBtn setImageEdgeInsets:UIEdgeInsetsMake(5, ((MAINSCREEN.width-40)/4 - 32)/2, 0, 0)];
    }
    return _todeliveryBtn;
}

- (UIButton *)toserviceBtn{
    
    if (_toserviceBtn == nil) {
        
        _toserviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _toserviceBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _toserviceBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _toserviceBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        [_toserviceBtn setTitle:@"待服务" forState:UIControlStateNormal];
        [_toserviceBtn setTitleColor:TEXTCOLOR64 forState:UIControlStateNormal];
        [_toserviceBtn setImage:[UIImage imageNamed:@"ic_fuwu"] forState:UIControlStateNormal];
        [_toserviceBtn setTitleEdgeInsets:UIEdgeInsetsMake(30, -((MAINSCREEN.width - 40)/4 - 30)/2, 0, 0)];
        [_toserviceBtn setImageEdgeInsets:UIEdgeInsetsMake(5, ((MAINSCREEN.width-40)/4 - 32)/2, 0, 0)];
    }
    return _toserviceBtn;
}

- (UIButton *)completedBtn{
    
    if (_completedBtn == nil) {
        
        _completedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _completedBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _completedBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _completedBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        [_completedBtn setTitle:@"已完成" forState:UIControlStateNormal];
        [_completedBtn setTitleColor:TEXTCOLOR64 forState:UIControlStateNormal];
        [_completedBtn setImage:[UIImage imageNamed:@"ic_done"] forState:UIControlStateNormal];
        [_completedBtn setTitleEdgeInsets:UIEdgeInsetsMake(30, -((MAINSCREEN.width - 40)/4 - 30)/2, 0, 0)];
        [_completedBtn setImageEdgeInsets:UIEdgeInsetsMake(5, ((MAINSCREEN.width-40)/4 - 32)/2, 0, 0)];
    }
    return _completedBtn;
}

- (UIButton *)lookAllOrderBtn{
    
    if (_lookAllOrderBtn == nil) {
        
        _lookAllOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _lookAllOrderBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _lookAllOrderBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_lookAllOrderBtn setTitle:@"查看全部订单" forState:UIControlStateNormal];
        [_lookAllOrderBtn setTitleColor:TEXTCOLOR64 forState:UIControlStateNormal];
        [_lookAllOrderBtn setImage:[UIImage imageNamed:@"ic_right"] forState:UIControlStateNormal];
        [_lookAllOrderBtn setImageEdgeInsets:UIEdgeInsetsMake(0, MAINSCREEN.width/2 - 20 -12, 0, 0)];
        [_lookAllOrderBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    }
    return _lookAllOrderBtn;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addUnchangeView];
        [self addChangeView];
    }
    return self;
}

- (void)addUnchangeView{
    
    UILabel *myOrderLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, MAINSCREEN.width/2, 20)];
    myOrderLabel.text = @"我的订单";
    myOrderLabel.textColor = [UIColor blackColor];
    myOrderLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
    [self addSubview:myOrderLabel];
    
    UIView *orderLineView = [[UIView alloc] initWithFrame:CGRectMake(20, 39, MAINSCREEN.width - 40, 1)];
    orderLineView.backgroundColor = [PublicClass colorWithHexString:@"#ececec"];
    [self addSubview:orderLineView];
    
    UIView *underLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 110, MAINSCREEN.width, 5)];
    underLineView.backgroundColor = [PublicClass colorWithHexString:@"#ececec"];
    [self addSubview:underLineView];
}

- (void)addChangeView{
    
    [self addSubview:self.topayBtn];
    [self addSubview:self.todeliveryBtn];
    [self addSubview:self.toserviceBtn];
    [self addSubview:self.completedBtn];
    [self addSubview:self.lookAllOrderBtn];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.lookAllOrderBtn.frame = CGRectMake(MAINSCREEN.width/2, 10, MAINSCREEN.width/2 - 20, 20);
    self.topayBtn.frame = CGRectMake(20, 50, (MAINSCREEN.width - 40)/4, 40);
    self.todeliveryBtn.frame = CGRectMake(20 + (MAINSCREEN.width - 40)/4, 50, (MAINSCREEN.width - 40)/4, 40);
    self.toserviceBtn.frame = CGRectMake(20 + (MAINSCREEN.width - 40)*2/4, 50, (MAINSCREEN.width - 40)/4, 40);
    self.completedBtn.frame = CGRectMake(20 + (MAINSCREEN.width - 40)*3/4, 50, (MAINSCREEN.width - 40)/4, 50);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

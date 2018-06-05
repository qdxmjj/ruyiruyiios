//
//  PrivateNavigationView.m
//  TestOrdersType
//
//  Created by 小马驾驾 on 2018/5/29.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "PrivateNavigationView.h"
@interface PrivateNavigationView ()

@property(nonatomic,strong)UIButton *backBtn;//返回

@property(nonatomic,strong)UIImageView *headImg;//店铺头像

@property(nonatomic,strong)UILabel *titleLab;//标题

@property(nonatomic,strong)UICollectionView *serviceTypeView;//服务类型

@property(nonatomic,strong)UIButton *itemBtn;//店铺详情

@end

@implementation PrivateNavigationView


-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        
        [self addSubview:self.backBtn];
        [self addSubview:self.headImg];
        [self addSubview:self.titleLab];
        [self addSubview:self.itemBtn];
        [self addSubview:self.serviceTypeView];
        
    }
    return self;
}

-(void)layoutSubviews{
    
    [self.backBtn setFrame:CGRectMake(10, 20, 40, 30)];
    self.headImg.frame = CGRectMake(10, 60, 50, 50);
    self.titleLab.frame = CGRectMake(70, 60, self.frame.size.width-70-30, 25);
    [self.itemBtn setFrame:CGRectMake(self.frame.size.width-40, 60, 40, 30)];
    
    
}

-(UIButton *)backBtn{
    
    if (!_backBtn) {
        
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backViewController) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _backBtn;
}

-(void)backViewController{
    
    self.backBlock(YES);
}

-(UIImageView *)headImg{
    
    if (!_headImg) {
        
        _headImg = [[UIImageView alloc] init];
        _headImg.backgroundColor = [UIColor lightGrayColor];
    }
    return _headImg;
}

-(UILabel *)titleLab{
    
    if (!_titleLab) {
        
        _titleLab = [[UILabel alloc] init];
        
        _titleLab.text = @"测试数据1234564764356";
    }
    
    return _titleLab;
}

-(UIButton *)itemBtn{
    
    if (!_itemBtn) {
        
        _itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_itemBtn setTitle:@"详情" forState:UIControlStateNormal];
    }
    
    
    return _itemBtn;
}
@end

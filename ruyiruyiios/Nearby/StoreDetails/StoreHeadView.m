//
//  StoreHeadView.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/5.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "StoreHeadView.h"
#import "UIView+extension.h"
@interface StoreHeadView ()


@property(nonatomic,strong)UILabel *storeName;

@property(nonatomic,strong)UILabel *storeAddress;

@property(nonatomic,strong)UILabel *storeType;

@property(nonatomic,strong)UIImageView *positionImgView;

@end

@implementation StoreHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self= [super initWithFrame:frame]) {
        
        [self addSubview:self.storeName];
        [self addSubview:self.storeAddress];
        [self addSubview:self.storeType];
        [self addSubview:self.positionImgView];

    }
    return self;
}

-(void)layoutSubviews{

    self.storeName.frame = CGRectMake(10, 5, CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/5);
    self.storeAddress.frame = CGRectMake(10, self.storeName.bottom+5, CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/5);
    self.storeType.frame = CGRectMake(self.width-50, 5, 50, CGRectGetHeight(self.frame)/5);
    self.positionImgView.frame = CGRectMake(self.width-50, self.storeType.bottom+5, 50, CGRectGetHeight(self.frame)/5);
    
}

-(UILabel *)storeName{
    
    if (!_storeName) {
        
        _storeName = [[UILabel alloc] init];
        _storeName.text = @"小马驾驾";
    }
    return _storeName;
}

-(UILabel *)storeAddress{
    
    if (!_storeAddress) {
        
        _storeAddress = [[UILabel alloc] init];
        
        _storeAddress.text = @"地址：...";
    }
    return _storeAddress;
}

-(UILabel *)storeType{
    
    if (!_storeType) {
        
        _storeType = [[UILabel alloc] init];
        
        _storeType.text = @"4S店";
    }
    return _storeType;
}

-(UIImageView *)positionImgView{
    
    if (!_positionImgView) {
        
        _positionImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"自选规格"]];
        _positionImgView.contentMode = UIViewContentModeCenter;
    }
    
    return _positionImgView;
}

@end

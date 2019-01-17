//
//  LogisticsHeaderView.m
//  ruyiruyiios
//
//  Created by 姚永敏 on 2019/1/16.
//  Copyright © 2019 ruyiruyi. All rights reserved.
//

#import "LogisticsHeaderView.h"
#import <UIImageView+WebCache.h>
#define labelTextColor  [UIColor colorWithRed:94.f/255.f green:94.f/255.f blue:94.f/255.f alpha:1.f]
@interface LogisticsHeaderView ()

@property (nonatomic, strong) UIImageView *goodsImgView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *ligisticsNameLab;
@property (nonatomic, strong) UILabel *trackingNumberLab;
@property (nonatomic, strong) UILabel *telLab;

@property (nonatomic, strong) UILabel *addressLab;
@end
@implementation LogisticsHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
       
        [self addSubview:self.goodsImgView];
        [self addSubview:self.titleLab];
        [self addSubview:self.ligisticsNameLab];
        [self addSubview:self.trackingNumberLab];
        [self addSubview:self.telLab];
        [self addSubview:self.addressLab];
    }
    return self;
}
//http://192.168.0.60:10008/score/address/5?userId=1
- (void)setAddress:(NSString *)address{
    
    self.addressLab.text = [NSString stringWithFormat:@"收货地址：%@",address];
}

- (void)setGoodsImg:(NSString *)goodsImg{
    
    [self.goodsImgView sd_setImageWithURL:[NSURL URLWithString:goodsImg]];
}

- (void)setGoodsName:(NSString *)goodsName{
    
    self.titleLab.text = goodsName;
}
- (void)setLogisticsNO:(NSString *)logisticsNO{
    
    self.trackingNumberLab.text = logisticsNO;
}
- (void)setLogisticsName:(NSString *)logisticsName{
    
    self.ligisticsNameLab.text = logisticsName;;
}
- (void)setLogisticsPhone:(NSString *)logisticsPhone{
    
    self.telLab.text = [NSString stringWithFormat:@"官方电话：%@",logisticsPhone];
}
- (void)layoutSubviews{
    
    [self.goodsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.mas_top).inset(10);
        make.leading.mas_equalTo(self.mas_leading).inset(16);
        make.width.height.mas_equalTo(CGSizeMake(60, 70));
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.goodsImgView.mas_top);
        make.leading.mas_equalTo(self.goodsImgView.mas_trailing).inset(5);
        make.trailing.mas_equalTo(self.mas_trailing).inset(16);
        make.height.mas_equalTo(20);
    }];

    [self.ligisticsNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.titleLab.mas_bottom).inset(3);
        make.leading.mas_equalTo(self.titleLab.mas_leading);
        make.height.mas_equalTo(20);
    }];
    [self.trackingNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.titleLab.mas_bottom).inset(3);
        make.leading.mas_equalTo(self.ligisticsNameLab.mas_trailing).inset(5);
        make.height.mas_equalTo(20);
    }];
    [self.telLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.trackingNumberLab.mas_bottom).inset(5);
        make.leading.mas_equalTo(self.titleLab.mas_leading);
        make.height.mas_equalTo(20);
    }];
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.mas_equalTo(self.mas_leading).inset(30);
        make.trailing.mas_equalTo(self.mas_trailing).inset(30);
        make.top.mas_equalTo(self.goodsImgView.mas_bottom).inset(5);
        make.height.mas_equalTo(55);
    }];
}
- (UIImageView *)goodsImgView{
    if (!_goodsImgView) {
        _goodsImgView = [[UIImageView alloc] init];
        _goodsImgView.backgroundColor = labelTextColor;
    }
    return _goodsImgView;
}
- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont systemFontOfSize:15.f];
        _titleLab.textColor = [UIColor blackColor];
//        _titleLab.text = @"测试商品";
    }
    return _titleLab;
}
- (UILabel *)ligisticsNameLab{
    if (!_ligisticsNameLab) {
        _ligisticsNameLab = [[UILabel alloc] init];
        _ligisticsNameLab.font = [UIFont systemFontOfSize:14.f];
        _ligisticsNameLab.textColor = labelTextColor;
        //        _ligisticsNameLab.text = @"中通快递";
    }
    return _ligisticsNameLab;
}
- (UILabel *)trackingNumberLab{
    if (!_trackingNumberLab) {
        _trackingNumberLab = [[UILabel alloc] init];
        _trackingNumberLab.font = [UIFont systemFontOfSize:14.f];
        _trackingNumberLab.textColor = labelTextColor;
//        _trackingNumberLab.text = @"中通快递：14452323424324";
    }
    return _trackingNumberLab;
}
- (UILabel *)telLab{
    if (!_telLab) {
        _telLab = [[UILabel alloc] init];
        _telLab.font = [UIFont systemFontOfSize:14.f];
        _telLab.textColor = labelTextColor;
//        _telLab.text = @"官方电话：10086";
    }
    return _telLab;
}
- (UILabel *)addressLab{
    if (!_addressLab) {
        _addressLab = [[UILabel alloc] init];
        _addressLab.font = [UIFont systemFontOfSize:14.f];
        _addressLab.textColor = labelTextColor;
        _addressLab.numberOfLines = 0;
//        _addressLab.text = @"测试地址测试地址测试地址测试地址测试地址测试地址测试地址测试地址测试地址测试地址测试地址测试地址测试地址测试地址测试地址测试地址测试地址测试地址测试地址";
    }
    return _addressLab;
}
@end

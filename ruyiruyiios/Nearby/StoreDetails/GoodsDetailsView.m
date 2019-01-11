//
//  GoodsDetailsView.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2019/1/10.
//  Copyright © 2019年 ruyiruyi. All rights reserved.
//

#import "GoodsDetailsView.h"
#import <UIImageView+WebCache.h>
@interface GoodsDetailsView ()

@property (nonatomic, strong) UIScrollView *mainView;

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *goodsNameLab;//商品名
@property (nonatomic, strong) UILabel *goodsStockLab;//商品库存

@property (nonatomic, strong) UIButton *lessBtn;//商品库存
@property (nonatomic, strong) UILabel *goodsNumberlab;//商品库存
@property (nonatomic, strong) UIButton *plusBtn;//商品库存

@property (nonatomic, strong) UILabel *goodsPriceLab;//商品价格
@property (nonatomic, strong) UILabel *goodsDescriptionLab;//商品描述
@property (nonatomic, strong) UILabel *goodsContentLab;//描述内容

@property (nonatomic, strong) CommodityModel *goodsModel;

@end

@implementation GoodsDetailsView
- (instancetype)initWithFrame:(CGRect)frame commodityModel:(CommodityModel *)model{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        
        self.goodsModel = model;
        self.number += [model.commodityNumber integerValue];
        [self addSubview:self.mainView];
        [self.mainView addSubview:self.imgView];
        [self.mainView addSubview:self.goodsNameLab];
        [self.mainView addSubview:self.goodsStockLab];
        [self.mainView addSubview:self.lessBtn];
        [self.mainView addSubview:self.goodsNumberlab];
        [self.mainView addSubview:self.plusBtn];
        [self.mainView addSubview:self.goodsPriceLab];
        [self.mainView addSubview:self.goodsDescriptionLab];
        [self.mainView addSubview:self.goodsContentLab];
    }
    return self;
}

- (IBAction)selectCommodityWithNumber:(UIButton *)sender {
    
    if (sender == self.lessBtn) {
        
        if (self.number==0) {
            
            return;
        }
        self.number--;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TotalPriceLessNotification" object:@[[NSString stringWithFormat:@"%@",self.goodsModel.price],self.goodsModel.commodityID,@(self.number),self.goodsModel.serviceId,self.goodsModel.serviceTypeId]];
        
    }else{
        
        if (self.number >= [self.goodsModel.amount integerValue]) {
            
            return;
        }
        
        self.number++;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TotalPricePlusNotification" object:@[[NSString stringWithFormat:@"%@",self.goodsModel.price],self.goodsModel.commodityID,@(self.number),self.goodsModel.serviceId,self.goodsModel.serviceTypeId]];
    }
    self.goodsNumberlab.text = [NSString stringWithFormat:@"%ld",(long)self.number];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self dismiss];
}

- (void)layoutSubviews{
    
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.7);
        make.bottom.mas_equalTo(self.goodsContentLab.mas_bottom);
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.mainView.mas_top).inset(1);
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(self.mainView.mas_height).multipliedBy(0.8);
    }];
    
    [self.goodsNameLab mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.mas_equalTo(self.mainView.mas_left).inset(16);
        make.top.mas_equalTo(self.imgView.mas_bottom);
        make.height.mas_equalTo(25);
    }];
    
    [self.goodsStockLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.goodsNameLab.mas_bottom);
        make.left.mas_equalTo(self.mas_left).inset(16);
        make.height.mas_equalTo(20);
    }];
    [self.plusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.mas_right).inset(16);
        make.width.height.mas_equalTo(20);
        make.centerY.mas_equalTo(self.goodsStockLab.mas_centerY);
    }];
    
    [self.goodsNumberlab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.mas_equalTo(self.plusBtn.mas_left).inset(2);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(self.plusBtn.mas_centerY);
    }];
    [self.lessBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.mas_equalTo(self.goodsNumberlab.mas_left).inset(2);
        make.width.height.mas_equalTo(20);
        make.centerY.mas_equalTo(self.plusBtn.mas_centerY);
    }];
    
    [self.goodsPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.goodsStockLab.mas_bottom);
        make.left.mas_equalTo(self.mas_left).inset(16);
        make.height.mas_equalTo(20);
    }];
    
    [self.goodsDescriptionLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.goodsPriceLab.mas_bottom).inset(5);
        make.left.mas_equalTo(self.mas_left).inset(16);
        make.height.mas_equalTo(25);
    }];
    [self.goodsContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.goodsDescriptionLab.mas_bottom).inset(5);
        make.left.mas_equalTo(self.mas_left).inset(16);
        make.right.mas_equalTo(self.mas_right).inset(16);
    }];
}

- (UIScrollView *)mainView{
    if (!_mainView) {
        _mainView = [[UIScrollView alloc] init];
        _mainView.backgroundColor = [UIColor whiteColor];
        _mainView.showsHorizontalScrollIndicator = NO;
        _mainView.showsVerticalScrollIndicator = NO;
        _mainView.scrollsToTop = NO;
        if (@available(iOS 11.0, *)) {
            _mainView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
        }
    }
    return _mainView;
}

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
//        _imgView.image = [UIImage imageNamed:@"ic_yindaoye_1"];
        [_imgView sd_setImageWithURL:[NSURL URLWithString:self.goodsModel.imgUrl]];
    }
    return _imgView;
}

- (UILabel *)goodsNameLab{
    if (!_goodsNameLab) {
        _goodsNameLab = [[UILabel alloc] init];
        _goodsNameLab.text = self.goodsModel.name;
        _goodsNameLab.textColor = TEXTCOLOR64;
        _goodsNameLab.font = [UIFont systemFontOfSize:15.f];
    }
    return _goodsNameLab;
}

- (UILabel *)goodsStockLab{
    if (!_goodsStockLab) {
        _goodsStockLab = [[UILabel alloc] init];
        _goodsStockLab.text = [NSString stringWithFormat:@"库存：%@",self.goodsModel.amount];
        _goodsStockLab.textColor = TEXTCOLOR64;
        _goodsStockLab.font = [UIFont systemFontOfSize:12.f];
    }
    return _goodsStockLab;
}

- (UILabel *)goodsPriceLab{
    if (!_goodsPriceLab) {
        _goodsPriceLab = [[UILabel alloc] init];
        _goodsPriceLab.text = [NSString stringWithFormat:@"¥%@",self.goodsModel.price];
        _goodsPriceLab.textColor = [UIColor redColor];
        _goodsPriceLab.font = [UIFont systemFontOfSize:12.f];
    }
    return _goodsPriceLab;
}

- (UILabel *)goodsDescriptionLab{
    if (!_goodsDescriptionLab) {
        _goodsDescriptionLab = [[UILabel alloc] init];
        _goodsDescriptionLab.text = @"商品描述：";
        _goodsDescriptionLab.textColor = TEXTCOLOR64;
        _goodsDescriptionLab.font = [UIFont systemFontOfSize:15.f];
    }
    return _goodsDescriptionLab;
}

- (UILabel *)goodsContentLab{
    if (!_goodsContentLab) {
        _goodsContentLab = [[UILabel alloc] init];
        if ([self.goodsModel.stockDesc isEqualToString:@""]) {
            _goodsContentLab.text = @"暂无描述";
        }else{
            _goodsContentLab.text = self.goodsModel.stockDesc;
        }
        _goodsContentLab.numberOfLines = 0;
        _goodsContentLab.textColor = TEXTCOLOR64;
        _goodsContentLab.font = [UIFont systemFontOfSize:12.f];
    }
    return _goodsContentLab;
}

- (UILabel *)goodsNumberlab{
    if (!_goodsNumberlab) {
        _goodsNumberlab = [[UILabel alloc] init];
        _goodsNumberlab.text = [NSString stringWithFormat:@"%@",self.goodsModel.commodityNumber];
        _goodsNumberlab.textColor = TEXTCOLOR64;
        _goodsNumberlab.font = [UIFont systemFontOfSize:14.f];
    }
    return _goodsNumberlab;
}

- (UIButton *)lessBtn{
    if (!_lessBtn) {
        _lessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_lessBtn setImage:[UIImage imageNamed:@"ic_cut"] forState:UIControlStateNormal];
        [_lessBtn addTarget:self action:@selector(selectCommodityWithNumber:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lessBtn;
}
- (UIButton *)plusBtn{
    if (!_plusBtn) {
        _plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_plusBtn setImage:[UIImage imageNamed:@"ic_add"] forState:UIControlStateNormal];
        [_plusBtn addTarget:self action:@selector(selectCommodityWithNumber:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _plusBtn;
}

- (CommodityModel *)goodsModel{
    
    if (!_goodsModel) {
        
        _goodsModel = [[CommodityModel alloc] init];
    }
    return _goodsModel;
}

-(void)show:(UIView *)view{
    
    if (view) {
        [view addSubview:self];
    }else{
        
        [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    }
}
-(void)dismiss{
    
    [UIView animateWithDuration:1.f animations:^{
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

@end

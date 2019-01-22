//
//  GoodsDetailsViewController.m
//  Menu
//
//  Created by 姚永敏 on 2018/12/25.
//  Copyright © 2018 YYM. All rights reserved.
//

#import "GoodsDetailsViewController.h"
#import "OrderConfirmViewController.h"
#import <UIImageView+WebCache.h>
#import "UIView+BorderLine.h"
@interface GoodsDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLab;
@property (weak, nonatomic) IBOutlet UILabel *goodsIntegralLab;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *goodsStockLab;
@property (weak, nonatomic) IBOutlet UILabel *goodsDetailsLab;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *numberPeopleLab;

@property (strong, nonatomic) IntegralGoodsMode *integralGoodsModel;
@end

@implementation GoodsDetailsViewController

- (instancetype)initWithIntegralGoodsMode:(IntegralGoodsMode *)model{
    self = [super init];
    if (self) {
        
        self.integralGoodsModel = model;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    
    UIView * barBackground = self.navigationController.navigationBar.subviews.firstObject;
    if (@available(iOS 11.0, *))
    {
        barBackground.alpha = 1;
        [barBackground.subviews setValue:@(1) forKeyPath:@"alpha"];
    } else {
        barBackground.alpha = 1;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.title = @"商品详情";
        
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@", self.integralGoodsModel.imgUrl]];
    
    [self.goodsImageView sd_setImageWithURL:imgUrl];
    self.goodsNameLab.text = self.integralGoodsModel.name;
    self.goodsPriceLab.text = [NSString stringWithFormat:@"市场价：%@元",self.integralGoodsModel.price];
    self.goodsIntegralLab.text = [NSString stringWithFormat:@"%@",self.integralGoodsModel.score];
    self.goodsStockLab.text = [NSString stringWithFormat:@"剩余%@件",self.integralGoodsModel.amount];
    self.goodsDetailsLab.text = self.integralGoodsModel.goods_description;
    self.numberPeopleLab.text = [NSString stringWithFormat:@"%@人已换购",self.integralGoodsModel.soldNo];
}
- (IBAction)redeemNowEvent:(UIButton *)sender {
    
    OrderConfirmViewController *orderConfirmVC = [[OrderConfirmViewController alloc] initWithIntegralGoodsMode:self.integralGoodsModel];
    
    [self.navigationController pushViewController:orderConfirmVC animated:YES];
}

- (IntegralGoodsMode *)integralGoodsModel{
    if (!_integralGoodsModel) {
        
        _integralGoodsModel = [[IntegralGoodsMode alloc] init];
    }
    return _integralGoodsModel;
}
@end

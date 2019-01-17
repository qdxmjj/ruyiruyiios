//
//  ChangeCouponCell.m
//  Menu
//
//  Created by 姚永敏 on 2018/12/25.
//  Copyright © 2018 YYM. All rights reserved.
//

#import "ChangeCouponCell.h"

@implementation ChangeCouponCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setGoodsModel:(IntegralGoodsMode *)goodsModel{

    self.titlelab.text = goodsModel.name;
    self.stockLab.text = [NSString stringWithFormat:@"库存：%@件",goodsModel.amount];
    self.valueLab.text = [NSString stringWithFormat:@"￥%@",goodsModel.price];
    self.priceLab.text = [NSString stringWithFormat:@"%@积分",goodsModel.score];
    if ([goodsModel.amount integerValue] == 0) {
        
        self.backGroundImgView.image = [UIImage imageNamed:@"shouqing"];
        self.exchangeBtn.hidden = YES;
    }else{
        self.backGroundImgView.image = [UIImage imageNamed:@"zaishou"];
        self.exchangeBtn.hidden = NO;
    }
}
- (IBAction)exchangeGoodsEvent:(id)sender {
    if ([self.delegate respondsToSelector:@selector(ClickExchangeButtonWithChangeCouponCell:)]) {
        
        [self.delegate ClickExchangeButtonWithChangeCouponCell:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

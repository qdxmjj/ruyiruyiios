//
//  RealThingCell.m
//  Menu
//
//  Created by 姚永敏 on 2018/12/24.
//  Copyright © 2018 YYM. All rights reserved.
//

#import "RealThingCell.h"
#import <UIImageView+WebCache.h>
@interface RealThingCell ()

@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLab;
@property (weak, nonatomic) IBOutlet UILabel *goodsScoreLab;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *numberPeopleLab;

@end
@implementation RealThingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setGoodsModel:(IntegralGoodsMode *)goodsModel{
    
    NSURL *url = [NSURL URLWithString:goodsModel.imgUrl];
    [self.goodsImgView sd_setImageWithURL:url];
    self.goodsNameLab.text = goodsModel.name;
    self.goodsScoreLab.text = [NSString stringWithFormat:@"%@",goodsModel.score];
    self.goodsPriceLab.text = [NSString stringWithFormat:@"市场价：%@元",goodsModel.price];
    self.numberPeopleLab.text = [NSString stringWithFormat:@"%@人已换购",goodsModel.soldNo];
    
    
}

@end

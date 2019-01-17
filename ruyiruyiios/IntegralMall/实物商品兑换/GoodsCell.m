//
//  GoodsCell.m
//  ruyiruyiios
//
//  Created by 姚永敏 on 2019/1/4.
//  Copyright © 2019 ruyiruyi. All rights reserved.
//

#import "GoodsCell.h"
@interface GoodsCell ()

@property (weak, nonatomic) IBOutlet UILabel *goodsNameLab;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
@property (weak, nonatomic) IBOutlet UILabel *goodsIntegralLab;


@end
@implementation GoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(IntegralGoodsMode *)model{
    
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@", model.imgUrl]];

    [self.goodsImgView sd_setImageWithURL:imgUrl];
    self.goodsNameLab.text = model.name;
    self.goodsIntegralLab.text = [NSString stringWithFormat:@"%@",model.score];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

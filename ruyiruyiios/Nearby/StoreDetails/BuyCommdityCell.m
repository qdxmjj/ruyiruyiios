//
//  BuyCommdityCell.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/8.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "BuyCommdityCell.h"
#import <UIImageView+WebCache.h>
@interface BuyCommdityCell ()

@property (weak, nonatomic) IBOutlet UIImageView *commodityPhoto;
@property (weak, nonatomic) IBOutlet UILabel *commodityName;
@property (weak, nonatomic) IBOutlet UILabel *commodityPrice;
@property (weak, nonatomic) IBOutlet UILabel *commodityNumber;

@end
@implementation BuyCommdityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(CommodityModel *)model{
    
    [self.commodityPhoto sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@"ic_my_shibai"]];
    self.commodityName.text = model.name;
    self.commodityPrice.text =[NSString stringWithFormat:@"¥%@", model.price];
    self.commodityNumber.text =[NSString stringWithFormat:@"x%@", model.commodityNumber];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

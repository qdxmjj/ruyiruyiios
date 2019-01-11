//
//  ContentTableViewCell.m
//  TestCommodityInfo
//
//  Created by 小马驾驾 on 2018/5/30.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "ContentTableViewCell.h"
#import <UIImageView+WebCache.h>

@interface ContentTableViewCell ()


@end

@implementation ContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}
- (IBAction)selectCommodityWithNumber:(UIButton *)sender {
    
    if (sender == self.lessBtn) {
        
        if (self.number==0) {
            
            return;
        }
        self.number--;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TotalPriceLessNotification" object:@[[NSString stringWithFormat:@"%@",self.model.price],self.model.commodityID,@(self.number),self.model.serviceId,self.model.serviceTypeId]];

    }else{
        
        if (self.number >= [self.model.amount integerValue]) {
            
            return;
        }
        
        self.number++;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TotalPricePlusNotification" object:@[[NSString stringWithFormat:@"%@",self.model.price],self.model.commodityID,@(self.number),self.model.serviceId,self.model.serviceTypeId]];

    }
    
    self.numeberLab.text = [NSString stringWithFormat:@"%ld",(long)self.number];
}
-(void)setModel:(CommodityModel *)model{
    
    _model = model;
    
    [self.commodityImg sd_setImageWithURL:[NSURL URLWithString:model.imgUrl]];
    self.commodityName.text = model.name;
    self.commodityPrice.text = [NSString stringWithFormat:@"¥%@",model.price];
    
    if ([model.discountFlag integerValue] == 1) {
        
        NSMutableAttributedString *newPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",model.originalPrice]];
        [newPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, newPrice.length)];
        self.originalPriceLab.attributedText = newPrice;
    }
    
    NSString *type = [NSString stringWithFormat:@"%@",model.system];
    if ([type isEqualToString:@"1"]) {
        self.commodityStock.text = [NSString stringWithFormat:@"%@",model.serviceDesc];
    }else{
        self.commodityStock.text = [NSString stringWithFormat:@"库存：%@",model.amount];
    }
    self.numeberLab.text = [NSString stringWithFormat:@"%@",model.commodityNumber];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

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
    
    if ([sender.titleLabel.text isEqualToString:@"一"]) {
        
        if (self.number==0) {
            
            return;
        }
        self.number--;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TotalPriceLessNotification" object:@[[NSString stringWithFormat:@"%@",self.model.price],self.model.commodityID,@(self.number)]];

    }else{
        
        self.number++;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TotalPricePlusNotification" object:@[[NSString stringWithFormat:@"%@",self.model.price],self.model.commodityID,@(self.number)]];

    }
    
    self.numeberLab.text = [NSString stringWithFormat:@"%ld",self.number];
    
}
-(void)setModel:(CommodityModel *)model{
    
    _model = model;
    
    [self.commodityImg sd_setImageWithURL:[NSURL URLWithString:model.imgUrl]];
    self.commodityName.text = model.name;
    self.commodityPrice.text = [NSString stringWithFormat:@"¥%@",model.price];
    self.commodityStock.text = [NSString stringWithFormat:@"%@",model.amount];
    self.numeberLab.text = [NSString stringWithFormat:@"%@",model.commodityNumber];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

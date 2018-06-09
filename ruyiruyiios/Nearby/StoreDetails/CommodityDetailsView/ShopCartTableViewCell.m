//
//  ShopCartTableViewCell.m
//  TestCommodityInfo
//
//  Created by 小马驾驾 on 2018/5/31.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "ShopCartTableViewCell.h"

@implementation ShopCartTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)selectCommodityWithNumber:(UIButton *)sender {
    
    self.number = [self.countLab.text integerValue];
    
    if ([sender.titleLabel.text isEqualToString:@"一"]) {
        
        if (self.number==0) {
            
            return;
        }
        self.number--;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ShopCartLessNotification" object:@[[NSString stringWithFormat:@"%@",self.shopCartModel.price],self.shopCartModel.commodityID,@(self.number)]];
        
    }else{
        
        self.number++;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ShopCartPlusNotification" object:@[[NSString stringWithFormat:@"%@",self.shopCartModel.price],self.shopCartModel.commodityID,@(self.number)]];

    }
    
    self.countLab.text = [NSString stringWithFormat:@"%ld",self.number];
}

-(void)setShopCartModel:(CommodityModel *)shopCartModel{
    
    _shopCartModel = shopCartModel;
    
    self.commdityName.text = shopCartModel.name;
    self.priceLab.text = [NSString stringWithFormat:@"%@",shopCartModel.price];
    self.countLab.text = [NSString stringWithFormat:@"%@",shopCartModel.commodityNumber];
}

@end

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
    
    if (sender == self.lessBtn) {
        
        if (self.number==0) {
            
            return;
        }
        self.number--;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ShopCartLessNotification" object:@[[NSString stringWithFormat:@"%@",self.shopCartModel.price],self.shopCartModel.commodityID,@(self.number),self.shopCartModel.serviceId,self.shopCartModel.serviceTypeId]];
        
    }else{
        
        self.number++;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ShopCartPlusNotification" object:@[[NSString stringWithFormat:@"%@",self.shopCartModel.price],self.shopCartModel.commodityID,@(self.number),self.shopCartModel.serviceId,self.shopCartModel.serviceTypeId]];

    }
    
    self.countLab.text = [NSString stringWithFormat:@"%ld",(long)self.number];
}

-(void)setShopCartModel:(CommodityModel *)shopCartModel{
    
    _shopCartModel = shopCartModel;
    
    self.commdityName.text = shopCartModel.name;
    self.priceLab.text = [NSString stringWithFormat:@"¥%@",shopCartModel.price];
    self.countLab.text = [NSString stringWithFormat:@"%@",shopCartModel.commodityNumber];
}

@end

//
//  YMDetailedServiceCell.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/14.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "YMDetailedServiceCell.h"
#import <UIImageView+WebCache.h>
@interface YMDetailedServiceCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UIImageView *serviceImg;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLab;
@property (weak, nonatomic) IBOutlet UILabel *distanceLab;

@end
@implementation YMDetailedServiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

-(void)setStockModel:(WinterTyreStockModel *)model{
    
    self.nameLab.text = model.name;
    self.storeNameLab.text = model.storeName;
    self.priceLab.text = [NSString stringWithFormat:@"¥%@",model.price];
    self.distanceLab.text = [NSString stringWithFormat:@"%.2fkm",model.distance/1000];
    
    [self.serviceImg sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@"ic_my_shibai"]];
    
}

@end

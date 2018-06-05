//
//  ShopCartTableViewCell.h
//  TestCommodityInfo
//
//  Created by 小马驾驾 on 2018/5/31.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommodityModel.h"
@interface ShopCartTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UILabel *commdityName;
@property (weak, nonatomic) IBOutlet UIButton *plusBtn;
@property (weak, nonatomic) IBOutlet UIButton *lessBtn;

@property(nonatomic,assign)NSInteger number;//每个商品的初始数量

@property(nonatomic,strong)CommodityModel *shopCartModel;

//-(void)setShopCartModel:(CommodityModel *)model;

@end

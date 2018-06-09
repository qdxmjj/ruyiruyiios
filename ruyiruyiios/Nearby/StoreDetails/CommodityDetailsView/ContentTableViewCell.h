//
//  ContentTableViewCell.h
//  TestCommodityInfo
//
//  Created by 小马驾驾 on 2018/5/30.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommodityModel.h"
@interface ContentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *commodityImg;
@property (weak, nonatomic) IBOutlet UILabel *commodityName;
@property (weak, nonatomic) IBOutlet UILabel *commodityStock;
@property (weak, nonatomic) IBOutlet UILabel *commodityPrice;
@property (weak, nonatomic) IBOutlet UILabel *numeberLab;

@property(nonatomic,strong)CommodityModel *model;

@property(nonatomic,assign)NSInteger number;//每个商品的初始数量

@end

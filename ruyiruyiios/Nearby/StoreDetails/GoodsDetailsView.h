//
//  GoodsDetailsView.h
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2019/1/10.
//  Copyright © 2019年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommodityModel.h"
@interface GoodsDetailsView : UIView

- (instancetype)initWithFrame:(CGRect)frame commodityModel:(CommodityModel *)model;

-(void)show:(UIView *)view;

@property(nonatomic,assign)NSInteger number;//每个商品的初始数量

@end

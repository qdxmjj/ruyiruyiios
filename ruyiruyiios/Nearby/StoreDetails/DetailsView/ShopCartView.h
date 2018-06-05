//
//  ShopCartView.h
//  TestCommodityInfo
//
//  Created by 小马驾驾 on 2018/5/31.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^removeAllShopCartBlock)(BOOL isRemove);
@interface ShopCartView : UIView

@property(nonatomic,strong)NSArray *commodityList;

@property(nonatomic,strong)removeAllShopCartBlock removeBlock;

-(void)reloadTableView;
@end

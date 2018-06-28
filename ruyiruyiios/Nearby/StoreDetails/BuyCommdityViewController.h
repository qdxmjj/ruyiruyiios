//
//  BuyCommdityViewController.h
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/8.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "RootViewController.h"

@interface BuyCommdityViewController : RootViewController

@property(strong,nonatomic)NSArray *commodityList;//数据源

/**
 *用户名
 */
@property(copy,nonatomic,nonnull)NSString *userName;

/**
 *用户联系方式
 */
@property(copy,nonatomic,nonnull)NSString *userPhone;

/**
 * 购买的商店名
 */
@property(copy,nonatomic,nonnull)NSString *storeName;

/**
 *总价
 */
@property(copy,nonatomic,nonnull)NSString *totalPrice;

/**
 *购买的商店ID
 */
@property(copy,nonatomic,nonnull)NSString *storeID;



@end

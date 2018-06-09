//
//  BuyCommdityViewController.h
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/8.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyCommdityViewController : UIViewController

@property(strong,nonatomic)NSArray *commodityList;

@property(copy,nonatomic)NSString *userName;
@property(copy,nonatomic)NSString *userPhone;
@property(copy,nonatomic)NSString *storeName;

@property(copy,nonatomic)NSString *totalPrice;
@property(copy,nonatomic)NSString *storeID;

@property(copy,nonatomic)NSString *status;

@end

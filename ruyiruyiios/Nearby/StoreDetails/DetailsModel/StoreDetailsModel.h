//
//  StoreDetailsModel.h
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/6.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreDetailsModel : UICollectionViewFlowLayout

@property(nonatomic,copy)NSString *storeName;

@property(nonatomic,copy)NSString *storeAddress;

@property(nonatomic,copy)NSString *storeType;

@property(nonatomic,copy)NSString *storeTypeColor;

@property(nonatomic,copy)NSString *distance;

@property(nonatomic,copy)NSString *storePhone;

@property(nonatomic,copy)NSString *storeLocation;

@property(nonatomic,strong)NSArray *storeServcieList;

@property(nonatomic,strong)NSString *storeId;

@property(nonatomic,strong)NSString *latitude;

@property(nonatomic,strong)NSString *longitude;

@end

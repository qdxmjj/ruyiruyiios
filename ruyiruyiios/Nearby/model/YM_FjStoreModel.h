//
//  YM_FjStoreModel.h
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/5/30.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface YM_FjStoreModel : NSObject

@property(nonatomic,copy)NSString *distance;

@property(nonatomic,copy)NSString *storeType;

@property(nonatomic,copy)NSString *storeTypeColor;

@property(nonatomic,copy)NSString *storeImg;

@property(nonatomic,copy)NSString *storeName;

@property(nonatomic,copy)NSString *storeAddress;

@property(nonatomic,strong)NSArray *serviceList;

@end

//
//  WaitPaymentModel.h
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/28.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WaitPaymentModel : NSObject

@property(nonatomic,copy)NSString *detailName;
@property(nonatomic,copy)NSString *detailPrice;
@property(nonatomic,copy)NSString *detailImage;
@property(nonatomic,copy)NSString *amount;
@property(nonatomic,copy)NSString *detailId;

@property(nonatomic,copy)NSString *detailTotalPrice;

@property(nonatomic,copy)NSString *detailServiceId;

@property(nonatomic,copy)NSString *detailServiceTypeId;

@end

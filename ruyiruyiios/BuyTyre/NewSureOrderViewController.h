//
//  NewSureOrderViewController.h
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/8/16.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "RootViewController.h"
#import "BuyTireData.h"
@interface NewSureOrderViewController : RootViewController


@property(nonatomic, strong)BuyTireData *buyTireData;

@property(nonatomic, copy)NSString *shoeID;//轮胎ID

@property(nonatomic, copy)NSString *fontRearFlag;//前后轮标示
@property(nonatomic, copy)NSString *tireCount;//轮胎总数
@property(nonatomic, copy)NSString *tireTotalPrice;//轮胎总价
@property(nonatomic, copy)NSString *tirePrice;//轮胎单价

@property(nonatomic, copy)NSString *cxwyCount;//畅行无忧总数
@property(nonatomic, copy)NSString *cxwyPrice;//畅行无忧单价  改版：也传总价
@property(nonatomic, copy)NSString *cxwyTotalPrice;//畅行无忧总价

@property(nonatomic, copy)NSString *orderImg;//订单图片
@property(nonatomic, copy)NSString *serviceYear;//服务年限

@property(nonatomic,copy) NSString *speedLevelStr;

@property(nonatomic,copy) NSString *tireImgURL;//轮胎图片
@end

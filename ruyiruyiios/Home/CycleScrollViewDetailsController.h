//
//  CycleScrollViewDetailsController.h
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/7/19.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "RootViewController.h"
#import "Data_cars.h"
@interface CycleScrollViewDetailsController : RootViewController

//点击的图片index
@property(nonatomic,assign)NSInteger index;

//轮胎大小
@property(nonatomic,copy,nonnull)NSString *tireSize;

//前后轮是否一致
@property(nonatomic,copy,nonnull)NSString *fontRearFlag;

//汽车信息
@property(nonatomic,strong,nonnull)Data_cars *dataCars;

@end

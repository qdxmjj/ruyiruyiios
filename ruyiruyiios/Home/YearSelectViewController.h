//
//  YearSelectViewController.h
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/8/2.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "RootViewController.h"
#import "Data_cars.h"
@interface YearSelectViewController : RootViewController

@property(nonatomic,copy,nonnull)NSString *maximumYears;

@property(nonatomic,strong)Data_cars *data_cars;

@end

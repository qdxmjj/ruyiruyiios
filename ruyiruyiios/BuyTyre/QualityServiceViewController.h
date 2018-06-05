//
//  QualityServiceViewController.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/30.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "RootViewController.h"
#import "BuyTireData.h"
#import "ShoeSpeedLoadResult.h"

@interface QualityServiceViewController : RootViewController

@property(nonatomic, strong)BuyTireData *buyTireData;
@property(nonatomic, strong)ShoeSpeedLoadResult *shoeSpeedResult;
@property(nonatomic, strong)NSString *tireCount;
@property(nonatomic, strong)NSString *cxwyCount;
@property(nonatomic, strong)NSString *fontRearFlag;

@end

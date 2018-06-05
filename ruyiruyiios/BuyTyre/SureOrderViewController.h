//
//  SureOrderViewController.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/30.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "RootViewController.h"
#import "ShoeSpeedLoadResult.h"
#import "BuyTireData.h"

@interface SureOrderViewController : RootViewController

@property(nonatomic, strong)ShoeSpeedLoadResult *shoeSpeedLoadResult;
@property(nonatomic, strong)BuyTireData *buyTireData;
@property(nonatomic, strong)NSString *tireCount;
@property(nonatomic, strong)NSString *cxwyCount;
@property(nonatomic, strong)NSString *fontRearFlag;

@end

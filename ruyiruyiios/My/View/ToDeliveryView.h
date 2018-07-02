//
//  ToDeliveryView.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/29.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstUpdateOrFreeChangeInfo.h"

@interface ToDeliveryView : UIView

@property(nonatomic, strong)UILabel *userNameLabel;
@property(nonatomic, strong)UILabel *userPhoneLabel;
@property(nonatomic, strong)UILabel *userPlatNumberLabel;
@property(nonatomic, strong)UILabel *serviceLabel;
@property(nonatomic, strong)UILabel *typeLabel;
@property(nonatomic, strong)UIButton *storeNameBtn;
@property(nonatomic, strong)UIView *underView;

- (void)setDatatoDeliveryViews:(FirstUpdateOrFreeChangeInfo *)firstUpdateOrFreeChaneInfo;

@end

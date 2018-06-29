//
//  ToDeliveryView.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/29.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstUpdateOrFreeChangeInfo.h"

@interface ToDeliveryView : UIView<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UILabel *userNameLabel;
@property(nonatomic, strong)UILabel *userPhoneLabel;
@property(nonatomic, strong)UILabel *userPlatNumberLabel;
@property(nonatomic, strong)UILabel *serviceLabel;
@property(nonatomic, strong)UIButton *storeNameBtn;
@property(nonatomic, strong)UIView *underView;
@property(nonatomic, strong)UITableView *tireChangeTableview;
@property(nonatomic, strong)NSMutableArray *changeShoeMutableA;
@property(nonatomic, strong)NSString *tireImgUrlStr;

- (instancetype)initWithFrame:(CGRect)frame change:(NSMutableArray *)changeMutableA;
- (void)setDatatoDeliveryViews:(FirstUpdateOrFreeChangeInfo *)firstUpdateOrFreeChaneInfo;

@end

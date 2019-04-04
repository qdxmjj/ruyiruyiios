//
//  MyCarInfoViewController.h
//  ruyiruyiios
//
//  Created by 姚永敏 on 2019/3/15.
//  Copyright © 2019 ruyiruyi. All rights reserved.
//

#import "RootViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyCarInfoViewController : RootViewController

//请求车辆信息用
@property(nonatomic, copy)NSString *user_car_idStr;


/*是否 可以修改车辆信息  控件是否可编辑
 查看车辆信息  默认都是不可修改
 通过获取下来的 车辆信息状态 来确定 是否可以编辑
 添加车辆  默认都是可以修改
 */
@property(nonatomic, assign)BOOL is_alter;


/*
 是否是由 购买商品页面进入 如果是 则pop返回到购买商品页面
 */
//@property (nonatomic, strong) NSString *

@end

NS_ASSUME_NONNULL_END

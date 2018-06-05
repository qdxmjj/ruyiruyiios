//
//  TabbarView.h
//  TestCommodityInfo
//
//  Created by 小马驾驾 on 2018/5/30.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^selelctSubServiceListBlock)(NSInteger row);

@interface TabbarView : UIView

@property(nonatomic,strong)NSDictionary *serviceList;

@property(nonatomic,copy)selelctSubServiceListBlock serviceBlcok;

@end

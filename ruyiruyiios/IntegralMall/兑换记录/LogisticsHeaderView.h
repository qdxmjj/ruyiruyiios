//
//  LogisticsHeaderView.h
//  ruyiruyiios
//
//  Created by 姚永敏 on 2019/1/16.
//  Copyright © 2019 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LogisticsHeaderView : UIView

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *goodsImg;
@property (nonatomic, copy) NSString *goodsName;

@property (nonatomic, copy) NSString *logisticsName;///快递名
@property (nonatomic, copy) NSString *logisticsNO;///快递单号
@property (nonatomic, copy) NSString *logisticsPhone;///快递电话

@end

NS_ASSUME_NONNULL_END

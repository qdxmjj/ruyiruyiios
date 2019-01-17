//
//  LogisticsModel.h
//  ruyiruyiios
//
//  Created by 姚永敏 on 2019/1/16.
//  Copyright © 2019 ruyiruyi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LogisticsModel : NSObject

///网络获取的
@property (nonatomic, copy) NSString *no;///快递单号

@property (nonatomic, copy) NSString *name;///快递名

@property (nonatomic, copy) NSString *phone;///快递联系电话


///传递到快递页面的 订单信息
@property (nonatomic, copy) NSString *orderNo;///订单号
@property (nonatomic, copy) NSString *orderReceivingAddressId;///订单邮寄地址id
@property (nonatomic, copy) NSString *imgUrl;///商品图片
@property (nonatomic, copy) NSString *goodsName;///商品名

@end

NS_ASSUME_NONNULL_END

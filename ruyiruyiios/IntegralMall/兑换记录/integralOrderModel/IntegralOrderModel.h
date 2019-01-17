//
//  IntegralOrderModel.h
//  ruyiruyiios
//
//  Created by 姚永敏 on 2019/1/16.
//  Copyright © 2019 ruyiruyi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IntegralOrderModel : NSObject

@property (nonatomic, copy) NSString *orderNo;
@property (nonatomic, copy) NSString *orderTime;
///[订单类型ID 1:兑换普通商品订单 2:兑换优惠券订单]
@property (nonatomic, copy) NSString *orderType;
///[订单状态 1 交易完成 2 待收货 3 待商家确认服务 4 作废 5 待发货 6 待车主确认服务 7 待评价 8 待支付 9 正在退款 10 已退款 11 更换审核中 12 更换审核未通过 ,13 审核通过 14 商家拒绝服务 15 用户取消订单]
@property (nonatomic, copy) NSString *orderStatus;
///收货地址id
@property (nonatomic, copy) NSString *orderReceivingAddressId;

/// { "id": 1, "name": "积分商品1", "amount": null, "soldNo": null, "price": 100, "score": 99, "imgUrl": "www.baidu.com", "status": null, "skuType": null, "time": null, "storeId": null, "stockTypeId": null, "serviceTypeId": null, "serviceId": null, "description": "积分商品" }
@property (nonatomic) id scoreSku;

@property (nonatomic, copy) NSString *scoreAddress;

@end

NS_ASSUME_NONNULL_END

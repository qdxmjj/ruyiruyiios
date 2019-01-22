//
//  ShippingAddressController.h
//  ruyiruyiios
//
//  Created by 姚永敏 on 2019/1/4.
//  Copyright © 2019 ruyiruyi. All rights reserved.
//

#import "BaseTableViewController.h"
@class ShippingAddressController;
NS_ASSUME_NONNULL_BEGIN

@protocol ShippingAddressDelegate <NSObject>

- (void)ShippingAddressController:(ShippingAddressController *)viewController selectAddress:(NSDictionary *)addressInfo;

@end

@interface ShippingAddressController : BaseTableViewController

@property(nonatomic,weak)id <ShippingAddressDelegate>delegate;

@property (nonatomic, copy) NSString *selectAddressID;
@end

NS_ASSUME_NONNULL_END

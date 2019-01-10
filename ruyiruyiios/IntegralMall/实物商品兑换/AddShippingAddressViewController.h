//
//  AddShippingAddressViewController.h
//  ruyiruyiios
//
//  Created by 姚永敏 on 2019/1/7.
//  Copyright © 2019 ruyiruyi. All rights reserved.
//

#import "RootViewController.h"
#import "AddressInfoModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void (^refreshAddressListBlock)(void);
@interface AddShippingAddressViewController : RootViewController

@property (nonatomic, copy)refreshAddressListBlock refreshBlock;

- (instancetype)initWithDefault:(NSString *)isDefault;

@property (nonatomic, strong) AddressInfoModel *defaultInfo;
@end

NS_ASSUME_NONNULL_END

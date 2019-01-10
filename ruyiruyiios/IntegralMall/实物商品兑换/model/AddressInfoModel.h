//
//  AddressInfoModel.h
//  ruyiruyiios
//
//  Created by 姚永敏 on 2019/1/7.
//  Copyright © 2019 ruyiruyi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddressInfoModel : NSObject

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *county;
@property (nonatomic, copy) NSString *isDefault;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *address_id;
@end

NS_ASSUME_NONNULL_END

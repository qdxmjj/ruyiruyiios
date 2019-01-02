//
//  HomeActivityModel.h
//  ruyiruyiios
//
//  Created by 姚永敏 on 2018/12/8.
//  Copyright © 2018 ruyiruyi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeActivityModel : NSObject

@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *imageUrl;
@property(nonatomic,copy)NSString *positionIdList;
@property(nonatomic,copy)NSString *positionNameList;
@property(nonatomic,copy)NSString *serviceId;
@property(nonatomic,copy)NSString *skip;
@property(nonatomic,copy)NSString *storeIdList;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *webUrl;


@end

NS_ASSUME_NONNULL_END

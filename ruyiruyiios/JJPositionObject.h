//
//  JJPositionObject.h
//  ruyiruyiios
//
//  Created by 姚永敏 on 2019/5/30.
//  Copyright © 2019 ruyiruyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JJPositionObject : NSObject <CLLocationManagerDelegate>

@property (nonatomic, strong)CLLocationManager *locationManager;

- (void)startPosition;

@end

NS_ASSUME_NONNULL_END

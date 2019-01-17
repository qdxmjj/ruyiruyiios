//
//  GoodsCell.h
//  ruyiruyiios
//
//  Created by 姚永敏 on 2019/1/4.
//  Copyright © 2019 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntegralGoodsMode.h"
#import <UIImageView+WebCache.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodsCell : UITableViewCell

@property (nonatomic, strong) IntegralGoodsMode *model;
@end

NS_ASSUME_NONNULL_END

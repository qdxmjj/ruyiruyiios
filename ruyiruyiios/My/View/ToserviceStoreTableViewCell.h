//
//  ToserviceStoreTableViewCell.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/7/1.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StockOrderVoInfo.h"

@interface ToserviceStoreTableViewCell : UITableViewCell

@property(nonatomic, strong)UIImageView *storeImageV;
@property(nonatomic, strong)UILabel *storeNameLabel;
@property(nonatomic, strong)UILabel *storePriceLabel;
@property(nonatomic, strong)UILabel *storeCountLabel;
@property(nonatomic, strong)UIView *underLineView;

- (void)setdatatoCellViews:(StockOrderVoInfo *)stockOrderInfo;

@end

//
//  ShippingAddressCell.h
//  ruyiruyiios
//
//  Created by 姚永敏 on 2019/1/4.
//  Copyright © 2019 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressInfoModel.h"
@class ShippingAddressCell;
NS_ASSUME_NONNULL_BEGIN

@protocol ShippingAddressCellDelegate <NSObject>

- (void)ClickEditButtonWithShippingAddressCell:(ShippingAddressCell *)cell;

- (void)ClickDeleteButtonWithShippingAddressCell:(ShippingAddressCell *)cell;

@end

@interface ShippingAddressCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UILabel *defaultLab;

@property (weak, nonatomic) id <ShippingAddressCellDelegate> delegate;

@property (nonatomic, strong) AddressInfoModel *model;

@end

NS_ASSUME_NONNULL_END

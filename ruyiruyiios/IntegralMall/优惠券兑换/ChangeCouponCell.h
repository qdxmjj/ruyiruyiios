//
//  ChangeCouponCell.h
//  Menu
//
//  Created by 姚永敏 on 2018/12/25.
//  Copyright © 2018 YYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntegralGoodsMode.h"
@class ChangeCouponCell;
NS_ASSUME_NONNULL_BEGIN
@protocol ChangeCouponCellDelegate <NSObject>

- (void)ClickExchangeButtonWithChangeCouponCell:(ChangeCouponCell *)cell;

@end

@interface ChangeCouponCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImgView;
@property (weak, nonatomic) IBOutlet UIButton *exchangeBtn;
@property (weak, nonatomic) IBOutlet UILabel *titlelab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *stockLab;
@property (weak, nonatomic) IBOutlet UILabel *valueLab;
@property (nonatomic, strong) IntegralGoodsMode *goodsModel;

@property (weak, nonatomic) id <ChangeCouponCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END

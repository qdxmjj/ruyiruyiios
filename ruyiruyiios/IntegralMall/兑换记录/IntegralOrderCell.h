//
//  IntegralOrderCell.h
//  ruyiruyiios
//
//  Created by 姚永敏 on 2019/1/15.
//  Copyright © 2019 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "integralOrderModel/IntegralOrderModel.h"
@class IntegralOrderCell;
NS_ASSUME_NONNULL_BEGIN
@protocol integralOrderCellDelegate <NSObject>

- (void)IntegeralOrderCell:(IntegralOrderCell *)cell orderInfo:(NSDictionary *)info;

@end

@interface IntegralOrderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *orderIDLab;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (weak, nonatomic) IBOutlet UIButton *logisticsBtn;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

///scoreSku 积分商品信息
///积分商品名称
@property (weak, nonatomic) IBOutlet UILabel *scoreGoodsNameLab;
///积分商品图片
@property (weak, nonatomic) IBOutlet UIImageView *scoreGoodsImgView;
///购买所需积分数
@property (weak, nonatomic) IBOutlet UILabel *scoreNumberLab;
///商品价值
@property (weak, nonatomic) IBOutlet UILabel *scoreGoodsValueLab;

@property (weak, nonatomic) id <integralOrderCellDelegate> delegate;

@property (strong, nonatomic) IntegralOrderModel *model;
@end

NS_ASSUME_NONNULL_END

//
//  IntegralOrderCell.m
//  ruyiruyiios
//
//  Created by 姚永敏 on 2019/1/15.
//  Copyright © 2019 ruyiruyi. All rights reserved.
//

#import "IntegralOrderCell.h"
#import "UIView+RoundAngleBorder.h"
#import <UIImageView+WebCache.h>
@interface IntegralOrderCell ()
@property (nonatomic, strong) NSMutableDictionary *orderInfo;
@end
@implementation IntegralOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [self.statusLab roundAngleForSize:CGSizeMake(2, 2) roundAnglePath:UIRectCornerAllCorners borderForColor:LOGINBACKCOLOR borderWidth:1.f];
    [self.logisticsBtn roundAngleForSize:CGSizeMake(2, 2) roundAnglePath:UIRectCornerAllCorners borderForColor:[UIColor blackColor] borderWidth:1.f];
}

- (void)setModel:(IntegralOrderModel *)model{
    
    self.orderIDLab.text = [NSString stringWithFormat:@"%@",model.orderNo];
    self.dateLab.text = [NSString stringWithFormat:@"%@",model.orderTime];
    
    NSDictionary *scoreInfo = model.scoreSku;
    
    [self.orderInfo setValue:[NSString stringWithFormat:@"%@",model.orderNo] forKey:@"orderNo"];
    [self.orderInfo setValue: [NSString stringWithFormat:@"%@",model.orderReceivingAddressId] forKey:@"orderReceivingAddressId"];
    [self.orderInfo setValue:scoreInfo[@"imgUrl"] forKey:@"imgUrl"];
    [self.orderInfo setValue:scoreInfo[@"name"] forKey:@"goodsName"];

    NSMutableAttributedString *newPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",scoreInfo[@"price"]]];
    [newPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, newPrice.length)];
    
    self.scoreGoodsNameLab.text = scoreInfo[@"name"];
    self.scoreNumberLab.text = [NSString stringWithFormat:@"%@",scoreInfo[@"score"]];
    self.scoreGoodsValueLab.attributedText = newPrice;
    [self.scoreGoodsImgView sd_setImageWithURL:[NSURL URLWithString:scoreInfo[@"imgUrl"]]];

    NSInteger orderType = [model.orderType integerValue];
    NSInteger orderStatus = [model.orderStatus integerValue];
    switch (orderType) {
        case 1:
            
            self.contentLab.hidden = YES;
            switch (orderStatus) {
                case 1:
                    self.statusLab.text = @"交易完成";
                    self.logisticsBtn.hidden = NO;
                    break;
                case 2:
                    self.statusLab.text = @"待收货";
                    self.logisticsBtn.hidden = NO;
                    break;
                case 5:
                    self.statusLab.text = @"待发货";
                    self.logisticsBtn.hidden = YES;
                    break;
                default:
                    self.statusLab.text = @"订单异常";
                    self.logisticsBtn.hidden = YES;
                    break;
            }
            break;
        case 2:
            self.logisticsBtn.hidden = YES;
            self.contentLab.hidden = NO;
            self.statusLab.text = @"交易完成";
            break;
        default:
            self.logisticsBtn.hidden = NO;
            self.contentLab.hidden = YES;
            break;
    }
    
}
- (IBAction)lookLogisticsInfoEvent:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(IntegeralOrderCell:orderInfo:)]) {
        
        [self.delegate IntegeralOrderCell:self orderInfo:self.orderInfo];
    }
}

- (NSMutableDictionary *)orderInfo{
    if (!_orderInfo) {
        
        _orderInfo = [NSMutableDictionary dictionary];
        [_orderInfo setObject:@"" forKey:@"orderNo"];
        [_orderInfo setObject:@"" forKey:@"orderReceivingAddressId"];
        [_orderInfo setObject:@"" forKey:@"imgUrl"];
        [_orderInfo setObject:@"" forKey:@"goodsName"];
    }
    return _orderInfo;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

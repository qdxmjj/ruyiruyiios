//
//  OderMiddleView.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/5.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuyTireData.h"
#import "JJUILabel.h"

@interface OderMiddleView : UIView

@property(nonatomic, strong)UIView *h_lineView;
@property(nonatomic, strong)UIImageView *downImageV;
@property(nonatomic, strong)JJUILabel *detailLabel;
@property(nonatomic, strong)UILabel *piceLabel;
@property(nonatomic, strong)UILabel *countLabel;
@property(nonatomic, strong)UIView *b_lineView;
@property(nonatomic, strong)UIButton *cxwyBtn;
@property(nonatomic, strong)UILabel *cxwyCountLabel;

- (void)setMiddleViewData:(BuyTireData *)buyTireData cxwyCount:(NSString *)cxwyCount priceCount:(NSString *)priceCount price:(NSString *)priceStr;

@end

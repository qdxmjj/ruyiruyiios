//
//  TopayBottomView.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/6.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJUILabel.h"
#import "ShoeOrderVo.h"
#import "TobepayInfo.h"

@interface TopayBottomView : UIView

@property(nonatomic, strong)UIImageView *downImageV;
@property(nonatomic, strong)JJUILabel *detailLabel;
@property(nonatomic, strong)UILabel *piceLabel;
@property(nonatomic, strong)UILabel *countLabel;
@property(nonatomic, strong)UIView *b_lineView;
@property(nonatomic, strong)UIButton *cxwyBtn;
@property(nonatomic, strong)UILabel *cxwyCountLabel;
@property(nonatomic, strong)UIView *cb_underView;
@property(nonatomic, strong)UILabel *tirePositionLabel;

- (void)setTopayBottomViewData:(ShoeOrderVo *)shoeOrdervo tobePayinfo:(TobepayInfo *)tobePayinfo;

@end

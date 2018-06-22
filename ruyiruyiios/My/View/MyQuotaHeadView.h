//
//  MyQuotaHeadView.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/22.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyQuotaHeadView : UIView

@property(nonatomic, strong)UIImageView *backImageV;
@property(nonatomic, strong)UILabel *creditLabel;
@property(nonatomic, strong)UILabel *realCreditLabel;
@property(nonatomic, strong)UILabel *shouldRepayLabel;
@property(nonatomic, strong)UILabel *realShouldLabel;
@property(nonatomic, strong)UILabel *remainPayLabel;
@property(nonatomic, strong)UILabel *realRemainLabel;

- (void)setDatatoHeadView:(float)creditFloat remainCredit:(float)remainCreditFloat;

@end

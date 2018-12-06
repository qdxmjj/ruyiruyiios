//
//  MyHeadView.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/7.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyHeadView : UIView

@property(nonatomic, strong)UIImageView *backImageV;
@property(nonatomic, strong)UIButton *headPortraitBtn;
@property(nonatomic, strong)UIButton *nameBtn;
@property(nonatomic, strong)UIButton *myQuotaBtn;
@property(nonatomic, strong)UIButton *creditLineBtn;
@property(nonatomic, strong)UIView *lineView;
@property(nonatomic, strong)UIView *spacingView;
- (void)setDatatoHeadView;

@end

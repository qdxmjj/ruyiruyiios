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
@property(nonatomic, strong)UIImageView *headPortraitImageV;
@property(nonatomic, strong)UILabel *nameLabel;
@property(nonatomic, strong)UIButton *nameAndHeadBtn;
@property(nonatomic, strong)UIButton *myQuotaBtn;
@property(nonatomic, strong)UIButton *creditLineBtn;

- (void)setDatatoHeadView;

@end

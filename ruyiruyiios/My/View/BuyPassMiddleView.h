//
//  BuyPassMiddleView.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/12.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NumberSelectView.h"
#import "BuyCXWYUserInfo.h"

@interface BuyPassMiddleView : UIView

@property(nonatomic, strong)UILabel *nameLabel;
@property(nonatomic, strong)UILabel *phoneLabel;
@property(nonatomic, strong)UILabel *platNumberLabel;
@property(nonatomic, strong)NumberSelectView *buyNumberSelectV;

- (void)setdatatoViews:(BuyCXWYUserInfo *)buyCXWYUserInfo;

@end

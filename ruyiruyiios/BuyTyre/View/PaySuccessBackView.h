//
//  PaySuccessBackView.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/13.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaySuccessBackView : UIView

@property(nonatomic, strong)UIImageView *bigImageV;
@property(nonatomic, strong)UIImageView *smallImageV;
@property(nonatomic, strong)UIImageView *rightImageV;
@property(nonatomic, strong)UILabel *successLabel;

- (void)setDatatoViews;

@end

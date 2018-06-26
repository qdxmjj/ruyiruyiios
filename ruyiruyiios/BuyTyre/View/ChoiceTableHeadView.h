//
//  ChoiceTableHeadView.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/23.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoiceTableHeadView : UIView

@property(nonatomic, strong)UILabel *nameLabel;
@property(nonatomic, strong)UIImageView *rightImageV;
@property(nonatomic, strong)UIButton *statusBtn;

- (void)setdatatoViews:(NSString *)nameStr img:(NSString *)imgStr;
- (void)setbackgroundAndTitleColorAndRightImg:(NSString *)flagStr;

@end

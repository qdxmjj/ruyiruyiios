//
//  ExtensionHeadView.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/20.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExtensionHeadView : UIView

@property(nonatomic, strong)UIImageView *iconImageV;
@property(nonatomic, strong)UILabel *codeLabel;
@property(nonatomic, strong)UIButton *shareBtn;

- (void)setdatatoViews:(NSString *)codeStr;

@end

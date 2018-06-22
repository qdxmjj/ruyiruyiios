//
//  MyCodeView.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/21.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExtensionInfo.h"

@interface MyCodeView : UIView

@property(nonatomic, strong)UIImageView *headImageV;
@property(nonatomic, strong)UILabel *nameLabel;
@property(nonatomic, strong)UIImageView *sexImageV;
@property(nonatomic, strong)UILabel *phoneLabel;
@property(nonatomic, strong)UIImageView *codeImageV;
@property(nonatomic, strong)UIImageView *midImageV;
@property(nonatomic, strong)UILabel *contentLabel;

- (void)setdatatoViews:(ExtensionInfo *)extensionInfo;

@end

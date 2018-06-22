//
//  ExtensionBottomTableViewCell.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/20.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharePersonInfo.h"

@interface ExtensionBottomTableViewCell : UITableViewCell

@property(nonatomic, strong)UILabel *userphoneLabel;
@property(nonatomic, strong)UILabel *statusLabel;
@property(nonatomic, strong)UILabel *joinLabel;

- (void)setdatatoCellSubviews:(SharePersonInfo *)sharePersonInfo;

@end


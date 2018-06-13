//
//  PassImpededTableViewCell.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/12.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PassImpededTableViewCell : UITableViewCell

@property(nonatomic, strong)UIImageView *backGroundImageV;
@property(nonatomic, strong)UILabel *controlTimeLabel;

- (void)setdatatoCellViews;

@end

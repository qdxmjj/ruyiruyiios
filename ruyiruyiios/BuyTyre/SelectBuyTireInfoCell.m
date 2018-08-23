//
//  SelectBuyTireInfoCell.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/8/15.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "SelectBuyTireInfoCell.h"

@implementation SelectBuyTireInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.titleLab.layer.cornerRadius = 5;
    self.titleLab.layer.masksToBounds = true;
    self.titleLab.layer.borderWidth = 1;
}

@end

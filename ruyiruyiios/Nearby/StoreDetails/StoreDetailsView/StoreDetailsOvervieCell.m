//
//  StoreDetailsOvervieCell.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/6.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "StoreDetailsOvervieCell.h"

@implementation StoreDetailsOvervieCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(StoreDetailsModel *)model{
    
    self.gaikuangLab.text = model.storeLocation;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

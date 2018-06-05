//
//  FJStoreServiceListCell.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/5/30.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "FJStoreServiceListCell.h"

@implementation FJStoreServiceListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setCellLabelContent:(YM_FJStoreServiceModel *)model{
    
    self.serviceLab.text = model.name;
    self.serviceLab.textColor = [PublicClass colorWithHexString:model.color];
    self.serviceLab.layer.borderColor = [PublicClass colorWithHexString:model.color].CGColor;
    self.serviceLab.layer.borderWidth = 1;
    self.serviceLab.layer.cornerRadius = 5.0f;
    self.serviceLab.layer.masksToBounds = YES;
}
@end

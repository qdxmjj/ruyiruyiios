//
//  ShippingAddressCell.m
//  ruyiruyiios
//
//  Created by 姚永敏 on 2019/1/4.
//  Copyright © 2019 ruyiruyi. All rights reserved.
//

#import "ShippingAddressCell.h"

@implementation ShippingAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(AddressInfoModel *)model{
    
    self.nameLab.text = [NSString stringWithFormat:@"收货人：%@",model.name];
    self.phoneLab.text = [NSString stringWithFormat:@"%@",model.phone];
    self.addressLab.text = [NSString stringWithFormat:@"收货地址：%@",model.address];
    
    if ([model.isDefault isEqualToString:@"0"]) {
        
        self.defaultLab.hidden = YES;
    }else{
        
        self.defaultLab.hidden = NO;
    }
}

- (IBAction)EditEvent:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ClickEditButtonWithShippingAddressCell:)]) {
        
        [self.delegate ClickEditButtonWithShippingAddressCell:self];
    }
}
- (IBAction)DeleteEvent:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(ClickDeleteButtonWithShippingAddressCell:)]) {
        
        [self.delegate ClickDeleteButtonWithShippingAddressCell:self];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

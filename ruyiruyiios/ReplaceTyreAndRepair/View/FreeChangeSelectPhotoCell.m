//
//  FreeChangeSelectPhotoCell.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/7/4.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "FreeChangeSelectPhotoCell.h"
#import "ZZYPhotoHelper.h"

@implementation FreeChangeSelectPhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (IBAction)selectPhotoEvent:(UIButton *)sender {
    
    
    [[ZZYPhotoHelper shareHelper] showImageViewSelcteWithResultBlock:^(id data) {
        
        [sender setImage:(UIImage *)data forState:UIControlStateNormal];
        
        if ([sender isEqual:self.selectBarCodePhotoBtn]) {
            
            self.delBarCodePhotoBtn.hidden = NO;
        }
        
        if ([sender isEqual:self.selectWearLinePhotoBtn]) {
            
            self.delWearLinePhotoBtn.hidden = NO;
        }
        
    }];
}

- (IBAction)delPhoto:(UIButton *)sender {
    
    if ([sender isEqual:self.delBarCodePhotoBtn]) {
        
        [self.selectBarCodePhotoBtn setImage:nil forState:UIControlStateNormal];
        [self.selectBarCodePhotoBtn.imageView setImage:nil];
    }
    
    if ([sender isEqual:self.delWearLinePhotoBtn]) {
        
        [self.selectWearLinePhotoBtn setImage:nil forState:UIControlStateNormal];
        [self.selectWearLinePhotoBtn.imageView setImage:nil];
    }
   
    sender.hidden = YES;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

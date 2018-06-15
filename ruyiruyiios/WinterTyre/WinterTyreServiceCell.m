//
//  WinterTyreServiceCell.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/13.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "WinterTyreServiceCell.h"
#import <UIImageView+WebCache.h>
@interface WinterTyreServiceCell ()

@property (weak, nonatomic) IBOutlet UIImageView *serviceImg;

@property (weak, nonatomic) IBOutlet UILabel *serviceNameLab;

@end
@implementation WinterTyreServiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

-(void)setModel:(WinterTyreModel *)model{
    
    [self.serviceImg sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"ic_my_shibai"]];
    
    self.serviceNameLab.text = model.name;
}



@end

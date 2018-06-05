//
//  HomeTableViewCell.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/15.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

@synthesize backImageV;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (UIImageView *)backImageV{
    
    if (backImageV == nil) {
        
        backImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, 80)];
    }
    return backImageV;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.backImageV];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

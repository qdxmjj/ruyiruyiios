//
//  FreeChangeSeleceNumberCell.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/7/4.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "FreeChangeSeleceNumberCell.h"
@interface FreeChangeSeleceNumberCell ()


@property(assign,nonatomic) NSInteger number;
@end
@implementation FreeChangeSeleceNumberCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

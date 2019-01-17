//
//  LogisticsCell.m
//  ruyiruyiios
//
//  Created by 姚永敏 on 2019/1/16.
//  Copyright © 2019 ruyiruyi. All rights reserved.
//

#import "LogisticsCell.h"
@interface LogisticsCell ()

@property (weak, nonatomic) IBOutlet UILabel *monthLab;

@property (weak, nonatomic) IBOutlet UIView *pointView;

@end
@implementation LogisticsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

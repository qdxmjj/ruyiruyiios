//
//  SexTableViewCell.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/9.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "SexTableViewCell.h"

@implementation SexTableViewCell{
    
    NSInteger x;
    CGFloat nameW;
    CGFloat top;
}

@synthesize sexLabel;
@synthesize sexButton;
@synthesize underView;
@synthesize jianTouimgV;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (UILabel *)dateLabel{
    
    if (sexLabel == nil) {
        
        x = 20;
        sexLabel = [[UILabel alloc] init];
        sexLabel.text = @"性别";
        sexLabel.textColor = [UIColor blackColor];
        UIFont *fnt = [UIFont fontWithName:TEXTFONT size:20.0];
        sexLabel.font = fnt;
        CGSize size = [sexLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt, NSFontAttributeName, nil]];
        nameW = size.width;
        sexLabel.frame = CGRectMake(x,top, nameW, 20);
    }
    return sexLabel;
}

- (UIButton *)dateButton{
    
    if (sexButton == nil) {
        
        sexButton = [[UIButton alloc] initWithFrame:CGRectMake(nameW + x, top, (MAINSCREEN.width - (nameW + x + 50)), 20)];
        sexButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [sexButton setTitle:@"女发发发发" forState:UIControlStateNormal];
        [sexButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [sexButton addTarget:self action:@selector(chickSexBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return sexButton;
}

- (UIImageView *)jianTouimgV{
    
    if (jianTouimgV == nil) {
        
        jianTouimgV = [[UIImageView alloc] initWithFrame:CGRectMake(MAINSCREEN.width-38, top+3, 10, 15)];
        jianTouimgV.image = [UIImage imageNamed:@"箭头"];
    }
    return jianTouimgV;
}

- (UIView *)underView{
    
    if (underView == nil) {
        
        underView = [[UIView alloc] initWithFrame:CGRectMake(20, 49, MAINSCREEN.width - 20, 0.5)];
        underView.backgroundColor = [UIColor lightGrayColor];
    }
    return underView;
}

- (void)chickSexBtn{
    
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        top = 13.0;
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.dateButton];
        [self.contentView addSubview:self.jianTouimgV];
        [self.contentView addSubview:self.underView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

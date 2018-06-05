//
//  DateTableViewCell.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/9.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "DateTableViewCell.h"
#import "WXZPickDateView.h"

@implementation DateTableViewCell{
    
    NSInteger x;
    CGFloat nameW;
    CGFloat top;
    BOOL isShowDay;
}
@synthesize dateLabel;
@synthesize dateButton;
@synthesize underView;
@synthesize jianTouimgV;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (UILabel *)dateLabel{
    
    if (dateLabel == nil) {
        
        x = 20;
        dateLabel = [[UILabel alloc] init];
        dateLabel.text = @"出生年月";
        dateLabel.textColor = [UIColor blackColor];
        UIFont *fnt = [UIFont fontWithName:TEXTFONT size:20.0];
        dateLabel.font = fnt;
        CGSize size = [dateLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt, NSFontAttributeName, nil]];
        nameW = size.width;
        dateLabel.frame = CGRectMake(x,top, nameW, 20);
    }
    return dateLabel;
}

- (UIButton *)dateButton{
    
    if (dateButton == nil) {
        
        dateButton = [[UIButton alloc] initWithFrame:CGRectMake(nameW + x, top, (MAINSCREEN.width - (nameW + x + 50)), 20)];
        dateButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [dateButton setTitle:@"2017-03-01" forState:UIControlStateNormal];
        [dateButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [dateButton addTarget:self action:@selector(chickDateBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return dateButton;
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

- (void)chickDateBtn{
    
    isShowDay = YES;
    WXZPickDateView *pickerDate = [[WXZPickDateView alloc]init];
    
    [pickerDate setIsAddYetSelect:YES];//是否显示至今选项
    [pickerDate setIsShowDay:isShowDay];//是否显示日信息
    [pickerDate setDefaultTSelectYear:2017 defaultSelectMonth:6 defaultSelectDay:10];//设定默认显示的日期
    [pickerDate setDelegate:self];
    [pickerDate show];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        isShowDay = YES;
        top = 13.0;
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.dateButton];
        [self.contentView addSubview:self.underView];
        [self.contentView addSubview:self.jianTouimgV];
    }
    return self;
}

- (void)pickerDateView:(WXZBasePickView *)pickerDateView selectYear:(NSInteger)year selectMonth:(NSInteger)month selectDay:(NSInteger)day{
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

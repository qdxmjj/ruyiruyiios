//
//  ChoicePatternTableViewCell.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/31.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "ChoicePatternTableViewCell.h"
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>
#import "ShoeSpeedLoadResult.h"

@implementation UIButton(FillColor)

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state{
    
    [self setBackgroundImage:[UIButton imageWithColor:backgroundColor] forState:state];
}

+ (UIImage *)imageWithColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsGetImageFromCurrentImageContext();
    return image;
}

@end
@implementation ChoicePatternTableViewCell

- (UIImageView *)tireImageV{
    
    if (_tireImageV == nil) {
        
        _tireImageV = [[UIImageView alloc] init];
    }
    return _tireImageV;
}

- (UIButton *)leftBtn{
    
    if (_leftBtn == nil) {
        
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.backgroundColor = [UIColor clearColor];
        _leftBtn.tag = 1;
        [_leftBtn addTarget:self action:@selector(chickBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

- (UIButton *)midBtn{
    
    if (_midBtn == nil) {
        
        _midBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _midBtn.backgroundColor = [UIColor clearColor];
        _midBtn.tag = 2;
        [_midBtn addTarget:self action:@selector(chickBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _midBtn;
}

- (UIButton *)rightBtn{
    
    if (_rightBtn == nil) {
        
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.backgroundColor = [UIColor clearColor];
        _rightBtn.tag = 3;
        [_rightBtn addTarget:self action:@selector(chickBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

- (UILabel *)t_descriptionLabel{
    
    if (_t_descriptionLabel == nil) {
        
        _t_descriptionLabel = [[UILabel alloc] init];
        _t_descriptionLabel.textColor = TEXTCOLOR64;
    }
    return _t_descriptionLabel;
}

- (NSMutableArray *)selectTireMutableA{
    
    if (_selectTireMutableA == nil) {
        
        _selectTireMutableA = [[NSMutableArray alloc] init];
    }
    return _selectTireMutableA;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier shoeSpeedList:(NSArray *)array{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.tireImageV];
        [self.contentView addSubview:self.leftBtn];
        [self.contentView addSubview:self.midBtn];
        [self.contentView addSubview:self.rightBtn];
        [self.contentView addSubview:self.t_descriptionLabel];
        self.resultArray = array;
        self.tmpBtn = nil;
        [self addSpeedBtn:array];
    }
    return self;
}

- (void)addSpeedBtn:(NSArray *)speedArray{
    
    for (int p = 0; p<speedArray.count; p++) {
        
        ShoeSpeedLoadResult *shoeResult = [speedArray objectAtIndex:p];
        UIButton *speedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        speedBtn.tag = p;
        speedBtn.frame = CGRectMake(45, 300+40*p, MAINSCREEN.width - 90, 30);
        [speedBtn setTitle:shoeResult.speedLoadStr forState:UIControlStateNormal];
        [speedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        speedBtn.layer.borderColor = [UIColor blackColor].CGColor;
        speedBtn.layer.borderWidth = 1.0;
        speedBtn.layer.cornerRadius = 6.0;
        speedBtn.layer.masksToBounds = YES;
        [speedBtn setBackgroundColor:[PublicClass colorWithHexString:@"#dedede"] forState:UIControlStateNormal];
        [speedBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateSelected];
        [speedBtn addTarget:self action:@selector(chickSpeed:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:speedBtn];
    }
}

- (void)chickSpeed:(UIButton *)button{
    
//    button.selected = !button.selected;
    if (_tmpBtn == nil) {
        
        button.selected = !button.selected;
        _tmpBtn = button;
    }else if (_tmpBtn != nil && _tmpBtn == button){
        
        button.selected = !button.selected;
    }else if (_tmpBtn != button && _tmpBtn != nil){
        
        _tmpBtn.selected = NO;
        button.selected = YES;
        _tmpBtn = button;
    }
    self.block(button.tag);
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.tireImageV.frame = CGRectMake(35, 20, MAINSCREEN.width - 120, 150);
    self.leftBtn.frame = CGRectMake(MAINSCREEN.width - 65, 20, 35, 35);
    self.midBtn.frame = CGRectMake(MAINSCREEN.width - 65, 70, 35, 35);
    self.rightBtn.frame = CGRectMake(MAINSCREEN.width - 65, 120, 35, 35);
    [self.t_descriptionLabel setNumberOfLines:0];
    self.t_descriptionLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:self.t_descriptionLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize labelSize = [self.t_descriptionLabel.text boundingRectWithSize:CGSizeMake(MAINSCREEN.width - 55, MAINSCREEN.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    [self.t_descriptionLabel setFrame:CGRectMake(35, 190, labelSize.width, labelSize.height)];
}

- (void)chickBtn:(UIButton *)button{
    
    switch (button.tag) {
        case 1:
            
            [self.tireImageV sd_setImageWithURL:[NSURL URLWithString:self.c_tirePattern.imgLeftUrl]];
            break;
            
        case 2:
            
            [self.tireImageV sd_setImageWithURL:[NSURL URLWithString:self.c_tirePattern.imgMiddleUrl]];
            break;
            
        case 3:
            
            [self.tireImageV sd_setImageWithURL:[NSURL URLWithString:self.c_tirePattern.imgRightUrl]];
            break;
            
        default:
            break;
    }
}

- (void)setTirePattern:(TirePattern *)tirePattern{
    
    self.c_tirePattern = tirePattern;
    [self.tireImageV sd_setImageWithURL:[NSURL URLWithString:tirePattern.imgLeftUrl]];
    [self.leftBtn sd_setImageWithURL:[NSURL URLWithString:tirePattern.imgLeftUrl] forState:UIControlStateNormal];
    [self.midBtn sd_setImageWithURL:[NSURL URLWithString:tirePattern.imgMiddleUrl] forState:UIControlStateNormal];
    [self.rightBtn sd_setImageWithURL:[NSURL URLWithString:tirePattern.imgRightUrl] forState:UIControlStateNormal];
    self.t_descriptionLabel.text = tirePattern.tire_description;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

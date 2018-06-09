//
//  MyOrderTableViewCell.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/8.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "MyOrderTableViewCell.h"
#import <UIImageView+WebCache.h>

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

@implementation MyOrderTableViewCell

- (UIImageView *)iconImageV{
    
    if (_iconImageV == nil) {
        
        _iconImageV = [[UIImageView alloc] init];
    }
    return _iconImageV;
}

- (JJUILabel *)nameLabel{
    
    if (_nameLabel == nil) {
        
        _nameLabel = [[JJUILabel alloc] init];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont fontWithName:TEXTFONT size:20.0];
        _nameLabel.numberOfLines = 0;
        _nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [_nameLabel setVerticalAlignment:VerticalAlignmentTop];
    }
    return _nameLabel;
}

- (UILabel *)orderNumberLabel{
    
    if (_orderNumberLabel == nil) {
        
        _orderNumberLabel = [[UILabel alloc] init];
        _orderNumberLabel.textColor = [UIColor lightGrayColor];
        _orderNumberLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
    }
    return _orderNumberLabel;
}

- (UILabel *)orderTimeLabel{
    
    if (_orderTimeLabel == nil) {
        
        _orderTimeLabel = [[UILabel alloc] init];
        _orderTimeLabel.textColor = [UIColor lightGrayColor];
        _orderTimeLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
    }
    return _orderTimeLabel;
}

- (UILabel *)priceLabel{
    
    if (_priceLabel == nil) {
        
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = [UIFont fontWithName:TEXTFONT size:18.0];
        _priceLabel.textColor = TEXTCOLOR64;
    }
    return _priceLabel;
}

- (UIButton *)orderStatusBtn{
    
    if (_orderStatusBtn == nil) {
        
        _orderStatusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _orderStatusBtn.layer.cornerRadius = 4.0;
        _orderStatusBtn.layer.masksToBounds = YES;
        _orderStatusBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        [_orderStatusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_orderStatusBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [_orderStatusBtn addTarget:self action:@selector(chickOrderStatusBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _orderStatusBtn;
}

- (void)chickOrderStatusBtn:(UIButton *)button{
    
    self.orderBlock(button.titleLabel.text);
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addViews];
    }
    return self;
}

- (void)addViews{
    
    [self.contentView addSubview:self.iconImageV];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.orderNumberLabel];
    [self.contentView addSubview:self.orderTimeLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.orderStatusBtn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.iconImageV.frame = CGRectMake(10, 15, MAINSCREEN.width/4, 130);
    self.nameLabel.frame = CGRectMake(15+MAINSCREEN.width/4, 15, MAINSCREEN.width-(15+MAINSCREEN.width/4+10), 60);
    self.orderNumberLabel.frame = CGRectMake(self.nameLabel.frame.origin.x, 75, self.nameLabel.frame.size.width, 20);
    self.orderTimeLabel.frame = CGRectMake(self.nameLabel.frame.origin.x, 100, self.nameLabel.frame.size.width, 20);
    self.priceLabel.frame = CGRectMake(self.nameLabel.frame.origin.x, 125, (MAINSCREEN.width - (15+MAINSCREEN.width/4+10))/2, 20);
    self.orderStatusBtn.frame = CGRectMake(self.priceLabel.frame.origin.x+self.priceLabel.frame.size.width, 125, self.priceLabel.frame.size.width, 20);
}

- (void)setCellviewData:(OrderInfo *)orderInfo{
    
    NSString *timeStr = [PublicClass timestampSwitchTime:[orderInfo.orderTime integerValue] andFormatter:@"YYYY-MM-dd HH:mm:ss"];
    [self.iconImageV sd_setImageWithURL:[NSURL URLWithString:orderInfo.orderImage]];
    self.nameLabel.text = orderInfo.orderName;
    self.orderNumberLabel.text = [NSString stringWithFormat:@"%@", orderInfo.orderNo];
    self.orderTimeLabel.text = timeStr;
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %@", orderInfo.orderPrice];
    NSString *statusStr = @"";
    if ([orderInfo.orderType isEqualToString:@"0"]) {
        
        if ([orderInfo.orderState isEqualToString:@"1"]) {
            
            statusStr = @"已安装";
        }else if ([orderInfo.orderState isEqualToString:@"2"]){
            
            statusStr = @"待服务";
        }else if ([orderInfo.orderState isEqualToString:@"3"]){
            
            statusStr = @"交易完成";
        }else if ([orderInfo.orderState isEqualToString:@"4"]){
            
            statusStr = @"支付失败";
        }else if ([orderInfo.orderState isEqualToString:@"5"]){
            
            statusStr = @"待支付";
        }else{
            
            statusStr = @"已退货";
        }
        if ([self.priceLabel.text isEqualToString:@"0.00"]) {
            
            self.priceLabel.hidden = YES;
        }else{
            
            self.priceLabel.hidden = NO;
        }
    }else{
        
        if ([orderInfo.orderState isEqualToString:@"1"]) {
            
            statusStr = @"交易完成";
        }else if ([orderInfo.orderState isEqualToString:@"2"]){
            
            statusStr = @"待收货";
        }else if ([orderInfo.orderState isEqualToString:@"3"]){
            
            statusStr = @"待商家确认服务";
        }else if ([orderInfo.orderState isEqualToString:@"4"]){
            
            statusStr = @"作废";
        }else if ([orderInfo.orderState isEqualToString:@"5"]){
            
            statusStr = @"待发货";
        }else if ([orderInfo.orderState isEqualToString:@"6"]){
            
            statusStr = @"待车主确认服务";
        }else if ([orderInfo.orderState isEqualToString:@"7"]){
            
            statusStr = @"待评价";
        }
        else{
            
            statusStr = @" 待支付";
        }
    }
    [self.orderStatusBtn setTitle:statusStr forState:UIControlStateNormal];
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

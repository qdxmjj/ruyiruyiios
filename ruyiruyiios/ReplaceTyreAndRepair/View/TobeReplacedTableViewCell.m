//
//  TobeReplacedTableViewCell.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/11.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "TobeReplacedTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation TobeReplacedTableViewCell

- (UIImageView *)tireImageV{
    
    if (_tireImageV == nil) {
        
        _tireImageV = [[UIImageView alloc] init];
    }
    return _tireImageV;
}

- (UILabel *)tireNameLabel{
    
    if (_tireNameLabel == nil) {
        
        _tireNameLabel = [[UILabel alloc] init];
        _tireNameLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _tireNameLabel.textColor = TEXTCOLOR64;
    }
    return _tireNameLabel;
}

- (UILabel *)userNameLabel{
    
    if (_userNameLabel == nil) {
        
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _userNameLabel.textColor = TEXTCOLOR64;
    }
    return _userNameLabel;
}

- (UILabel *)buyNumberLabel{
    
    if (_buyNumberLabel == nil) {
        
        _buyNumberLabel = [[UILabel alloc] init];
        _buyNumberLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _buyNumberLabel.textColor = TEXTCOLOR64;
    }
    return _buyNumberLabel;
}

- (UILabel *)usableNumberLabel{
    
    if (_usableNumberLabel == nil) {
        
        _usableNumberLabel = [[UILabel alloc] init];
        _usableNumberLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _usableNumberLabel.textColor = TEXTCOLOR64;
    }
    return _usableNumberLabel;
}

- (UILabel *)serviceObjLabel{
    
    if (_serviceObjLabel == nil) {
        
        _serviceObjLabel = [[UILabel alloc] init];
        _serviceObjLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _serviceObjLabel.textColor = TEXTCOLOR64;
    }
    return _serviceObjLabel;
}

- (UILabel *)positionLabel{
    
    if (_positionLabel == nil) {
        
        _positionLabel = [[UILabel alloc] init];
        _positionLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _positionLabel.textColor = TEXTCOLOR64;
    }
    return _positionLabel;
}

- (UILabel *)orderNumberLabel{
    
    if (_orderNumberLabel == nil) {
        
        _orderNumberLabel = [[UILabel alloc] init];
        _orderNumberLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _orderNumberLabel.textColor = [UIColor lightGrayColor];
    }
    return _orderNumberLabel;
}

- (UIButton *)cancelOrderBtn{
    
    if (_cancelOrderBtn == nil) {
        
        _cancelOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelOrderBtn.layer.borderColor = [LOGINBACKCOLOR CGColor];
        _cancelOrderBtn.layer.borderWidth = 1;
        _cancelOrderBtn.layer.cornerRadius = 4.0;
        _cancelOrderBtn.layer.masksToBounds = YES;
        _cancelOrderBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        [_cancelOrderBtn setTitleColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [_cancelOrderBtn addTarget:self action:@selector(chickCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelOrderBtn;
}

- (void)chickCancelBtn:(UIButton *)button{
    
    
}

- (UIView *)underLineView{
    
    if (_underLineView == nil) {
        
        _underLineView = [[UIView alloc] init];
    }
    return _underLineView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addViews];
    }
    return self;
}

- (void)addViews{
    
    [self.contentView addSubview:self.tireImageV];
    [self.contentView addSubview:self.tireNameLabel];
    [self.contentView addSubview:self.userNameLabel];
    [self.contentView addSubview:self.buyNumberLabel];
    [self.contentView addSubview:self.usableNumberLabel];
    [self.contentView addSubview:self.serviceObjLabel];
    [self.contentView addSubview:self.positionLabel];
    [self.contentView addSubview:self.orderNumberLabel];
    [self.contentView addSubview:self.cancelOrderBtn];
    [self.contentView addSubview:self.underLineView];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.tireImageV.frame = CGRectMake(10, 15, (MAINSCREEN.width - 20)*3/8, 200);
    self.tireNameLabel.frame = CGRectMake(self.tireImageV.frame.origin.x+self.tireImageV.frame.size.width + 10, 15, (MAINSCREEN.width - 20)*5/8 - 10, 20);
    self.userNameLabel.frame = CGRectMake(self.tireNameLabel.frame.origin.x, 40, self.tireNameLabel.frame.size.width, 20);
    self.buyNumberLabel.frame = CGRectMake(self.tireNameLabel.frame.origin.x, 65, self.tireNameLabel.frame.size.width, 20);
    self.usableNumberLabel.frame = CGRectMake(self.tireNameLabel.frame.origin.x, 90, self.tireNameLabel.frame.size.width, 20);
    self.serviceObjLabel.frame = CGRectMake(self.tireNameLabel.frame.origin.x, 115, self.tireNameLabel.frame.size.width, 20);
    self.positionLabel.frame = CGRectMake(self.tireNameLabel.frame.origin.x, 140, self.tireNameLabel.frame.size.width, 20);
    self.orderNumberLabel.frame = CGRectMake(self.tireNameLabel.frame.origin.x, 165, self.tireNameLabel.frame.size.width, 20);
    self.cancelOrderBtn.frame = CGRectMake(MAINSCREEN.width - 70, 190, 60, 30);
    self.underLineView.frame = CGRectMake(0, 232, MAINSCREEN.width, 1);
}

- (void)setDatatoSubviews:(TobeReplaceTireInfo *)tobeReplaceInfo{
    
    [self.tireImageV sd_setImageWithURL:[NSURL URLWithString:tobeReplaceInfo.orderImg]];
    if ([tobeReplaceInfo.fontRearFlag isEqualToNumber:[NSNumber numberWithInt:0]] || [tobeReplaceInfo.fontRearFlag isEqualToNumber:[NSNumber numberWithInt:1]]) {
        
        self.tireNameLabel.text = tobeReplaceInfo.fontShoeName;
        if ([tobeReplaceInfo.fontRearFlag isEqualToNumber:[NSNumber numberWithInt:0]] ) {
            
            self.positionLabel.text = @"位置：前轮/后轮";
        }else{
            
            self.positionLabel.text = @"位置：前轮";
        }
        self.buyNumberLabel.text = [NSString stringWithFormat:@"购买数量：%@", tobeReplaceInfo.fontAmount];
    }else{
        
        self.tireNameLabel.text = tobeReplaceInfo.rearShoeName;
        self.positionLabel.text = @"位置：后轮";
        self.buyNumberLabel.text = [NSString stringWithFormat:@"购买数量：%@", tobeReplaceInfo.rearAmount];
    }
    self.userNameLabel.text = [NSString stringWithFormat:@"联系人：%@", tobeReplaceInfo.name];
    self.usableNumberLabel.text = [NSString stringWithFormat:@"可用数量：%@", tobeReplaceInfo.shoeAvailableNo];
    self.serviceObjLabel.text = [NSString stringWithFormat:@"服务对象：%@", tobeReplaceInfo.platNumber];
    self.orderNumberLabel.text = [NSString stringWithFormat:@"订单编号：%@", tobeReplaceInfo.orderNo];
    [self.cancelOrderBtn setTitle:@"退货" forState:UIControlStateNormal];
    self.underLineView.backgroundColor = [PublicClass colorWithHexString:@"#ececec"];
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

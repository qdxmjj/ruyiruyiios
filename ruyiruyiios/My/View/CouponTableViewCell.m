//
//  CouponTableViewCell.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/20.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "CouponTableViewCell.h"

@implementation CouponTableViewCell

- (CouponLeftView *)leftView{
    
    if (_leftView == nil) {
        
        _leftView = [[CouponLeftView alloc] init];
    }
    return _leftView;
}

- (CouponRightView *)rightView{
    
    if (_rightView == nil) {
        
        _rightView = [[CouponRightView alloc] init];
    }
    return _rightView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [PublicClass colorWithHexString:@"#f1f1f1"];
        [self addSubview:self.leftView];
        [self addSubview:self.rightView];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.leftView.frame = CGRectMake(20, 10, (MAINSCREEN.width - 40)/3, 120);
    self.rightView.frame = CGRectMake(self.leftView.frame.size.width+self.leftView.frame.origin.x, 10, (MAINSCREEN.width - 40)*2/3, 120);
}

- (void)setdatatoViews:(CouponInfo *)couponInfo{
    
    self.leftView.backgroundColor = [UIColor whiteColor];
    self.rightView.backgroundColor = [UIColor whiteColor];
    [self.leftView setdatatoViews:couponInfo];
    [self.rightView setdatatoViews:couponInfo];
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

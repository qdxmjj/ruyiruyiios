//
//  PasswordTableViewCell.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/9.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "PasswordTableViewCell.h"

@implementation PasswordTableViewCell{
    
    NSInteger x;
    CGFloat nameW;
    CGFloat top;
}
@synthesize leftLabel;
@synthesize rightTF;
@synthesize passBtn;
@synthesize underView;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (UILabel *)leftLabel{
    
    if (leftLabel == nil) {
        
        x = 20;
        leftLabel = [[UILabel alloc] init];
        leftLabel.text = @"确认密码";
        CGSize size = [PublicClass getLabelSize:leftLabel fontsize:18.0];
        nameW = size.width;
        leftLabel.frame = CGRectMake(x,top, nameW, 20);
    }
    return leftLabel;
}

- (UITextField *)rightTF{
    
    if (rightTF == nil) {
        
        rightTF = [[UITextField alloc] initWithFrame:CGRectMake(nameW + x, top, (MAINSCREEN.width - (nameW + x + 60)), 20)];
        rightTF.delegate = self;
        rightTF.secureTextEntry = YES;
        rightTF.textColor = [UIColor lightGrayColor];
        rightTF.font = [UIFont fontWithName:TEXTFONT size:16.0];
        rightTF.textAlignment = NSTextAlignmentRight;
    }
    return rightTF;
}

- (UIButton *)passBtn{
    
    if (passBtn == nil) {
        
        passBtn = [[UIButton alloc] initWithFrame:CGRectMake(MAINSCREEN.width - 50, top, 30, 20)];
        [passBtn setBackgroundImage:[UIImage imageNamed:@"不可见"] forState:UIControlStateNormal];
        [passBtn addTarget:self action:@selector(chickPassbtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return passBtn;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    for (UIView *subview in self.contentView.superview.subviews) {
        if ([NSStringFromClass(subview.class) hasSuffix:@"SeparatorView"]) {
            subview.hidden = NO;
            CGRect frame = subview.frame;
            frame.origin.x += self.separatorInset.left;
            frame.size.width -= self.separatorInset.right;
            subview.frame =frame;
        }
    }
}

- (UIView *)underView{
    
    if (underView == nil) {
        
        underView = [[UIView alloc] initWithFrame:CGRectMake(20, 49, MAINSCREEN.width - 20, 0.5)];
        underView.backgroundColor = [UIColor lightGrayColor];
    }
    return underView;
}

- (void)chickPassbtn{
    
    if (rightTF.secureTextEntry == YES) {
        
        rightTF.secureTextEntry = NO;
        [passBtn setBackgroundImage:[UIImage imageNamed:@"可见"] forState:UIControlStateNormal];
    }else{
        
        rightTF.secureTextEntry = YES;
        [passBtn setBackgroundImage:[UIImage imageNamed:@"不可见"] forState:UIControlStateNormal];
    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        top = 13.0;
        [self.contentView addSubview:self.leftLabel];
        [self.contentView addSubview:self.rightTF];
        [self.contentView addSubview:self.passBtn];
        [self.contentView addSubview:self.underView];
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    self.block(self.rightTF.text);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

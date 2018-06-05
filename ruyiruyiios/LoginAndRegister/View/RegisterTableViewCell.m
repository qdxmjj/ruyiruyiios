//
//  RegisterTableViewCell.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/9.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "RegisterTableViewCell.h"

@implementation RegisterTableViewCell{
    
    NSInteger x;
    CGFloat nameW;
    CGFloat width;
    CGFloat top;
}
@synthesize leftLabel;
@synthesize rightTF;
@synthesize underView;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (UILabel *)leftLabel{
    
    if (leftLabel == nil) {
        
        x = 20.0;
        leftLabel = [[UILabel alloc] init];
        leftLabel.textColor = [UIColor blackColor];
        leftLabel.text = @"手机号";
        CGSize size = [PublicClass getLabelSize:leftLabel fontsize:18.0];
        nameW = size.width;
        leftLabel.frame = CGRectMake(x, top, nameW, 20);
    }
    return leftLabel;
}

- (UITextField *)rightTF{
    
    if (rightTF == nil) {
        
        rightTF = [[UITextField alloc] initWithFrame:CGRectMake(nameW + x, top, (MAINSCREEN.width - (nameW + x + 20)), 20.0)];
        rightTF.delegate = self;
        rightTF.textColor = [UIColor lightGrayColor];
        rightTF.font = [UIFont fontWithName:TEXTFONT size:18.0];
        rightTF.textAlignment = NSTextAlignmentRight;
    }
    return rightTF;
}

- (UIView *)underView{
    
    if (underView == nil) {
        
        underView = [[UIView alloc] initWithFrame:CGRectMake(20, 49, MAINSCREEN.width - 20, 0.5)];
        underView.backgroundColor = [UIColor lightGrayColor];
    }
    return underView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        width = self.frame.size.width;
        top = 15;
        [self.contentView addSubview:self.leftLabel];
        [self.contentView addSubview:self.rightTF];
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

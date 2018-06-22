//
//  BottomCarInfoTableViewCell.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/18.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "BottomCarInfoTableViewCell.h"
#import "ZZYPhotoHelper.h"
#import "PhotoBtnView.h"

@implementation BottomCarInfoTableViewCell

- (UIView *)firstView{
    
    if (_firstView == nil) {
        
        _firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, 300)];
        _firstView.backgroundColor = [UIColor whiteColor];
        NSArray *labelNameArray = @[@"行驶里程", @"行驶路况"];
        for (int i = 0; i<labelNameArray.count; i++) {
            
            CGFloat l_height = i*40;
            UILabel *drivelabel = [[UILabel alloc] init];
            drivelabel.frame = CGRectMake(20, 12+l_height, MAINSCREEN.width/2 - 20, 20);
            drivelabel.text = labelNameArray[i];
            drivelabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
            drivelabel.textColor = [UIColor blackColor];
            [_firstView addSubview:drivelabel];
        }
    }
    return _firstView;
}

- (UITextField *)kilometerTF{
    
    if (_kilometerTF == nil) {
        
        _kilometerTF = [[UITextField alloc] initWithFrame:CGRectMake(MAINSCREEN.width/2, 12, MAINSCREEN.width/2 - 20, 20)];
        _kilometerTF.delegate = self;
        _kilometerTF.textColor = [UIColor lightGrayColor];
        _kilometerTF.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _kilometerTF.textAlignment = NSTextAlignmentRight;
        _kilometerTF.placeholder = @"请输入公里数";
    }
    return _kilometerTF;
}

- (UIButton *)roadConditionBtn{
    
    if (_roadConditionBtn == nil) {
        
        _roadConditionBtn = [[UIButton alloc] initWithFrame:CGRectMake(MAINSCREEN.width/2, 45, MAINSCREEN.width/2 - 20, 35)];
        _roadConditionBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _roadConditionBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        [_roadConditionBtn setTitle:@"高速公路；快速公路" forState:UIControlStateNormal];
        [_roadConditionBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _roadConditionBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _roadConditionBtn;
}

//- (UITextField *)invitationTF{
//
//    if (_invitationTF == nil) {
//
//        _invitationTF = [[UITextField alloc] initWithFrame:CGRectMake(MAINSCREEN.width/2, 265, MAINSCREEN.width/2 - 20, 35)];
//        _invitationTF.backgroundColor = [UIColor clearColor];
//        _invitationTF.delegate = self;
//        _invitationTF.text = @"";
//        _invitationTF.font = [UIFont fontWithName:TEXTFONT size:14.0];
//        _invitationTF.textAlignment = NSTextAlignmentRight;
//        _invitationTF.textColor = [UIColor lightGrayColor];
//    }
//    return _invitationTF;
//}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.contentView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.firstView];
        [_firstView addSubview:self.kilometerTF];
        [self addbackView];
        [_firstView addSubview:self.roadConditionBtn];
    }
    return self;
}

- (void)addbackView{
    
    for (int i = 0; i<3; i++) {
        
        CGFloat vHeight = i*40;
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0+vHeight, MAINSCREEN.width, 5)];
        backView.backgroundColor = [UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:0.1];
        [_firstView addSubview:backView];
    }
}

//delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
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

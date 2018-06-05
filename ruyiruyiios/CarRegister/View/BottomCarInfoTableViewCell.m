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

@implementation BottomCarInfoTableViewCell{
    
    CGFloat bottomy;
}

- (UIView *)firstView{
    
    if (_firstView == nil) {
        
        _firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, 300)];
        _firstView.backgroundColor = [UIColor whiteColor];
        NSArray *labelNameArray = @[@"行驶里程", @"上传里程表照片", @"行驶路况"];
        for (int i = 0; i<labelNameArray.count; i++) {
            
            CGFloat l_height = i*40;
            UILabel *drivelabel = [[UILabel alloc] init];
            if (i<2) {
                
                drivelabel.frame = CGRectMake(20, 60+l_height, MAINSCREEN.width/2 - 20, 20);
            }else{
                
                drivelabel.frame = CGRectMake(20, bottomy+l_height+20, MAINSCREEN.width/2 - 20, 20);
            }
            drivelabel.text = labelNameArray[i];
            drivelabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
            drivelabel.textColor = [UIColor blackColor];
            [_firstView addSubview:drivelabel];
        }
        UIView *underLineView = [[UIView alloc] initWithFrame:CGRectMake(20, 46, MAINSCREEN.width - 20, 0.5)];
        underLineView.backgroundColor = [UIColor lightGrayColor];
        [_firstView addSubview:underLineView];
    }
    return _firstView;
}

- (UIButton *)odometerBtn{
    
    if (_odometerBtn == nil) {
        
        _odometerBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 10, MAINSCREEN.width - 20, 20)];
        _odometerBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        [_odometerBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        _odometerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_odometerBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
        [_odometerBtn setImage:[UIImage imageNamed:@"对号"] forState:UIControlStateSelected];
        [_odometerBtn setTitle:@"里程表损坏（以下信息可不填写）" forState:UIControlStateNormal];
        [_odometerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _odometerBtn;
}

- (UITextField *)kilometerTF{
    
    if (_kilometerTF == nil) {
        
        _kilometerTF = [[UITextField alloc] initWithFrame:CGRectMake(MAINSCREEN.width/2, 60, MAINSCREEN.width/2 - 20, 20)];
        _kilometerTF.text = @"";
        _kilometerTF.delegate = self;
        _kilometerTF.backgroundColor = [UIColor clearColor];
        _kilometerTF.textColor = [UIColor lightGrayColor];
        _kilometerTF.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _kilometerTF.textAlignment = NSTextAlignmentRight;
    }
    return _kilometerTF;
}

- (UIButton *)selectImgBtn{
    
    if (_b_selectImgBtn == nil) {
        
        _b_selectImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, bottomy, MAINSCREEN.width/2 - 40, 70)];
        [_b_selectImgBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _b_selectImgBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        [_b_selectImgBtn addTarget:self action:@selector(chickb_SelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _b_selectImgBtn;
}

- (void)chickb_SelectBtn:(UIButton *)button{
    
    [[ZZYPhotoHelper shareHelper] showImageViewSelcteWithResultBlock:^(id data) {
        
        [button setImage:(UIImage *)data forState:UIControlStateNormal];
        _b_deleteBtn.hidden = NO;
    }];
}

- (UIButton *)roadConditionBtn{
    
    if (_roadConditionBtn == nil) {
        
        _roadConditionBtn = [[UIButton alloc] initWithFrame:CGRectMake(MAINSCREEN.width/2, 225, MAINSCREEN.width/2 - 20, 35)];
        _roadConditionBtn.backgroundColor = [UIColor clearColor];
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
        
        bottomy = 135;
        self.contentView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.firstView];
        [_firstView addSubview:self.odometerBtn];
        [_firstView addSubview:self.kilometerTF];
        [self addPictureView];
        [_firstView addSubview:self.selectImgBtn];
        [self addDeleteBtn];
        [self addbackView];
        [_firstView addSubview:self.roadConditionBtn];
    }
    return self;
}

- (void)addPictureView{
    
    PhotoBtnView *phView = [[PhotoBtnView alloc] initWithFrame:CGRectMake(20, bottomy, MAINSCREEN.width/2 - 40, 70)];
    phView.backgroundColor = [UIColor clearColor];
    phView.iconImageV.image = [UIImage imageNamed:@"添加照片"];
    phView.bottomLabel.text = @"添加里程表";
    [_firstView addSubview:phView];
}

- (void)addDeleteBtn{
    
    _b_deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(MAINSCREEN.width/2 - 20 - 13, bottomy, 13, 13)];
    _b_deleteBtn.backgroundColor = [UIColor clearColor];
    _b_deleteBtn.hidden = YES;
    [_b_deleteBtn setImage:[UIImage imageNamed:@"删除照片"] forState:UIControlStateNormal];
    [_b_deleteBtn addTarget:self action:@selector(chickDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_firstView addSubview:_b_deleteBtn];
}

- (void)chickDeleteBtn:(UIButton *)button{
    
    [_b_selectImgBtn setImage:nil forState:UIControlStateNormal];
    button.hidden = YES;
}

- (void)addbackView{
    
    for (int i = 0; i<2; i++) {
        
        CGFloat vHeight = i*40;
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, bottomy+70+15+vHeight, MAINSCREEN.width, 5)];
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

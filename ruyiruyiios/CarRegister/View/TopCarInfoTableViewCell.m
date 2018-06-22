//
//  TopCarInfoTableViewCell.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/18.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "TopCarInfoTableViewCell.h"
#import "ZZYPhotoHelper.h"
#import "PhotoBtnView.h"
#import "SelectBrandViewController.h"

@implementation TopCarInfoTableViewCell{
    
    UIButton *deleteMainBtn;
    CGFloat bottomy;
}

- (UIView *)topView{
    
    if (_topView == nil) {
        
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, 325)];
        _topView.backgroundColor = [UIColor whiteColor];
        NSArray *leftNameArray = @[@"车型", @"是否是新能源汽车", @"车牌号码", @"常驻地区", @"前轮型号", @"后轮型号", @"行驶证注册日期", @"服务截止日期"];
        for (int i = 0; i<leftNameArray.count; i++) {
            
            CGFloat gap = i*40;
            UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10 + gap, MAINSCREEN.width/2 - 20, 20)];
            nameLabel.backgroundColor = [UIColor whiteColor];
            nameLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
            nameLabel.textColor = [UIColor blackColor];
            nameLabel.text = leftNameArray[i];
            UIView *underLineView = [[UIView alloc] initWithFrame:CGRectMake(20, 38+gap, MAINSCREEN.width - 20, 0.5)];
            underLineView.backgroundColor = [UIColor lightGrayColor];
            [_topView addSubview:nameLabel];
            [_topView addSubview:underLineView];
        }
    }
    return _topView;
}

- (UIButton *)typeBtn{
    
    if (_typeBtn == nil) {
        
        _typeBtn = [[UIButton alloc] initWithFrame:CGRectMake(MAINSCREEN.width/2, 0, MAINSCREEN.width/2 - 20, 40)];
        _typeBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        [_typeBtn setTitle:@"一汽奥迪-100" forState:UIControlStateNormal];
        [_typeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _typeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _typeBtn;
}

- (UISwitch *)ison{
    
    if (_ison == nil) {
        
        _ison = [[UISwitch alloc] init];
        _ison.on = NO;
        _ison.frame = CGRectMake(MAINSCREEN.width - 71, 44, 51, 31);
    }
    return _ison;
}

- (UIButton *)platenumBtn{
    
    if (_platenumBtn == nil) {
        
        _platenumBtn = [[UIButton alloc] initWithFrame:CGRectMake(MAINSCREEN.width/2, 80, MAINSCREEN.width/2 - 20, 40)];
        _platenumBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _platenumBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        [_platenumBtn setTitle:@"鲁B 12345" forState:UIControlStateNormal];
        [_platenumBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _platenumBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _platenumBtn;
}

- (UIButton *)residentAreaBtn{
    
    if (_residentAreaBtn == nil) {
        
        _residentAreaBtn = [[UIButton alloc] initWithFrame:CGRectMake(MAINSCREEN.width/2, 120, MAINSCREEN.width/2 - 20, 40)];
        //        _residentAreaBtn.backgroundColor = [UIColor redColor];
        _residentAreaBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _residentAreaBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        [_residentAreaBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _residentAreaBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _residentAreaBtn;
}

- (UIButton *)frontBtn{
    
    if (_frontBtn == nil) {
        
        _frontBtn = [[UIButton alloc] initWithFrame:CGRectMake(MAINSCREEN.width/2, 160, MAINSCREEN.width/2 - 20, 40)];
        _frontBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _frontBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        [_frontBtn setTitle:@"2015/70R15" forState:UIControlStateNormal];
        [_frontBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _frontBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _frontBtn;
}

- (UIButton *)rearBtn{
    
    if (_rearBtn == nil) {
        
        _rearBtn = [[UIButton alloc] initWithFrame:CGRectMake(MAINSCREEN.width/2, 200, MAINSCREEN.width/2 - 20, 40)];
        _rearBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _rearBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        [_rearBtn setTitle:@"2015/70R15" forState:UIControlStateNormal];
        [_rearBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _rearBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _rearBtn;
}

- (UIButton *)drivingBtn{
    
    if (_drivingBtn == nil) {
        
        _drivingBtn = [[UIButton alloc] initWithFrame:CGRectMake(MAINSCREEN.width/2, 240, MAINSCREEN.width/2 - 20, 40)];
        _drivingBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _drivingBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        [_drivingBtn setTitle:@"2017-09-09" forState:UIControlStateNormal];
        [_drivingBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _drivingBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _drivingBtn;
}

- (UIButton *)serviceBtn{
    
    if (_serviceBtn == nil) {
        
        _serviceBtn = [[UIButton alloc] initWithFrame:CGRectMake(MAINSCREEN.width/2, 280, MAINSCREEN.width/2 - 20, 40)];
        _serviceBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _serviceBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        [_serviceBtn setTitle:@"2032-09-08" forState:UIControlStateNormal];
        [_serviceBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _serviceBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _serviceBtn;
}

- (UIView *)bottomView{
    
    if (_bottomView == nil) {
        
        _bottomView = [[UIView alloc] init];
        _bottomView.frame = CGRectMake(0, 325, MAINSCREEN.width, 120);
        _bottomView.backgroundColor = [UIColor whiteColor];
        UILabel *updateLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, MAINSCREEN.width - 20, 20)];
        updateLabel.text = @"上传驾驶证照片";
        updateLabel.textColor = [UIColor blackColor];
        updateLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        [_bottomView addSubview:updateLabel];
    }
    return _bottomView;
}

- (UIButton *)selectImgBtn{
    
    if (_selectImgBtn == nil) {
        
        _selectImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, bottomy, MAINSCREEN.width/2 - 40, 70)];
        _selectImgBtn.tag = 1;
        _selectImgBtn.enabled = YES;
        _selectImgBtn.backgroundColor = [UIColor clearColor];
        [_selectImgBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _selectImgBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        [_selectImgBtn addTarget:self action:@selector(chickSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectImgBtn;
}

- (void)chickSelectBtn:(UIButton *)button{
    
    [[ZZYPhotoHelper shareHelper] showImageViewSelcteWithResultBlock:^(id data) {
            
        deleteMainBtn.hidden = NO;
        [button setImage:(UIImage *)data forState:UIControlStateNormal];
    }];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        bottomy = 35;
        self.contentView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.topView];
        [_topView addSubview:self.typeBtn];
        [_topView addSubview:self.ison];
        [_topView addSubview:self.platenumBtn];
        [_topView addSubview:self.frontBtn];
        [_topView addSubview:self.rearBtn];
        [_topView addSubview:self.drivingBtn];
        [_topView addSubview:self.serviceBtn];
        [_topView addSubview:self.residentAreaBtn];
        [self.contentView addSubview:self.bottomView];
        [self addPictureView];
        [_bottomView addSubview:self.selectImgBtn];
        [self addDeleteBtn];
    }
    return self;
}

- (void)addPictureView{
    
    NSArray *nameArray = @[@"添加主页"];
    for (int i = 0; i<nameArray.count; i++) {
        
        CGFloat photoX = i*MAINSCREEN.width/2;
        PhotoBtnView *phView = [[PhotoBtnView alloc] initWithFrame:CGRectMake(20+photoX, bottomy, MAINSCREEN.width/2 - 40, 70)];
        phView.backgroundColor = [UIColor clearColor];
        phView.iconImageV.image = [UIImage imageNamed:@"添加照片"];
        phView.bottomLabel.text = nameArray[i];
        [_bottomView addSubview:phView];
    }
}

- (void)addDeleteBtn{
    
    for (int i = 0; i<1; i++) {
        
        CGFloat buttonX = i*MAINSCREEN.width/2;
        _deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(MAINSCREEN.width/2 - 20 - 13 + buttonX, bottomy, 13, 13)];
        _deleteBtn.backgroundColor = [UIColor clearColor];
        _deleteBtn.tag = 1000+i;
        _deleteBtn.hidden = YES;
        [_deleteBtn setImage:[UIImage imageNamed:@"删除照片"] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(chickDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
        deleteMainBtn = _deleteBtn;
        [_bottomView addSubview:_deleteBtn];
    }
}

- (void)chickDeleteBtn:(UIButton *)button{
        
    [_selectImgBtn setImage:nil forState:UIControlStateNormal];
    button.hidden = YES;
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

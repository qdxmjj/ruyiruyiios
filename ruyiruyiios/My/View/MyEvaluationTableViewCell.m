//
//  MyEvaluationTableViewCell.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/26.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "MyEvaluationTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "MyEvaluateCollectionViewCell.h"

@implementation MyEvaluationTableViewCell

- (UIImageView *)headImageV{
    
    if (_headImageV == nil) {
        
        _headImageV = [[UIImageView alloc] init];
        _headImageV.layer.cornerRadius = 15.0;
        _headImageV.layer.masksToBounds = YES;
    }
    return _headImageV;
}

- (UILabel *)userNameLabel{
    
    if (_userNameLabel == nil) {
        
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.textColor = TEXTCOLOR64;
        _userNameLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _userNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _userNameLabel;
}

- (UILabel *)timeLabel{
    
    if (_timeLabel == nil) {
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = TEXTCOLOR64;
        _timeLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}

- (UILabel *)detialLabel{
    
    if (_detialLabel == nil) {
        
        _detialLabel = [[UILabel alloc] init];
        _detialLabel.textColor = TEXTCOLOR64;
        _detialLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _detialLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _detialLabel;
}

- (UICollectionView *)imgCollectionV{
    
    if (_imgCollectionV == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _imgCollectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(20, 120, MAINSCREEN.width - 40, 60) collectionViewLayout:flowLayout];
        _imgCollectionV.backgroundColor = [UIColor clearColor];
        _imgCollectionV.dataSource = self;
        _imgCollectionV.delegate = self;
        [_imgCollectionV registerClass:[MyEvaluateCollectionViewCell class] forCellWithReuseIdentifier:@"imgCell"];
    }
    return _imgCollectionV;
}

- (UIImageView *)storeImageV{
    
    if (_storeImageV == nil) {
        
        _storeImageV = [[UIImageView alloc] init];
    }
    return _storeImageV;
}

- (UILabel *)storeNameLabel{
    
    if (_storeNameLabel == nil) {
        
        _storeNameLabel = [[UILabel alloc] init];
        _storeNameLabel.textColor = TEXTCOLOR64;
        _storeNameLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _storeNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _storeNameLabel;
}

- (UILabel *)storeAddressLabel{
    
    if (_storeAddressLabel == nil) {
        
        _storeAddressLabel = [[UILabel alloc] init];
        _storeAddressLabel.textColor = [UIColor lightGrayColor];
        _storeAddressLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _storeAddressLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _storeAddressLabel;
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
        
        [self addUnchangeViews];
        [self addChangeViews];
    }
    return self;
}

- (void)addUnchangeViews{
    
    for (int i = 0; i<5; i++) {
        
        UIImageView *starImageV = [[UIImageView alloc] initWithFrame:CGRectMake(MAINSCREEN.width/2 - 24 + 17*i, 17, 16, 15)];
        starImageV.image = [UIImage imageNamed:@"ic_star"];
        [self addSubview:starImageV];
    }
}

- (void)addChangeViews{
    
    [self.contentView addSubview:self.headImageV];
    [self.contentView addSubview:self.userNameLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.detialLabel];
    [self.contentView addSubview:self.imgCollectionV];
    [self.contentView addSubview:self.storeImageV];
    [self.contentView addSubview:self.storeNameLabel];
    [self.contentView addSubview:self.storeAddressLabel];
    [self.contentView addSubview:self.underLineView];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.headImageV.frame = CGRectMake(20, 10, 30, 30);
    self.userNameLabel.frame = CGRectMake(60, 15, 70, 20);
    self.timeLabel.frame = CGRectMake(MAINSCREEN.width - 90, 15, 80, 20);
    self.detialLabel.frame = CGRectMake(20, 60, MAINSCREEN.width - 20, 50);
    self.storeImageV.frame = CGRectMake(20, 190, 70, 70);
    self.storeNameLabel.frame = CGRectMake(100, 190, MAINSCREEN.width - 100, 20);
    self.storeAddressLabel.frame = CGRectMake(100, 240, MAINSCREEN.width - 100, 20);
    self.underLineView.frame = CGRectMake(0, 267, MAINSCREEN.width, 3);
}

- (void)setdatatoEvaluationCell{
    
    [self.headImageV sd_setImageWithURL:[NSURL URLWithString:[UserConfig headimgurl]]];
    self.userNameLabel.text = [UserConfig nick];
    self.timeLabel.text = @"2018-04-28";
    self.storeImageV.image = [UIImage imageNamed:@"icon"];
    self.detialLabel.text = @"都是环境法谁俄空军纳斯达克卡店面管理规范看没看过开的饭店考虑对方看来是大哥";
    self.storeNameLabel.text = @"小马驾驾22";
    self.storeAddressLabel.text = @"地址：天安数码城";
    self.underLineView.backgroundColor = [PublicClass colorWithHexString:@"#ececec"];
}

#pragma mark UICollectionViewDelegate and UICollectionDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"imgCell";
    MyEvaluateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell setdatatoCollectionCell];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return  CGSizeMake((MAINSCREEN.width - 80)/5,60);
}

#pragma mark  定义每个UICollectionView的横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10;
}

#pragma mark  定义每个UICollectionView的纵向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

#pragma mark  点击CollectionView触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark  设置CollectionViewCell是否可以被点击
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

#pragma mark  定义整个CollectionViewCell与整个View的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);//（上、左、下、右）
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

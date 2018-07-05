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
        _headImageV.frame = CGRectMake(20, 10, 30, 30);
        _headImageV.layer.cornerRadius = 15.0;
        _headImageV.layer.masksToBounds = YES;
    }
    return _headImageV;
}

- (UILabel *)userNameLabel{
    
    if (_userNameLabel == nil) {
        
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.frame = CGRectMake(60, 15, 70, 20);
        _userNameLabel.textColor = TEXTCOLOR64;
        _userNameLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _userNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _userNameLabel;
}

- (UILabel *)timeLabel{
    
    if (_timeLabel == nil) {
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.frame = CGRectMake(MAINSCREEN.width - 90, 15, 80, 20);
        _timeLabel.textColor = TEXTCOLOR64;
        _timeLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}

- (UILabel *)detialLabel{
    
    if (_detialLabel == nil) {
        
        _detialLabel = [[UILabel alloc] init];
        _detialLabel.numberOfLines = 0;
        _detialLabel.text = self.contentStr;
        _detialLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:_detialLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        CGSize detailSize = [_detialLabel.text boundingRectWithSize:CGSizeMake(MAINSCREEN.width - 40, MAINSCREEN.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        _detialLabel.textColor = TEXTCOLOR64;
        _detialLabel.textAlignment = NSTextAlignmentLeft;
        [_detialLabel setFrame:CGRectMake(20, 60, detailSize.width, detailSize.height)];
    }
    return _detialLabel;
}

- (UICollectionView *)imgCollectionV{
    
    if (_imgCollectionV == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _imgCollectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(20, self.detialLabel.frame.size.height + self.detialLabel.frame.origin.y + 15, MAINSCREEN.width - 40, 60) collectionViewLayout:flowLayout];
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
        if (self.imgMutableA.count != 0) {
            
            _storeImageV.frame = CGRectMake(20, self.imgCollectionV.frame.origin.y + self.imgCollectionV.frame.size.height + 15, 70, 70);
        }else{
            
            _storeImageV.frame = CGRectMake(20, self.detialLabel.frame.origin.y + self.detialLabel.frame.size.height + 15, 70, 70);
        }
    }
    return _storeImageV;
}

- (UILabel *)storeNameLabel{
    
    if (_storeNameLabel == nil) {
        
        _storeNameLabel = [[UILabel alloc] init];
        _storeNameLabel.frame = CGRectMake(100, self.storeImageV.frame.origin.y, MAINSCREEN.width - 100, 20);
        _storeNameLabel.textColor = TEXTCOLOR64;
        _storeNameLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _storeNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _storeNameLabel;
}

- (UILabel *)storeAddressLabel{
    
    if (_storeAddressLabel == nil) {
        
        _storeAddressLabel = [[UILabel alloc] init];
        _storeAddressLabel.frame = CGRectMake(100, self.storeImageV.frame.origin.y + 50, MAINSCREEN.width - 100, 20);
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

- (NSMutableArray *)imgMutableA{
    
    if (_imgMutableA == nil) {
        
        _imgMutableA = [[NSMutableArray alloc] init];
    }
    return _imgMutableA;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier content:(NSString *)contentStr imgUrl:(NSArray *)imgUrlA{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.imgMutableA removeAllObjects];
        for (int i = 0; i<imgUrlA.count; i++) {
            
            if (![[imgUrlA objectAtIndex:i] isEqualToString:@""]) {
                
                [self.imgMutableA addObject:[imgUrlA objectAtIndex:i]];
            }
        }
        self.contentStr = contentStr;
        [self addChangeViews];
    }
    return self;
}

- (void)addUnchangeViews:(int)number{
    
    for (int i = 0; i<number; i++) {
        
//        UIImageView *starImageV = [[UIImageView alloc] initWithFrame:CGRectMake(MAINSCREEN.width/2 - 24 + 17*i, 17, 16, 15)];
//        starImageV.image = [UIImage imageNamed:@"ic_star"];
        UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        selectButton.frame = CGRectMake(MAINSCREEN.width/2 - 24 + 17*i, 17, 16, 15);
        [selectButton setBackgroundImage:[UIImage imageNamed:@"ic_star"] forState:UIControlStateSelected];
        selectButton.selected = YES;
        [self addSubview:selectButton];
    }
    for (int j = number; j<5; j++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(MAINSCREEN.width/2 - 24 + 17*j, 17, 16, 15);
        [button setBackgroundImage:[UIImage imageNamed:@"ic_huistar"] forState:UIControlStateNormal];
        [self addSubview:button];
    }
}

- (void)addChangeViews{
    
    [self.contentView addSubview:self.headImageV];
    [self.contentView addSubview:self.userNameLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.detialLabel];
    [self.contentView addSubview:self.storeImageV];
    [self.contentView addSubview:self.storeNameLabel];
    [self.contentView addSubview:self.storeAddressLabel];
    [self.contentView addSubview:self.underLineView];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
}

- (void)setdatatoEvaluationCell:(MyEvaluationInfo *)myEvaluationInfo{
    
    [self addUnchangeViews:[myEvaluationInfo.starNo intValue]];
    NSString *timeStr = [PublicClass timestampSwitchTime:[myEvaluationInfo.time integerValue] andFormatter:@"YYYY-MM-dd"];
    [self.headImageV sd_setImageWithURL:[NSURL URLWithString:myEvaluationInfo.storeCommitUserHeadImg]];
    self.userNameLabel.text = myEvaluationInfo.storeCommitUserName;
    self.timeLabel.text = timeStr;
    [self.storeImageV sd_setImageWithURL:[NSURL URLWithString:myEvaluationInfo.storeImg]];
    self.detialLabel.text = myEvaluationInfo.content;
    self.storeNameLabel.text = myEvaluationInfo.storeName;
    self.storeAddressLabel.text = [NSString stringWithFormat:@"地址：%@", myEvaluationInfo.storeLocation];
    if (self.imgMutableA.count != 0) {
        
        [self.contentView addSubview:self.imgCollectionV];
    }
    self.underLineView.frame = CGRectMake(0, self.storeAddressLabel.frame.origin.y + 27, MAINSCREEN.width, 3);
    self.underLineView.backgroundColor = [PublicClass colorWithHexString:@"#ececec"];
    self.cellHeight = self.underLineView.frame.size.height + self.underLineView.frame.origin.y;
//    NSLog(@"%f", self.cellHeight);
}

#pragma mark UICollectionViewDelegate and UICollectionDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [self.imgMutableA count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"imgCell";
    MyEvaluateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell setdatatoCollectionCell:[self.imgMutableA objectAtIndex:indexPath.row]];
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

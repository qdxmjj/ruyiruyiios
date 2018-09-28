//
//  InstallStoreTableViewCell.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/11.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "InstallStoreTableViewCell.h"
#import "FirstUpdateCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@implementation InstallStoreTableViewCell

- (UILabel *)installStoreLabel{
    
    if (_installStoreLabel == nil) {
        
        _installStoreLabel = [[UILabel alloc] init];
        _installStoreLabel.text = @"安装门店";
        _installStoreLabel.textAlignment = NSTextAlignmentLeft;
        _installStoreLabel.textColor = [UIColor blackColor];
        _installStoreLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
    }
    return _installStoreLabel;
}

- (UIImageView *)rightImageV{
    
    if (_rightImageV == nil) {
        
        _rightImageV = [[UIImageView alloc] init];
        _rightImageV.image = [UIImage imageNamed:@"ic_right"];
    }
    return _rightImageV;
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
        _storeNameLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _storeNameLabel.textColor = TEXTCOLOR64;
        _storeNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _storeNameLabel;
}

- (UILabel *)locationLabel{
    
    if (_locationLabel == nil) {
        
        _locationLabel = [[UILabel alloc] init];
        _locationLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _locationLabel.textColor = [UIColor lightGrayColor];
        _locationLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _locationLabel;
}

- (UILabel *)distanceLabel{
    
    if (_distanceLabel == nil) {
        
        _distanceLabel = [[UILabel alloc] init];
        _distanceLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _distanceLabel.textColor = [UIColor lightGrayColor];
        _distanceLabel.textAlignment = NSTextAlignmentRight;
    }
    return _distanceLabel;
}

- (UICollectionView *)functionCollectionV{
    
    if (_functionCollectionV == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _functionCollectionV = [[UICollectionView alloc] initWithFrame:CGRectMake((MAINSCREEN.width - 30)*3/8 + 30, 75, (MAINSCREEN.width - ((MAINSCREEN.width - 30)*3/8 +30 +20)), 60) collectionViewLayout:flowLayout];
        _functionCollectionV.backgroundColor = [UIColor clearColor];
        _functionCollectionV.delegate = self;
        _functionCollectionV.dataSource = self;
        [_functionCollectionV registerClass:[FirstUpdateCollectionViewCell class] forCellWithReuseIdentifier:@"funtionCell"];
    }
    return _functionCollectionV;
}

- (NSMutableArray *)functionMutableA{
    
    if (_functionMutableA == nil) {
        
        _functionMutableA = [[NSMutableArray alloc] init];
    }
    return _functionMutableA;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addViews];
    }
    return self;
}

- (void)addViews{
    
    [self.contentView addSubview:self.installStoreLabel];
    [self.contentView addSubview:self.rightImageV];
    [self.contentView addSubview:self.storeImageV];
    [self.contentView addSubview:self.storeNameLabel];
    [self.contentView addSubview:self.functionCollectionV];
    [self.contentView addSubview:self.locationLabel];
    [self.contentView addSubview:self.distanceLabel];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.installStoreLabel.frame = CGRectMake(20, 15, MAINSCREEN.width/2 - 20, 20);
    self.rightImageV.frame = CGRectMake(MAINSCREEN.width - 32, 15, 10, 18);
    self.storeImageV.frame = CGRectMake(20, 50, 110, 110);
    self.storeNameLabel.frame = CGRectMake((MAINSCREEN.width - 30)*3/8 + 30, 50, (MAINSCREEN.width - ((MAINSCREEN.width - 30)*3/8 +30 +20)), 20);
    self.locationLabel.frame = CGRectMake(self.storeNameLabel.frame.origin.x, 140, self.storeNameLabel.frame.size.width/2, 20);
    self.distanceLabel.frame = CGRectMake(MAINSCREEN.width - (self.storeNameLabel.frame.size.width/2 + 10), 140, self.storeNameLabel.frame.size.width/2, 20);
}

- (void)setDatatoInstallStoreCellStoreInfo:(StoreInfo *)storeInfo{
    
    [self.storeImageV sd_setImageWithURL:[NSURL URLWithString:storeInfo.storeImg]];
    self.storeNameLabel.text = storeInfo.storeName;
    self.locationLabel.text = storeInfo.storeAddress;
    self.distanceLabel.text = [NSString stringWithFormat:@"%.1fkm", ([storeInfo.distance floatValue])/1000];
    [self.functionCollectionV reloadData];
}

#pragma mark UICollectionViewDelegate and UICollectionDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [self.functionMutableA count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"funtionCell";
    FirstUpdateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    StoreServiceInfo *storeServiceInfo = [self.functionMutableA objectAtIndex:indexPath.item];
    [cell setDatatoBtn:storeServiceInfo];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return  CGSizeMake(64,20);
}

#pragma mark  定义每个UICollectionView的横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10;
}

#pragma mark  定义每个UICollectionView的纵向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10;
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

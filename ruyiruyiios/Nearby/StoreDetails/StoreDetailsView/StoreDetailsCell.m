//
//  StoreDetailsCell.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/5.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "StoreDetailsCell.h"
#import <UIImageView+WebCache.h>
#import <UIView+MJExtension.h>
#import "StoreDetailsCollectionViewCell.h"
#import "SDPhotoBrowser.h"
#define collectionViewH  self.collectionView.frame.size.height;

@interface StoreDetailsCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SDPhotoBrowserDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentImgh;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property(nonatomic,strong)NSArray *assessImgDataArr;

@end
@implementation StoreDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([StoreDetailsCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"storeDetailsCollectionCellID"];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (self.assessImgDataArr.count>0) {

        return self.assessImgDataArr.count;
    }
    
    return 0;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    StoreDetailsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"storeDetailsCollectionCellID" forIndexPath:indexPath];
    
    [cell.assessImageView sd_setImageWithURL:[NSURL URLWithString:self.assessImgDataArr[indexPath.row]] placeholderImage:[UIImage imageNamed:@"ic_my_shibai"]];
    
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return CGSizeMake((self.contentView.mj_w-80-20)/3, 50);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    
    //设置容器视图,父视图
    browser.sourceImagesContainerView = self.collectionView;
    
    browser.currentImageIndex = indexPath.item;
    
    browser.imageCount = self.assessImgDataArr.count;
    
    //设置代理
    browser.delegate = self;
    //显示图片浏览器
    [browser show];
    
}

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index

{
    //拿到显示的图片的高清图片地址
    NSURL *url = [NSURL URLWithString:self.assessImgDataArr[index]];
    return url;
}

//返回占位图片
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    
    StoreDetailsCollectionViewCell *cell = (StoreDetailsCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    
    return cell.assessImageView.image;
}

- (void)addUnchangeViews:(int)number{
    
    for (int i = 0; i<number; i++) {
        
        //        UIImageView *starImageV = [[UIImageView alloc] initWithFrame:CGRectMake(MAINSCREEN.width/2 - 24 + 17*i, 17, 16, 15)];
        //        starImageV.image = [UIImage imageNamed:@"ic_star"];
        UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        selectButton.frame = CGRectMake(0 + 17*i, 0, 16, 15);
        [selectButton setBackgroundImage:[UIImage imageNamed:@"ic_star"] forState:UIControlStateSelected];
        selectButton.selected = YES;
        [self.starView addSubview:selectButton];
    }
    for (int j = number; j<5; j++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0 + 17*j, 0, 16, 15);
        [button setBackgroundImage:[UIImage imageNamed:@"ic_huistar"] forState:UIControlStateNormal];
        [self.starView addSubview:button];
    }
}

-(void)setAssessContentModel:(StoreAssessModel *)model{
    
    [self.storeAssessUserHeadImg sd_setImageWithURL:[NSURL URLWithString: model.storeCommitUserHeadImg]];
    
    self.storeAssessContent.text =model.content;
    
    self.storeAssessTime.text = [PublicClass timestampSwitchTime:[model.time integerValue] andFormatter:@"YYYY-MM-dd"];
    
    self.storeAssessUserName.text = model.storeCommitUserName;
    
    self.assessImgDataArr = model.contentimgArr;
    
    if (model.contentimgArr.count>3) {
        
        self.contentImgh.constant = 50*2+30.f;
        
    }else if (model.contentimgArr.count==0){
        
        self.contentImgh.constant = 0;
        
    }else{
        
        self.contentImgh.constant = 70;
    }
    
    [self addUnchangeViews:[model.starNo intValue]];
    [self.collectionView reloadData];
}

-(NSArray *)assessImgDataArr{
    
    if (!_assessImgDataArr) {
        
        _assessImgDataArr = [NSArray array];
    }
    
    return _assessImgDataArr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end

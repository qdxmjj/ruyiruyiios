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

#define collectionViewH  self.collectionView.frame.size.height;

@interface StoreDetailsCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
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

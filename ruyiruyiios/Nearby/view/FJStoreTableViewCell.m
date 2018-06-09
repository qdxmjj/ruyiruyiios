//
//  FJStoreTableViewCell.m
//  TestOrdersType
//
//  Created by 小马驾驾 on 2018/5/29.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "FJStoreTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "YM_FJStoreServiceModel.h"
#import "FJStoreServiceListCell.h"
@interface FJStoreTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property(nonatomic,strong)NSArray *serviceListArr;

@end

@implementation FJStoreTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FJStoreServiceListCell class]) bundle:nil] forCellWithReuseIdentifier:@"FjStoreCollectionVIewCellID"];
}

-(void)layoutSubviews{
    
    self.storeImg.layer.cornerRadius = 5;
    self.storeImg.layer.masksToBounds = YES;
    
    self.storeType.layer.cornerRadius = 3;
    self.storeType.layer.masksToBounds = YES;
}

-(void)setCellDataModel:(YM_FjStoreModel *)model{
    
    [self.storeImg sd_setImageWithURL:[NSURL URLWithString:model.storeImg]];
    self.storeName.text = model.storeName;
    self.storeType.text = model.storeType;
    self.storeType.backgroundColor = [PublicClass colorWithHexString:model.storeTypeColor];
    self.storeAddress.text =[NSString stringWithFormat:@"地址：%@",model.storeAddress];
    
    if (![model.distance isEqualToString:@""]) {
        
        self.storeDistance.text = [NSString stringWithFormat:@"%@km", model.distance];
    }
    self.serviceListArr = model.serviceList;
    if (self.serviceListArr.count>0) {
            [self.collectionView reloadData];
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (self.serviceListArr.count>0) {

        return self.serviceListArr.count;
    }

    return 5;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    FJStoreServiceListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FjStoreCollectionVIewCellID" forIndexPath:indexPath];
    
    YM_FJStoreServiceModel *model = [[YM_FJStoreServiceModel alloc] init];

    [model setValuesForKeysWithDictionary:[self.serviceListArr[indexPath.row]objectForKey:@"service"]];

    [cell setCellLabelContent:model];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
 
    return CGSizeMake((self.collectionView.frame.size.width-20)/3, self.collectionView.frame.size.height);
}

-(NSArray *)serviceListArr{
    
    if (!_serviceListArr) {
        
        _serviceListArr = [NSArray array];
    }
    
    return _serviceListArr;
}
@end


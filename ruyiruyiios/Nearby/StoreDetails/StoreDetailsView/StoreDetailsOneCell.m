//
//  StoreDetailsOneCell.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/6.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "StoreDetailsOneCell.h"
#import "UIView+extension.h"
#import "StoreHeadCollectionViewCell.h"
@interface StoreDetailsOneCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property(nonatomic,strong)NSArray *serviceList;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewH;

@end
@implementation StoreDetailsOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[StoreHeadCollectionViewCell class] forCellWithReuseIdentifier:@"storeHeadViewCollectionCellID"];

}
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    StoreHeadCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"storeHeadViewCollectionCellID" forIndexPath:indexPath];
    
    cell.itemLab.text =[[self.serviceList[indexPath.row] objectForKey:@"service"] objectForKey:@"name"];
    
    cell.itemLab.textColor = [PublicClass colorWithHexString:[[self.serviceList[indexPath.row] objectForKey:@"service"] objectForKey:@"color"]];
    
    cell.itemLab.layer.borderWidth = 1.f;
    
    cell.itemLab.layer.borderColor = [[PublicClass colorWithHexString:[[self.serviceList[indexPath.row] objectForKey:@"service"] objectForKey:@"color"]] CGColor];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (self.serviceList.count>0) {
        
        return self.serviceList.count;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //行间距 5 三个item 六个列间距 30 collectionview距离右侧为80
    return CGSizeMake((self.width-30-80)/3, 25);
}

-(void)setModel:(StoreDetailsModel *)model{
    
    self.storeName.text = model.storeName;
    self.storeAddress.text = model.storeAddress;
    self.storetype.text = model.storeType;
    self.storetype.backgroundColor = [PublicClass colorWithHexString:model.storeTypeColor];
    self.serviceList = model.storeServcieList;
    
    CGFloat distance = [model.distance floatValue];
    self.distance.text =[NSString stringWithFormat:@"%.2fkm",distance/1000.f];
    if (self.serviceList.count>3) {

        self.collectionViewH.constant = 60;
    }
    
    [self.collectionView reloadData];
}

-(NSArray *)serviceList{
    
    if (!_serviceList) {
        
        _serviceList = [NSArray array];
    }
    
    return _serviceList;
}
@end

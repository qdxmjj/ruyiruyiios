//
//  FJStoreToppingView.m
//  ruyiruyiios
//
//  Created by 姚永敏 on 2018/10/22.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "FJStoreToppingView.h"
#import "FJStoreToppingCell.h"
#import <UIImageView+WebCache.h>
@interface FJStoreToppingView () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)UILabel *titleLab;

@property(nonatomic,strong)UIView *lineView;

@end
@implementation FJStoreToppingView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.lineView];
        [self addSubview:self.collectionView];
        [self addSubview: self.titleLab];
    }
    return self;
}

-(void )setToppingStoreArr:(NSArray *)toppingStoreArr{
    _toppingStoreArr = toppingStoreArr;
    
    if (self.collectionView) {
        
        [self.collectionView reloadData];
    }
}

-(UIView *)lineView{
    
    if (!_lineView) {
        //有情况 不显示热门门店 而tableviw分组自带间隔线 所以再此做个假的间隔线
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 2)];
        _lineView.backgroundColor = [UIColor colorWithRed:230.f/255.f green:230.f/255.f blue:230.f/255.f alpha:1.f];
    }
    return _lineView;
}
-(UILabel *)titleLab{
    
    if (!_titleLab) {
        
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(16, 7, CGRectGetWidth(self.frame), 20)];
        _titleLab.text = @"热门门店";
        _titleLab.font = [UIFont systemFontOfSize:15.f];
    }
    
    return _titleLab;
}

-(UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        // 设置最小行间距
        layout.minimumLineSpacing = 10;
        // 最小列间距
        layout.minimumInteritemSpacing = 20;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,27, CGRectGetWidth(self.frame), self.frame.size.height-30) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate =self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FJStoreToppingCell class]) bundle:nil] forCellWithReuseIdentifier:@"FJStoreToppingCellID"];
    }
    return _collectionView;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    FJStoreToppingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FJStoreToppingCellID" forIndexPath:indexPath];
    
    [cell.toppingStoreImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.toppingStoreArr[indexPath.item] objectForKey:@"storeImg"]]]];
    
    cell.toppingStoreNameLab.text = [self.toppingStoreArr[indexPath.item] objectForKey:@"storeName"];
    
    NSString *distance = [self.toppingStoreArr[indexPath.item] objectForKey:@"distance"];
    
    if (![distance isEqualToString:@""]) {
        
        [cell.toppingStoreDistanceBtn setTitle:[NSString stringWithFormat:@" %.2f公里", [distance floatValue]/1000] forState:UIControlStateNormal];
        [cell.toppingStoreDistanceBtn setImage:[UIImage imageNamed:@"ic_weizhi"] forState:UIControlStateNormal];
    }else{
        [cell.toppingStoreDistanceBtn setTitle:@"" forState:UIControlStateNormal];
        [cell.toppingStoreDistanceBtn setImage:nil forState:UIControlStateNormal];
    }

    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (self.toppingStoreArr.count>0) {
        
        return self.toppingStoreArr.count;
    }
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(toppingDidSelectItemAtIndexPath:)]) {
        
        [self.delegate toppingDidSelectItemAtIndexPath:indexPath];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(80, 90);
}

@end

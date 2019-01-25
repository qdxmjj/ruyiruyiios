//
//  HeadView.m
//  TestCommodityInfo
//
//  Created by 小马驾驾 on 2018/5/30.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "HeadView.h"
#import "FJStoreServiceListCell.h"
@interface HeadView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *titleLab;

@end

@implementation HeadView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRed:255.f/255.f green:102.f/255.f blue:35.f/255.f alpha:1.f];
        
        [self addSubview:self.backBtn];
        [self addSubview:self.titleLab];
        [self addSubview:self.storeImg];
        [self addSubview:self.storeName];
        [self addSubview:self.itemBtn];
        [self addSubview:self.collectionView];
    }
    return self;
}

- (void)layoutSubviews{

    [self.backBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.leading.mas_equalTo(self.mas_leading).inset(10);
        if (getRectStatusHight >20) {
            make.top.mas_equalTo(self.mas_top).inset(30);
        }else{
            make.top.mas_equalTo(self.mas_top).inset(20);
        }
        make.width.height.mas_equalTo(CGSizeMake(30, 40));
    }];
    
    [self.titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.backBtn.mas_centerY);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
    }];
    
    [self.storeImg mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.leading.mas_equalTo(self.mas_leading).inset(10);
        make.top.mas_equalTo(self.backBtn.mas_bottom).inset(5);
        make.width.mas_equalTo(self.frame.size.width/5);
        make.bottom.mas_equalTo(self.mas_bottom).inset(5);
    }];
    
    [self.itemBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.trailing.mas_equalTo(self.mas_trailing).inset(16);
        make.width.height.mas_equalTo(CGSizeMake(20, 25));
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    
    [self.storeName mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.leading.mas_equalTo(self.storeImg.mas_trailing).inset(10);
        make.top.mas_equalTo(self.storeImg.mas_top);
        make.trailing.mas_equalTo(self.itemBtn.mas_leading).inset(10);
        make.height.mas_equalTo(20);
    }];

    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.storeName.mas_bottom);
        make.leading.mas_equalTo(self.storeImg.mas_trailing).inset(10);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.trailing.mas_equalTo(self.mas_trailing).inset(16);
    }];
}

-(UIButton *)backBtn{
    
    if (!_backBtn) {
        
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"ic_back"] forState:UIControlStateNormal];
    }
    return _backBtn;
}

- (UILabel *)titleLab{
    if (!_titleLab) {
        
        _titleLab = [[UILabel alloc] init];
        _titleLab.text = @"门店详情";
        _titleLab.font = [UIFont systemFontOfSize:17.f];
        _titleLab.textColor = [UIColor whiteColor];
    }
    return _titleLab;
}
-(void)setServiceTypeList:(NSArray *)serviceTypeList{
    _serviceTypeList = serviceTypeList;
}


-(UIImageView *)storeImg{
    
    if (!_storeImg) {
        _storeImg = [[UIImageView alloc] init];
        _storeImg.backgroundColor = [UIColor orangeColor];
    }
    return _storeImg;
}

-(UILabel *)storeName{
    
    if (!_storeName) {
        
        _storeName = [[UILabel alloc] init];
        _storeName.textColor = [UIColor whiteColor];
        
    }
    return _storeName;
}

-(UIButton *)itemBtn{
    
    if (!_itemBtn) {
        
        _itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_itemBtn setImage:[UIImage imageNamed:@"ic_bai"] forState:UIControlStateNormal];
    }
    return _itemBtn;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 1;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor colorWithWhite:1.f alpha:0.f];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FJStoreServiceListCell class]) bundle:nil] forCellWithReuseIdentifier:@"StoreDetailsServiceListCellID"];
    }
    
    return _collectionView;
}
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    FJStoreServiceListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StoreDetailsServiceListCellID" forIndexPath:indexPath];
    
    cell.serviceLab.text = self.serviceTypeList[indexPath.item][@"service"][@"name"];
    cell.serviceLab.textColor = [PublicClass colorWithHexString:self.serviceTypeList[indexPath.item][@"service"][@"color"]];
    cell.serviceLab.backgroundColor = [UIColor whiteColor];
    cell.serviceLab.layer.cornerRadius = 3;
    cell.serviceLab.layer.masksToBounds = YES;
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.serviceTypeList.count>0) {
        
        return self.serviceTypeList.count;
    }
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return CGSizeMake(80, 20);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    
    return UIEdgeInsetsMake(5, 0, 5, 0);
}

@end

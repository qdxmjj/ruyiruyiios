//
//  EntranceView.m
//  ruyiruyiios
//
//  Created by 姚永敏 on 2018/12/7.
//  Copyright © 2018 ruyiruyi. All rights reserved.
//

#import "EntranceView.h"
#import <Masonry.h>
#import "EntranceCell.h"
@interface EntranceView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSArray *nameArray ;
    NSArray *imgArray ;
}
@property(nonatomic,strong)UICollectionView *collectionView;
@end
@implementation EntranceView
-(instancetype)init{
    
    if (self = [super init]) {
        
        nameArray = @[@"轮胎购买", @"免费更换", @"免费修补", @"待更换轮胎"];
        imgArray = @[@"轮胎购买", @"免费更换", @"免费修补", @"ic_icon4"];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.mas_equalTo(self);
        }];

    }
    return self;
}

-(UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 10;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([EntranceCell class]) bundle:nil] forCellWithReuseIdentifier:@"EntranceCellID"];
    }
    return _collectionView;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    EntranceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EntranceCellID" forIndexPath:indexPath];
    cell.imgView.image = [UIImage imageNamed:imgArray[indexPath.item]];
    cell.titleLab.text = nameArray[indexPath.item];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (nameArray.count>0) {
        
        return nameArray.count;
    }
    return 0;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((self.frame.size.width-50)/4, self.frame.size.height);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.delegate respondsToSelector:@selector(EntranceView:didSelectItemAtIndexPath:)]) {
        
        [self.delegate EntranceView:self didSelectItemAtIndexPath:indexPath];
    }
}
@end

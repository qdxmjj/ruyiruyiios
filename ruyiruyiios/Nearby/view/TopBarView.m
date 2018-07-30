//
//  TopBarView.m
//  TestOrdersType
//
//  Created by 小马驾驾 on 2018/5/28.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "TopBarView.h"
#import "TopBarCollectionViewCell.h"
@interface TopBarView()<UICollectionViewDelegate,UICollectionViewDataSource>


@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSArray *dataArr;

@end

@implementation TopBarView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.collectionView];
    }
    return self;
}


-(void)setConditionArr:(NSArray *)conditionArr{
    
    
    self.dataArr = conditionArr;
    [self.collectionView reloadData];

}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (self.dataArr.count>0) {
        
        return self.dataArr.count;
    }
    
    return 0;
}



- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *identify = @"topBarCollectionViewCellID";

    TopBarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    
    cell.titleLab.text = [self.dataArr[indexPath.row] allKeys][0];

    return cell;
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TopBarCollectionViewCell *cell = (TopBarCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    
    self.textBlock = ^(NSString *text) {
        
        cell.titleLab.text = text;
    };
    
    if ([self.delegate respondsToSelector:@selector(clickExpandView:menuData:didSelectIndex:)]) {
        
        NSString *key = [self.dataArr[indexPath.row] allKeys][0];
        
        NSArray *menuDataArr = [self.dataArr[indexPath.row] objectForKey:key];
        
        [self.delegate clickExpandView:self menuData:menuDataArr didSelectIndex:indexPath.row];
    }
}


-(UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        CGRect collectionViewFrame= CGRectMake(0, 0,self.frame.size.width, self.frame.size.height);
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        // 设置UICollectionView为横向滚动
//        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        // 每一行cell之间的间距
        flowLayout.minimumLineSpacing = 10;
        
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
    
        //左右间距20+20  cell间距10+10
        flowLayout.itemSize = CGSizeMake((self.frame.size.width-40-20)/3, self.frame.size.height);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.scrollsToTop = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([TopBarCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"topBarCollectionViewCellID"];

    }
    

    
    return _collectionView;
}





@end

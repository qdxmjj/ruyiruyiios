//
//  RealThingViewController.m
//  Menu
//
//  Created by 姚永敏 on 2018/12/24.
//  Copyright © 2018 YYM. All rights reserved.
//

#import "RealThingViewController.h"
#import "RealThingCell.h"

#import "GoodsDetailsViewController.h"
@interface RealThingViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation RealThingViewController

- (void)viewWillAppear:(BOOL)animated{
    
    UIView * barBackground = self.navigationController.navigationBar.subviews.firstObject;
    if (@available(iOS 11.0, *))
    {
        barBackground.alpha = 0;
        [barBackground.subviews setValue:@(0) forKeyPath:@"alpha"];
    } else {
        barBackground.alpha = 0;
    }
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
- (void)viewWillDisappear:(BOOL)animated{
    
    UIView * barBackground = self.navigationController.navigationBar.subviews.firstObject;
    if (@available(iOS 11.0, *))
    {
        barBackground.alpha = 1;
        [barBackground.subviews setValue:@(1) forKeyPath:@"alpha"];
    } else {
        barBackground.alpha = 1;
    }
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"积分兑换";

    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeAll;
    }
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([RealThingCell class]) bundle:nil] forCellWithReuseIdentifier:@"RealThingCellID"];
    
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    RealThingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RealThingCellID" forIndexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodsDetailsViewController *vc = [[GoodsDetailsViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 4;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return CGSizeMake((self.view.frame.size.width-20)/2, (self.view.frame.size.width-20)/2 * 1.1);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    
    return UIEdgeInsetsMake(3, 5, 5, 5);
}
@end

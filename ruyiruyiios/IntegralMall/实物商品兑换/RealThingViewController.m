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
@property (weak, nonatomic) IBOutlet UILabel *integralLab;

@property (strong, nonatomic) NSMutableArray *goodsArr;
@property (copy, nonatomic) NSString *integral;
@end

@implementation RealThingViewController

- (instancetype)initWithIntegral:(NSString *)integral{
    self = [super init];
    if (self) {
        
        self.integral = integral;
    }
    return self;
}

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
    
    self.integralLab.text = self.integral;
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([RealThingCell class]) bundle:nil] forCellWithReuseIdentifier:@"RealThingCellID"];
    
    [JJRequest getRequest:[NSString stringWithFormat:@"%@/score/sku",INTEGRAL_IP] params:@{@"skuType":@"0"} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        if ([code integerValue] == 1) {
            
            for (NSDictionary *dic in data) {
                
                IntegralGoodsMode *model = [[IntegralGoodsMode alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [self.goodsArr addObject:model];
            }
            
            [self.collectionView reloadData];
        }
        NSLog(@"实物积分商品：%@",data);
    } failure:^(NSError * _Nullable error) {
        
    }];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    RealThingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RealThingCellID" forIndexPath:indexPath];
    IntegralGoodsMode *model = self.goodsArr[indexPath.item];
    cell.goodsModel = model;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    IntegralGoodsMode *model = self.goodsArr[indexPath.item];

    GoodsDetailsViewController *vc = [[GoodsDetailsViewController alloc] initWithIntegralGoodsMode:model];
    
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.goodsArr.count>0) {
        
        return self.goodsArr.count;
    }
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return CGSizeMake((self.view.frame.size.width-20)/2, (self.view.frame.size.width-20)/2 * 1.1);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    
    return UIEdgeInsetsMake(3, 5, 5, 5);
}

- (NSMutableArray *)goodsArr{
    if (!_goodsArr) {
        _goodsArr = [NSMutableArray array];
    }
    return _goodsArr;
}
@end

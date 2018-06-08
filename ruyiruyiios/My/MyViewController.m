//
//  MyViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/8.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "MyViewController.h"
#import "MyHeadView.h"
#import "MyOrderView.h"
#import "MyBottomCollectionViewCell.h"
#import "ManageCarViewController.h"

@interface MyViewController ()<UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong)UIScrollView *mainScrollV;
@property(nonatomic, strong)MyHeadView *myHeadview;
@property(nonatomic, strong)MyOrderView *myOrderview;
@property(nonatomic, strong)UICollectionView *myCollectionV;
@property(nonatomic, strong)NSArray *titleArray;
@property(nonatomic, strong)NSArray *imgArray;

@end

@implementation MyViewController

- (void)viewWillAppear:(BOOL)animated{
    
    self.hidesBottomBarWhenPushed = NO;
    self.navigationController.navigationBar.hidden = YES;
}

- (UIScrollView *)mainScrollV{
    
    if (_mainScrollV == nil) {
        
        _mainScrollV = [[UIScrollView alloc] init];
        _mainScrollV.frame = CGRectMake(0, -20, MAINSCREEN.width, MAINSCREEN.height - 20);
        _mainScrollV.showsVerticalScrollIndicator = NO;
        _mainScrollV.showsHorizontalScrollIndicator = NO;
        _mainScrollV.bounces = NO;
        _mainScrollV.scrollsToTop = NO;
        _mainScrollV.tag = 1;
        _mainScrollV.delegate = self;
    }
    return _mainScrollV;
}

- (MyHeadView *)myHeadview{
    
    if (_myHeadview == nil) {
        
        _myHeadview = [[MyHeadView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, 215)];
    }
    return _myHeadview;
}

- (MyOrderView *)myOrderview{
    
    if (_myOrderview == nil) {
        
        _myOrderview = [[MyOrderView alloc] initWithFrame:CGRectMake(0, 216, MAINSCREEN.width, 114)];
        _myOrderview.topayBtn.tag = 1001;
        _myOrderview.todeliveryBtn.tag = 1002;
        _myOrderview.toserviceBtn.tag = 1003;
        _myOrderview.completedBtn.tag = 1004;
        [_myOrderview.topayBtn addTarget:self action:@selector(chickOrderViewBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _myOrderview;
}

- (UICollectionView *)myCollectionV{
    
    if (_myCollectionV == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _myCollectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 330, MAINSCREEN.width, 250) collectionViewLayout:flowLayout];
        _myCollectionV.backgroundColor = [UIColor clearColor];
        _myCollectionV.delegate = self;
        _myCollectionV.dataSource = self;
        _myCollectionV.scrollEnabled = YES;
        [_myCollectionV registerClass:[MyBottomCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _myCollectionV;
}

- (void)chickOrderViewBtn:(UIButton *)button{
    
    switch (button.tag) {
            
        case 1001:
            
            break;
            
        case 1002:
            
            break;
            
        case 1003:
            
            break;
            
        case 1004:
            
            break;
            
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleArray = @[@"带更换轮胎", @"畅行无忧", @"我的宝驹", @"优惠券", @"推广码", @"评价", @"设置"];
    self.imgArray = @[@"ic_daigenghuan", @"ic_changxing", @"ic_wodeche", @"ic_youhuiquan", @"ic_tuiguang", @"ic_pingjia", @"ic_shezhi"];
    
    [self.view addSubview:self.mainScrollV];
    [self addView];
    // Do any additional setup after loading the view.
}

- (void)addView{
    
    [_mainScrollV addSubview:self.myHeadview];
    [_mainScrollV addSubview:self.myOrderview];
    [_mainScrollV addSubview:self.myCollectionV];
    [_mainScrollV setContentSize:CGSizeMake(MAINSCREEN.width, self.myCollectionV.frame.size.height+self.myCollectionV.frame.origin.y)];
    [self setDatatoViews];
}

- (void)setDatatoViews{
    
    [_myHeadview setDatatoHeadView:@"1000" creditLine:@"1000"];
}


#pragma mark UICollectionViewDelegate and UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.titleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"cell";
    MyBottomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.iconImageView.image = [UIImage imageNamed:[self.imgArray objectAtIndex:indexPath.item]];
    cell.titleLabel.text = [self.titleArray objectAtIndex:indexPath.item];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return  CGSizeMake((MAINSCREEN.width - 40)/3,80);
}

#pragma mark  定义每个UICollectionView的横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

#pragma mark  定义每个UICollectionView的纵向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

#pragma mark  点击CollectionView触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // 0--update 1--not worry 2--my car 3--youhuiquan 4--extension code 5--valuetion 6--setting
    if (indexPath.item == 0) {
        
    }else if (indexPath.item == 1){
        
    }else if (indexPath.item == 2){
        
        ManageCarViewController *manageCarVC = [[ManageCarViewController alloc] init];
        [self.navigationController pushViewController:manageCarVC animated:YES];
    }else if (indexPath.item == 3){
        
    }else if (indexPath.item == 4){
        
    }else if (indexPath.item == 5){
        
    }else{
        
    }
}

#pragma mark  设置CollectionViewCell是否可以被点击
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

#pragma mark  定义整个CollectionViewCell与整个View的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 20, 0, 20);//（上、左、下、右）
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

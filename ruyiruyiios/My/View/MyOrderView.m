//
//  MyOrderView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/7.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "MyOrderView.h"
#import <Masonry.h>
#import "OrderTypeCell.h"
#define OrderWidth MAINSCREEN.width
@interface MyOrderView () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong)UICollectionView *collectionView;

@end
@implementation MyOrderView

- (UIButton *)lookAllOrderBtn{
    
    if (_lookAllOrderBtn == nil) {
        
        _lookAllOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _lookAllOrderBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:15];
        _lookAllOrderBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_lookAllOrderBtn setTitle:@"查看全部订单" forState:UIControlStateNormal];
        [_lookAllOrderBtn setTitleColor:TEXTCOLOR64 forState:UIControlStateNormal];
        [_lookAllOrderBtn setImage:[UIImage imageNamed:@"ic_right"] forState:UIControlStateNormal];
        [_lookAllOrderBtn setImageEdgeInsets:UIEdgeInsetsMake(0, MAINSCREEN.width/2 - 30 -12, 0, 0)];
        [_lookAllOrderBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 45)];
    }
    return _lookAllOrderBtn;
}

-(UICollectionView *)collectionView{
    
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([OrderTypeCell class]) bundle:nil] forCellWithReuseIdentifier:@"OrderTypeCellID"];
    }
 
    return _collectionView;
}
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addChangeView];
    }
    return self;
}


- (void)addChangeView{
  
    [self addSubview:self.lookAllOrderBtn];
    [self addSubview:self.collectionView];
    
    UILabel *myOrderLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, MAINSCREEN.width/2, 20)];
    myOrderLabel.text = @"我的订单";
    myOrderLabel.textAlignment = NSTextAlignmentCenter;
    myOrderLabel.textColor = [UIColor blackColor];
    myOrderLabel.font = [UIFont fontWithName:TEXTFONT size:15];
    [self addSubview:myOrderLabel];
    
    UIView *orderLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39, MAINSCREEN.width, 2)];
    orderLineView.backgroundColor = [PublicClass colorWithHexString:@"#ececec"];
    [self addSubview:orderLineView];
    
    UIView *underLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 110, MAINSCREEN.width, 5)];
    underLineView.backgroundColor = [PublicClass colorWithHexString:@"#ececec"];
    [self addSubview:underLineView];
    
    [myOrderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.width.mas_equalTo(self.mas_width).multipliedBy(.5);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.35);
    }];
    [self.lookAllOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.mas_top);
        make.right.mas_equalTo(self.mas_right);
        make.width.mas_equalTo(self.mas_width).multipliedBy(.5);
        make.height.mas_equalTo(self.mas_height).multipliedBy(.35);
    }];
    
    [orderLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(myOrderLabel.mas_bottom);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(2);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(orderLineView.mas_bottom);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.65).offset(-2);
    }];


    [underLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.mas_bottom);
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(2);
    }];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    OrderTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OrderTypeCellID" forIndexPath:indexPath];
    NSArray *imgArr = @[@"m_ic_wait",@"ic_fahuo",@"ic_fuwu",@"ic_done"];
    NSArray *titleArr = @[@"待支付",@"进行中",@"待服务",@"已完成"];

    cell.imgView.image = [UIImage imageNamed:imgArr[indexPath.item]];
    cell.titleLab.text = titleArr[indexPath.item];

    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.delegate respondsToSelector:@selector(myOrderView:cellForItemAtIndexPath:)]) {
        
        [self.delegate myOrderView:self cellForItemAtIndexPath:indexPath];
    }
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    return 4;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return CGSizeMake((self.collectionView.frame.size.width - 80)/4, self.collectionView.frame.size.height);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsMake(0, 10, 0, 10);
}
@end

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
#import "MyOrderViewController.h"
#import "TobeReplacedTiresViewController.h"
//#import "PassImpededViewController.h"//旧的畅行无忧
#import "SmoothJourneyViewController.h"//新畅行无忧
#import "PersonalInformationViewController.h"
#import "MySettingViewController.h"
#import "CouponViewController.h"
#import "ExtensionCodeViewController.h"
#import "InvitedGiftViewController.h"

#import "MyEvaluationViewController.h"
#import "MyQuotaViewController.h"
#import "CreditLineViewController.h"
#import "CodeLoginViewController.h"
#import "DelegateConfiguration.h"
#import "ContactCustomerViewController.h"

#import "IntegralViewController.h"

#import "WithdrawViewController.h"
#import "WXApi.h"
#import <Masonry.h>
@interface MyViewController ()<UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, LoginStatusDelegate,ClickOrderDelegate>

@property(nonatomic, strong)MyHeadView *myHeadview;
@property(nonatomic, strong)MyOrderView *myOrderview;
@property(nonatomic, strong)UICollectionView *myCollectionV;
@property(nonatomic, strong)NSArray *titleArray;
@property(nonatomic, strong)NSArray *imgArray;

@end

@implementation MyViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    DelegateConfiguration *delegateConfiguration = [DelegateConfiguration sharedConfiguration];
    [delegateConfiguration registerLoginStatusChangedListener:self];
    
    if (![WXApi isWXAppInstalled]){
        
        self.titleArray = @[@"我的钱包",@"待更换轮胎", @"畅行无忧", @"我的宝驹", @"优惠券", @"评价", @"设置", @"联系客服"];
        self.imgArray = @[@"ic_redbag",@"ic_daigenghuan", @"ic_changxing", @"ic_wodeche", @"ic_youhuiquan", @"ic_pingjia", @"ic_shezhi", @"ic_lianxi"];

    }else{
        self.titleArray = @[@"我的钱包",@"待更换轮胎", @"畅行无忧", @"我的宝驹", @"优惠券", @"推广有礼", @"评价", @"设置", @"联系客服"];
        self.imgArray = @[@"ic_redbag",@"ic_daigenghuan", @"ic_changxing", @"ic_wodeche", @"ic_youhuiquan", @"ic_tuiguang", @"ic_pingjia", @"ic_shezhi", @"ic_lianxi"];
    }
    
    [self addView];
}
- (void)addView{
    
    [self.view addSubview:self.myHeadview];
    [self.view addSubview:self.myOrderview];
    [self.view addSubview:self.myCollectionV];
    
    [self.myHeadview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.view.mas_top);
        make.left.and.right.mas_equalTo(self.view);
        make.height.mas_equalTo(MAINSCREEN.height/3);
    }];
    [self.myOrderview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.myHeadview.mas_bottom);
        make.left.and.right.mas_equalTo(self.view);
        make.height.mas_equalTo(MAINSCREEN.height/6);
    }];
    [self.myCollectionV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.myOrderview.mas_bottom);
        make.left.and.right.mas_equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.view.mas_bottom);
        }
    }];
    
    [self setDatatoViews];
}
- (void)setDatatoViews{
    
    [_myHeadview setDatatoHeadView];
}

- (MyHeadView *)myHeadview{
    
    if (_myHeadview == nil) {
        
        _myHeadview = [[MyHeadView alloc] init];
        [_myHeadview.headPortraitBtn addTarget:self action:@selector(chickNameAndHeadBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_myHeadview.nameBtn addTarget:self action:@selector(chickNameAndHeadBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_myHeadview.myQuotaBtn addTarget:self action:@selector(chickMyquotaBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_myHeadview.creditLineBtn addTarget:self action:@selector(chickCreaditLineBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _myHeadview;
}

- (MyOrderView *)myOrderview{
    
    if (_myOrderview == nil) {
        
        _myOrderview = [[MyOrderView alloc] init];
        _myOrderview.delegate = self;
        [_myOrderview.lookAllOrderBtn addTarget:self action:@selector(chickOrderViewBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _myOrderview;
}

- (UICollectionView *)myCollectionV{
    
    if (_myCollectionV == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumLineSpacing = 10;
        _myCollectionV = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _myCollectionV.backgroundColor = [UIColor clearColor];
        _myCollectionV.delegate = self;
        _myCollectionV.dataSource = self;
        _myCollectionV.scrollEnabled = YES;
        [_myCollectionV registerClass:[MyBottomCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _myCollectionV;
}


- (void)chickNameAndHeadBtn:(UIButton *)button{
    
    if ([UserConfig user_id] == NULL || [[NSString stringWithFormat:@"%@", [UserConfig user_id]] isEqualToString:@""]) {
                
        CodeLoginViewController *loginVC = [[CodeLoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }else{
        
        PersonalInformationViewController *personInfoVC = [[PersonalInformationViewController alloc] init];
        personInfoVC.updateViewBlock = ^(NSString *update) {
            
            [self setDatatoViews];
        };
        [self.navigationController pushViewController:personInfoVC animated:YES];
    }
}

- (void)chickMyquotaBtn:(UIButton *)button{
    
    if ([UserConfig user_id] == NULL) {
        
        [self alertIsloginView];
    }else{
        
        MyQuotaViewController *myQuotaVC = [[MyQuotaViewController alloc] init];
        [self.navigationController pushViewController:myQuotaVC animated:YES];
    }
}

- (void)chickCreaditLineBtn:(UIButton *)button{
    
    if ([UserConfig user_id] == NULL) {
        
        [self alertIsloginView];
    }else{
        
        CreditLineViewController *creditLineVC = [[CreditLineViewController alloc] init];
        [self.navigationController pushViewController:creditLineVC animated:YES];
    }
}

-(void)myOrderView:(MyOrderView *)view cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([UserConfig user_id] == NULL) {
        
        [self alertIsloginView];
        return;
    }
    
    MyOrderViewController *myOrderVC = [[MyOrderViewController alloc] init];
    // 1--topay  2--todelivery  3--toservice  4--completed  0--lookAllOrderBtn

    switch (indexPath.item) {
        case 0:
            myOrderVC.statusStr = @"1";
            break;
        case 1:
            myOrderVC.statusStr = @"2";
            break;
        case 2:
            myOrderVC.statusStr = @"3";
            break;
        case 3:
            myOrderVC.statusStr = @"4";
            break;
        default:
            break;
    }
    
    [self.navigationController pushViewController:myOrderVC animated:YES];
}

- (void)chickOrderViewBtn:(UIButton *)button{
    
    if ([UserConfig user_id] == NULL) {
        
        [self alertIsloginView];
    }else{
        MyOrderViewController *myOrderVC = [[MyOrderViewController alloc] init];

        myOrderVC.statusStr = @"0";
        [self.navigationController pushViewController:myOrderVC animated:YES];
    }
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
    
//    1/3+1/6
    
    CGFloat HEIGHT = MAINSCREEN.height;
    
    CGFloat itemH = (HEIGHT - (HEIGHT/3+HEIGHT/6)-Height_TabBar)/3;
    return  CGSizeMake((MAINSCREEN.width - 40)/3,itemH);
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
    if ([UserConfig user_id] == NULL) {
        
        [self alertIsloginView];
    }else{
        if (indexPath.item == 0) {
            WithdrawViewController *withdrawVC = [[WithdrawViewController alloc] init];
            [self.navigationController pushViewController:withdrawVC animated:YES];

        }else if (indexPath.item == 1) {
            
            TobeReplacedTiresViewController *tobeReplacedVC = [[TobeReplacedTiresViewController alloc] init];
            [self.navigationController pushViewController:tobeReplacedVC animated:YES];
        }else if (indexPath.item == 2){
            
            SmoothJourneyViewController *smoothJourneyVC = [[SmoothJourneyViewController alloc] init];
            [self.navigationController pushViewController:smoothJourneyVC animated:YES];
        }else if (indexPath.item == 3){
            
            ManageCarViewController *manageCarVC = [[ManageCarViewController alloc] init];
            [self.navigationController pushViewController:manageCarVC animated:YES];
        }else if (indexPath.item == 4){
            
            CouponViewController *couponVC = [[CouponViewController alloc] init];
            [self.navigationController pushViewController:couponVC animated:YES];
        }else if (indexPath.item == 5){
            
            if (![WXApi isWXAppInstalled]){

                MyEvaluationViewController *myEvaluationVC = [[MyEvaluationViewController alloc] init];
                [self.navigationController pushViewController:myEvaluationVC animated:YES];
            }else{
                InvitedGiftViewController *extensionVC = [[InvitedGiftViewController alloc] init];
                [self.navigationController pushViewController:extensionVC animated:YES];
            }
        }else if (indexPath.item == 6){
            
            if (![WXApi isWXAppInstalled]){
                
                MySettingViewController *mysettingVC = [[MySettingViewController alloc] init];
                [self.navigationController pushViewController:mysettingVC animated:YES];
            }else{
                MyEvaluationViewController *myEvaluationVC = [[MyEvaluationViewController alloc] init];
                [self.navigationController pushViewController:myEvaluationVC animated:YES];
            }
            
        }else if (indexPath.item == 7){
            
            if (![WXApi isWXAppInstalled]){
                //此为联系客服 临时更改为 积分商城
                IntegralViewController *contactCustomerVC = [[IntegralViewController alloc] init];
                [self.navigationController pushViewController:contactCustomerVC animated:YES];
            }else{
                MySettingViewController *mysettingVC = [[MySettingViewController alloc] init];
                [self.navigationController pushViewController:mysettingVC animated:YES];
            }
        }else{
            
            if ([WXApi isWXAppInstalled]){
                
                ContactCustomerViewController *contactCustomerVC = [[ContactCustomerViewController alloc] init];
                [self.navigationController pushViewController:contactCustomerVC animated:YES];
            }
        }
    }
}

#pragma mark  设置CollectionViewCell是否可以被点击
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

#pragma mark  定义整个CollectionViewCell与整个View的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsMake(0, 10, 0, 10);//（上、左、下、右）
}

//LoginStatusDelegate
- (void)updateLoginStatus{
    
    [self setDatatoViews];
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

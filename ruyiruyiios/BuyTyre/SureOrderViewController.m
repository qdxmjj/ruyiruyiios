//
//  SureOrderViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/30.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "SureOrderViewController.h"
#import "OrderHeadView.h"
#import "OderMiddleView.h"
#import "OderBottomView.h"
#import "CashierViewController.h"
#import "ShoeOrderInfo.h"
#import "MBProgressHUD+YYM_category.h"
@interface SureOrderViewController ()<UIScrollViewDelegate>

@property(nonatomic, strong)UIScrollView *mainScrollView;
@property(nonatomic, strong)OrderHeadView *orderheadView;
@property(nonatomic, strong)OderMiddleView *oderMiddleView;
@property(nonatomic, strong)OderBottomView *oderBottomView;
@property(nonatomic, strong)NSString *allTotalPriceStr;
@property(nonatomic, strong)NSString *tireTotalPriceStr;
@property(nonatomic, strong)NSString *cxwyTotalPriceStr;
@property(nonatomic, strong)ShoeOrderInfo *shoeOrderInfo;


@end

@implementation SureOrderViewController
@synthesize shoeSpeedLoadResult;
@synthesize tireCount;
@synthesize buyTireData;
@synthesize cxwyCount;
@synthesize fontRearFlag;
@synthesize cxwyAllpriceStr;

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (UIScrollView *)mainScrollView{
    
    if (_mainScrollView == nil) {
        
        _mainScrollView = [[UIScrollView alloc] init];
        _mainScrollView.frame = CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height - SafeDistance - 125);
        _mainScrollView.backgroundColor = [UIColor clearColor];
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.bounces = NO;
        _mainScrollView.scrollsToTop = NO;
        _mainScrollView.delegate = self;
    }
    return _mainScrollView;
}

- (OrderHeadView *)orderheadView{
    
    if (_orderheadView == nil) {
        
        _orderheadView = [[OrderHeadView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, 120)];
    }
    return _orderheadView;
}

- (OderMiddleView *)oderMiddleView{
    
    if (_oderMiddleView == nil) {
        
        _oderMiddleView = [[OderMiddleView alloc] initWithFrame:CGRectMake(0, 121, MAINSCREEN.width, 260)];
    }
    return _oderMiddleView;
}

- (OderBottomView *)oderBottomView{
    
    if (_oderBottomView == nil) {
        
        _oderBottomView = [[OderBottomView alloc] initWithFrame:CGRectMake(0, MAINSCREEN.height - SafeDistance - 125, MAINSCREEN.width, 125)];
        [_oderBottomView.sureBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [_oderBottomView.sureBtn addTarget:self action:@selector(chickSureBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _oderBottomView;
}

- (ShoeOrderInfo *)shoeOrderInfo{
    
    if (_shoeOrderInfo == nil) {
        
        _shoeOrderInfo = [[ShoeOrderInfo alloc] init];
    }
    return _shoeOrderInfo;
}

- (void)chickSureBtn{
    
    [MBProgressHUD showWaitMessage:@"" showView:self.view];
    
    self.oderBottomView.sureBtn.enabled = NO;
    NSString *shoeIdStr = [NSString stringWithFormat:@"%@", shoeSpeedLoadResult.shoeId];
//    NSLog(@"%@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@", buyTireData.shoeDownImg, [NSString stringWithFormat:@"%@", [UserConfig user_id]], fontRearFlag, tireCount, buyTireData.detailStr, self.oderBottomView.tireTotalPriceLabel.text, shoeSpeedLoadResult.price, cxwyCount, buyTireData.cxwyMaxPrice, self.oderBottomView.cxwyTotalPriceLabel.text, self.allTotalPriceStr);
    NSDictionary *surePostDic = @{@"shoeId":shoeIdStr, @"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]], @"fontRearFlag":fontRearFlag, @"amount":tireCount, @"shoeName":buyTireData.detailStr, @"shoeTotalPrice":self.tireTotalPriceStr, @"shoePrice":shoeSpeedLoadResult.price, @"cxwyAmount":cxwyCount, @"cxwyPrice":cxwyAllpriceStr, @"cxwyTotalPrice":self.cxwyTotalPriceStr, @"totalPrice":self.allTotalPriceStr, @"orderImg":buyTireData.shoeDownImg};
    NSString *reqJsonStr = [PublicClass convertToJsonData:surePostDic];
    [JJRequest postRequest:@"addUserShoeOrder" params:@{@"reqJson":reqJsonStr, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
//            NSLog(@"提交订单获取到的值:%@", data);
            [self.shoeOrderInfo setValuesForKeysWithDictionary:data];
            CashierViewController *cashierVC = [[CashierViewController alloc] init];
            cashierVC.totalPriceStr = [NSString stringWithFormat:@"%@", self.shoeOrderInfo.totalPrice];
            cashierVC.orderNoStr = [NSString stringWithFormat:@"%@", self.shoeOrderInfo.orderNo];
            cashierVC.orderTypeStr = @"0";
            [self.navigationController pushViewController:cashierVC animated:YES];
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
        self.oderBottomView.sureBtn.enabled = YES;
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"提交轮胎购买订单错误:%@", error);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单确认";
    [self.view addSubview:self.mainScrollView];
    [self.view addSubview:self.oderBottomView];
    [self addView];
    // Do any additional setup after loading the view.
}

- (void)addView{
    
    [_mainScrollView addSubview:self.orderheadView];
    [_mainScrollView addSubview:self.oderMiddleView];
    [_mainScrollView setContentSize:CGSizeMake(MAINSCREEN.width, self.oderMiddleView.frame.size.height + self.oderMiddleView.frame.origin.y)];
    [self setDataToView];
}

- (void)setDataToView{
    
    NSString *tiretotalPrice = [NSString stringWithFormat:@"%ld", ([tireCount integerValue]*[shoeSpeedLoadResult.price integerValue])];
    NSString *allTotalPrice = [NSString stringWithFormat:@"%ld", ([tiretotalPrice integerValue] + [cxwyAllpriceStr integerValue])];
    [_orderheadView setHeadViewData:buyTireData];
    [_oderMiddleView setMiddleViewData:buyTireData cxwyCount:cxwyCount priceCount:tireCount price:shoeSpeedLoadResult.price];
    [_oderBottomView setBottomViewData:tiretotalPrice cxwyTotalPrice:cxwyAllpriceStr];
    self.allTotalPriceStr = allTotalPrice;
    self.tireTotalPriceStr = tiretotalPrice;
    self.cxwyTotalPriceStr = cxwyAllpriceStr;
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

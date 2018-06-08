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
#import "UserConfig.h"
#import "CashierViewController.h"
#import "ShoeOrderInfo.h"

@interface SureOrderViewController ()<UIScrollViewDelegate>

@property(nonatomic, strong)UIScrollView *mainScrollView;
@property(nonatomic, strong)OrderHeadView *orderheadView;
@property(nonatomic, strong)OderMiddleView *oderMiddleView;
@property(nonatomic, strong)OderBottomView *oderBottomView;
@property(nonatomic, strong)UILabel *totalPriceLabel;
@property(nonatomic, strong)UIButton *sureBtn;
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

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
}

- (UIScrollView *)mainScrollView{
    
    if (_mainScrollView == nil) {
        
        _mainScrollView = [[UIScrollView alloc] init];
        _mainScrollView.frame = CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height - 64);
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
        
        _oderBottomView = [[OderBottomView alloc] initWithFrame:CGRectMake(0, 382, MAINSCREEN.width, 85)];
    }
    return _oderBottomView;
}

- (UILabel *)totalPriceLabel{
    
    if (_totalPriceLabel == nil) {
        
        _totalPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 478, MAINSCREEN.width - 120, 20)];
        _totalPriceLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _totalPriceLabel.textColor = LOGINBACKCOLOR;
        _totalPriceLabel.textAlignment = NSTextAlignmentRight;
    }
    return _totalPriceLabel;
}

- (UIButton *)sureBtn{
    
    if (_sureBtn == nil) {
        
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame = CGRectMake(MAINSCREEN.width - 110, 465, 110, 40);
        _sureBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sureBtn setTitle:@"确认购买" forState:UIControlStateNormal];
        [_sureBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(chickSureBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

- (ShoeOrderInfo *)shoeOrderInfo{
    
    if (_shoeOrderInfo == nil) {
        
        _shoeOrderInfo = [[ShoeOrderInfo alloc] init];
    }
    return _shoeOrderInfo;
}

- (void)chickSureBtn{
    
    self.sureBtn.enabled = NO;
    NSString *shoeIdStr = [NSString stringWithFormat:@"%@", shoeSpeedLoadResult.shoeId];
//    NSLog(@"%@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@", buyTireData.shoeDownImg, [NSString stringWithFormat:@"%@", [UserConfig user_id]], fontRearFlag, tireCount, buyTireData.detailStr, self.oderBottomView.tireTotalPriceLabel.text, shoeSpeedLoadResult.price, cxwyCount, buyTireData.cxwyMaxPrice, self.oderBottomView.cxwyTotalPriceLabel.text, self.allTotalPriceStr);
    NSDictionary *surePostDic = @{@"shoeId":shoeIdStr, @"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]], @"fontRearFlag":fontRearFlag, @"amount":tireCount, @"shoeName":buyTireData.detailStr, @"shoeTotalPrice":self.tireTotalPriceStr, @"shoePrice":shoeSpeedLoadResult.price, @"cxwyAmount":cxwyCount, @"cxwyPrice":buyTireData.cxwyMaxPrice, @"cxwyTotalPrice":self.cxwyTotalPriceStr, @"totalPrice":self.allTotalPriceStr, @"orderImg":buyTireData.shoeDownImg};
    NSString *reqJsonStr = [PublicClass convertToJsonData:surePostDic];
    [JJRequest postRequest:@"addUserShoeOrder" params:@{@"reqJson":reqJsonStr, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
            NSLog(@"提交订单获取到的值:%@", data);
            [self.shoeOrderInfo setValuesForKeysWithDictionary:data];
            CashierViewController *cashierVC = [[CashierViewController alloc] init];
            cashierVC.shoeOrderInfo = self.shoeOrderInfo;
            cashierVC.fontRearFlag = fontRearFlag;
            [self.navigationController pushViewController:cashierVC animated:YES];
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
        self.sureBtn.enabled = YES;
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"提交轮胎购买订单错误:%@", error);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单确认";
    [self.view addSubview:self.mainScrollView];
    [self addView];
    // Do any additional setup after loading the view.
}

- (void)addView{
    
    [_mainScrollView addSubview:self.orderheadView];
    [_mainScrollView addSubview:self.oderMiddleView];
    [_mainScrollView addSubview:self.oderBottomView];
    [_mainScrollView addSubview:self.totalPriceLabel];
    [_mainScrollView addSubview:self.sureBtn];
    [_mainScrollView setContentSize:CGSizeMake(MAINSCREEN.width, self.sureBtn.frame.size.height + self.sureBtn.frame.origin.y)];
    [self setDataToView];
}

- (void)setDataToView{
    
    NSString *tiretotalPrice = [NSString stringWithFormat:@"%.2f", ([tireCount integerValue]*[shoeSpeedLoadResult.price floatValue])];
    NSString *cxwyTotalPrice = [NSString stringWithFormat:@"%.2f", ([cxwyCount integerValue]*[buyTireData.cxwyMaxPrice floatValue])];
    NSString *allTotalPrice = [NSString stringWithFormat:@"%.2f", ([tiretotalPrice floatValue] + [cxwyTotalPrice floatValue])];
    NSLog(@"%@", buyTireData.userPhone);
    [_orderheadView setHeadViewData:buyTireData];
    [_oderMiddleView setMiddleViewData:buyTireData cxwyCount:cxwyCount priceCount:tireCount price:shoeSpeedLoadResult.price];
    [_oderBottomView setBottomViewData:tiretotalPrice cxwyTotalPrice:cxwyTotalPrice];
    _totalPriceLabel.text = [NSString stringWithFormat:@"合计: ¥%@ 元", allTotalPrice];
    self.allTotalPriceStr = allTotalPrice;
    self.tireTotalPriceStr = tiretotalPrice;
    self.cxwyTotalPriceStr = cxwyTotalPrice;
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

//
//  BuyPassViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/12.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "BuyPassViewController.h"
#import "BuyPassMiddleView.h"
#import "BuyPassBottomView.h"
#import "UserProtocolViewController.h"
#import "BuyCXWYUserInfo.h"
#import "CashierViewController.h"
#import "CXWYPriceParamInfo.h"
#import "JJUILabel.h"
@interface BuyPassViewController ()<UIScrollViewDelegate>

@property(nonatomic, strong)UIScrollView *mainScrollV;
@property(nonatomic, strong)UIImageView *passDetialImageV;
@property(nonatomic, strong)BuyPassMiddleView *buypassMiddleV;
@property(nonatomic, strong)BuyPassBottomView *buypassBottomV;
@property(nonatomic, strong)BuyCXWYUserInfo *buyCXWYUserInfo;
@property(nonatomic, strong)NSString *shoeBasePriceStr;
@property(nonatomic, strong)NSString *totalPriceStr;
@property(nonatomic, strong)NSMutableArray *cxwyPriceParamMutableA;

@end

@implementation BuyPassViewController

- (UIScrollView *)mainScrollV{
    
    if (_mainScrollV == nil) {
        
        _mainScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height - SafeDistance - 90)];
        _mainScrollV.showsVerticalScrollIndicator = NO;
        _mainScrollV.showsHorizontalScrollIndicator = NO;
        _mainScrollV.bounces = NO;
        _mainScrollV.delegate = self;
        _mainScrollV.tag = 2;
        _mainScrollV.scrollsToTop = NO;
    }
    return _mainScrollV;
}

- (UIImageView *)passDetialImageV{
    
    if (_passDetialImageV == nil) {
        
        _passDetialImageV = [[UIImageView alloc] init];
        _passDetialImageV.frame = CGRectMake(0, 0, MAINSCREEN.width, 230);
        _passDetialImageV.image = [UIImage imageNamed:@"ic_chang"];
    }
    return _passDetialImageV;
}

- (BuyPassMiddleView *)buypassMiddleV{
    
    if (_buypassMiddleV == nil) {
        
        _buypassMiddleV = [[BuyPassMiddleView alloc] initWithFrame:CGRectMake(0, 231, MAINSCREEN.width, 250)];
        [_buypassMiddleV.buyNumberSelectV.leftBtn addTarget:self action:@selector(chickBuyNumberLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_buypassMiddleV.buyNumberSelectV.rightBtn addTarget:self action:@selector(chickBuyNumberRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buypassMiddleV;
}

- (BuyPassBottomView *)buypassBottomV{
    
    if (_buypassBottomV == nil) {

        JJWeakSelf
        _buypassBottomV = [[BuyPassBottomView alloc] initWithFrame:CGRectMake(0, MAINSCREEN.height - SafeDistance - 90, MAINSCREEN.width, 90)];
        [_buypassBottomV.sureBuyBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [_buypassBottomV.sureBuyBtn addTarget:self action:@selector(chickSureBuyBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        _buypassBottomV.eventBlock = ^(BOOL isClick) {
          
            UserProtocolViewController *userProtocolVC = [[UserProtocolViewController alloc] init];
            userProtocolVC.dealIdStr = @"3";
            [weakSelf.navigationController pushViewController:userProtocolVC animated:YES];
        };
    }
    return _buypassBottomV;
}

- (BuyCXWYUserInfo *)buyCXWYUserInfo{
    
    if (_buyCXWYUserInfo == nil) {
        
        _buyCXWYUserInfo = [[BuyCXWYUserInfo alloc] init];
    }
    return _buyCXWYUserInfo;
}

- (NSMutableArray *)cxwyPriceParamMutableA{
    
    if (_cxwyPriceParamMutableA == nil) {
        
        _cxwyPriceParamMutableA = [[NSMutableArray alloc] init];
    }
    return _cxwyPriceParamMutableA;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.totalPriceStr = @"0";
    self.title = @"畅行无忧";
    [self addViews];
    [self getCarByUserIdAndCarId];
    // Do any additional setup after loading the view.
}

- (void)addViews{
    
    [self.view addSubview:self.mainScrollV];
    [self.view addSubview:self.buypassBottomV];
    [_mainScrollV addSubview:self.passDetialImageV];
    [_mainScrollV addSubview:self.buypassMiddleV];
    [_mainScrollV setContentSize:CGSizeMake(MAINSCREEN.width, self.buypassMiddleV.frame.size.height+self.buypassMiddleV.frame.origin.y)];
}

- (void)getCarByUserIdAndCarId{
    
    NSDictionary *postDic = @{@"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]], @"userCarId":[NSString stringWithFormat:@"%@", [UserConfig userCarId]]};
    NSString *reqJson = [PublicClass convertToJsonData:postDic];
    [JJRequest postRequest:@"getCarByUserIdAndCarId" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
//            NSLog(@"%@", data);
            self.buyCXWYUserInfo.userPlatnumber = [data objectForKey:@"platNumber"];
            [self getShoeDetailByShoeId];
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"购买畅行无忧页面获取用户车辆信息:%@", error);
    }];
}

- (void)getShoeDetailByShoeId{
    
    NSDictionary *detailPostDic = @{@"shoeId":@"", @"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]]};
    NSString *reqJson = [PublicClass convertToJsonData:detailPostDic];
    [JJRequest postRequest:@"getShoeDetailByShoeId" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
//            YLog(@"购买畅行无忧:%@", data);
            [self analySizePriceParam:[data objectForKey:@"cxwyPriceParamList"]];
            self.shoeBasePriceStr = [data objectForKey:@"shoeBasePrice"];
            self.buyCXWYUserInfo.cxwyPrice = [data objectForKey:@"finalCxwyPrice"];
            self.buyCXWYUserInfo.userName = [UserConfig nick];
            self.buyCXWYUserInfo.userPhone = [UserConfig phone];
            [self setdatatoSubviews:self.buyCXWYUserInfo];
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"购买畅行无忧页面根据轮胎id和userId获取:%@", error);
    }];
}

- (void)analySizePriceParam:(NSArray *)paramArray{
    
    for (int i = 0; i<paramArray.count; i++) {
        
        CXWYPriceParamInfo *cxwyPriceInfo = [[CXWYPriceParamInfo alloc] init];
        [cxwyPriceInfo setValuesForKeysWithDictionary:[paramArray objectAtIndex:i]];
        [self.cxwyPriceParamMutableA addObject:cxwyPriceInfo];
    }
}

- (void)chickBuyNumberLeftBtn:(UIButton *)button{
    
    if ([self.buypassMiddleV.buyNumberSelectV.numberLabel.text isEqualToString:@"0"]) {
        
        self.totalPriceStr = @"0";
        [_buypassBottomV setdatatoViews:self.totalPriceStr];
    }else{
        
        NSInteger index = [self.buypassMiddleV.buyNumberSelectV.numberLabel.text integerValue] - 1;
        CXWYPriceParamInfo *paramInfo = [self.cxwyPriceParamMutableA objectAtIndex:index];
        NSInteger priceInteger = (NSInteger)[self.shoeBasePriceStr integerValue] * [paramInfo.rate integerValue]/100;
        self.totalPriceStr = [NSString stringWithFormat:@"%ld", priceInteger];
        [_buypassBottomV setdatatoViews:self.totalPriceStr];
    }
}

- (void)chickBuyNumberRightBtn:(UIButton *)button{
    
    NSInteger index = [self.buypassMiddleV.buyNumberSelectV.numberLabel.text integerValue] - 1;
    CXWYPriceParamInfo *paramInfo = [self.cxwyPriceParamMutableA objectAtIndex:index];
    NSInteger priceInteger = (NSInteger)[self.shoeBasePriceStr integerValue] * [paramInfo.rate integerValue]/100;
    self.totalPriceStr = [NSString stringWithFormat:@"%ld", priceInteger];
    [_buypassBottomV setdatatoViews:self.totalPriceStr];
}

- (void)chickSureBuyBtn:(UIButton *)button{
    
    if (_buypassBottomV.selectBtn.selected != YES) {
        
        [PublicClass showHUD:@"请选择使用协议" view:self.view];
    }else{
        
        if ([self.totalPriceStr isEqualToString:@"0"]) {
            
            [PublicClass showHUD:@"请选择购买数量" view:self.view];
        }else{
            
            NSDictionary *postDic = @{@"shoeId":@"0", @"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]], @"fontRearFlag":@"0", @"amount":@"0", @"shoeName":@"", @"shoeTotalPrice":@"0", @"shoePrice":@"0", @"cxwyAmount":_buypassMiddleV.buyNumberSelectV.numberLabel.text, @"cxwyPrice":self.buyCXWYUserInfo.cxwyPrice, @"cxwyTotalPrice":self.totalPriceStr, @"totalPrice":self.totalPriceStr, @"orderImg":@""};
            NSString *reqJson = [PublicClass convertToJsonData:postDic];
            [JJRequest postRequest:@"addUserShoeOrder" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
                
                NSString *statusStr = [NSString stringWithFormat:@"%@", code];
                NSString *messageStr = [NSString stringWithFormat:@"%@", message];
                if ([statusStr isEqualToString:@"1"]) {
                    
                    CashierViewController *cashierVC = [[CashierViewController alloc] init];
                    cashierVC.orderNoStr = [data objectForKey:@"orderNo"];
                    cashierVC.totalPriceStr = [data objectForKey:@"totalPrice"];
                    cashierVC.orderTypeStr = @"0";
                    [self.navigationController pushViewController:cashierVC animated:YES];
                }else{
                    
                    [PublicClass showHUD:messageStr view:self.view];
                }
            } failure:^(NSError * _Nullable error) {
                
                NSLog(@"购买畅行无忧的错误:%@", error);
            }];
        }
    }
}

- (void)setdatatoSubviews:(BuyCXWYUserInfo *)buyCXWYInfo{
    
    [_buypassMiddleV setdatatoViews:buyCXWYInfo];
    [_buypassBottomV setdatatoViews:self.totalPriceStr];
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

//
//  MyQuotaViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/21.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "MyQuotaViewController.h"
#import "CreditLineCarInfo.h"
#import "MyQuotaHeadView.h"
#import "MyQuotaMiddleView.h"
#import "PaymentMethodView.h"
#import <AlipaySDK/AlipaySDK.h>
#import "PaySuccessViewController.h"
#import "DelegateConfiguration.h"
#import "WXApi.h"

@interface MyQuotaViewController ()<UIScrollViewDelegate, LoginStatusDelegate>{
    
    NSString *payFlagStr;   //weixin--1, alipay--2
}

@property(nonatomic, strong)CreditLineCarInfo *creditCarInfo;
@property(nonatomic, strong)UIScrollView *mainScrollV;
@property(nonatomic, strong)MyQuotaHeadView *myquotaHeadV;
@property(nonatomic, strong)MyQuotaMiddleView *myquotaMiddleV;
@property(nonatomic, strong)PaymentMethodView *paymentMethodView;
@property(nonatomic, strong)UIButton *repayBtn;

@end

@implementation MyQuotaViewController

- (CreditLineCarInfo *)creditCarInfo{
    
    if (_creditCarInfo == nil) {
        
        _creditCarInfo = [[CreditLineCarInfo alloc] init];
    }
    return _creditCarInfo;
}

- (UIScrollView *)mainScrollV{
    
    if (_mainScrollV == nil) {
        
        _mainScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height - SafeDistance - 40)];
        _mainScrollV.delegate = self;
        _mainScrollV.showsVerticalScrollIndicator = NO;
        _mainScrollV.showsHorizontalScrollIndicator = NO;
        _mainScrollV.bounces = NO;
        _mainScrollV.scrollsToTop = NO;
        _mainScrollV.tag = 2;
    }
    return _mainScrollV;
}

- (UIButton *)repayBtn{
    
    if (_repayBtn == nil) {
        
        _repayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _repayBtn.frame = CGRectMake(10, MAINSCREEN.height - SafeDistance - 40, MAINSCREEN.width - 20, 34);
        _repayBtn.layer.cornerRadius = 6.0;
        _repayBtn.layer.masksToBounds = YES;
        _repayBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        [_repayBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [_repayBtn setTitle:@"立即还款" forState:UIControlStateNormal];
        [_repayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_repayBtn addTarget:self action:@selector(chickRepayBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _repayBtn;
}

- (void)chickRepayBtn:(UIButton *)button{
    
    //payFlageStr = 1----weixinpay   payFlageStr = 2----alipayPay
    
    NSString *inputStr = [NSString stringWithFormat:@"%.2f", [self.myquotaMiddleV.realRepayTF.text floatValue]];
    if (([inputStr floatValue] - 0.01)<0) {

        [PublicClass showHUD:@"输入的数值不能太小" view:self.view];
    }else{

        if ([self.myquotaHeadV.realShouldLabel.text integerValue] == 0) {

            [PublicClass showHUD:@"您不需要还款" view:self.view];
        }else{

            [self addRechargeCreditOrder];
        }
    }
}

- (void)addRechargeCreditOrder{
    
    NSDictionary *rechargePostDic = @{@"associationOrderNo":@"", @"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]], @"userCarId":[NSString stringWithFormat:@"%@", [UserConfig userCarId]], @"price":[NSString stringWithFormat:@"%.2f", [self.myquotaMiddleV.realRepayTF.text floatValue]]};
    NSString *reqJson = [PublicClass convertToJsonData:rechargePostDic];
    [JJRequest postRequest:@"addRechargeCreditOrder" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
//            NSLog(@"%@", data);
            if ([payFlagStr isEqualToString:@"1"]) {
                
                [self getSignFromWeiXin:data];
            }else{
                
                [self getSignFromThridPay:data];
            }
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"添加信用充值收费订单:%@", error);
    }];
}

- (void)getSignFromWeiXin:(NSString *)orderNumber{
    
    NSDictionary *wxPostDic = @{@"orderNo":orderNumber, @"orderName":@"充值信用订单", @"orderPrice":@"0.01", @"orderType":@"5", @"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]]};
    NSString *reqJson = [PublicClass convertToJsonData:wxPostDic];
    NSString *threeDesStr = [PublicClass doEncryptStr:reqJson key:[[UserConfig token] substringWithRange:NSMakeRange(24, 24)]];
    //        NSLog(@"%@", @{@"reqJson":threeDesStr, @"token":[UserConfig token]});
    [JJRequest commonPostRequest:@"getWeixinPaySign" params:@{@"reqJson":threeDesStr, @"token":[UserConfig token]} hostNameStr:SERVERPREFIX success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        //            NSLog(@"%@", data);
        if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
            
            PayReq *req = [[PayReq alloc] init];
            req.openID = [data objectForKey:@"appid"];
            req.partnerId = [data objectForKey:@"partnerid"];
            req.prepayId = [data objectForKey:@"prepayid"];
            req.package = [data objectForKey:@"package"];
            req.nonceStr = [data objectForKey:@"noncestr"];
            req.timeStamp = [[data objectForKey:@"timestamp"] intValue];
            req.sign = [data objectForKey:@"sign"];
            [WXApi sendReq:req];
        }else{
            
            [PublicClass showHUD:@"未安装微信" view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"获取微信支付签名错误:%@", error);
    }];
}

- (void)getSignFromThridPay:(NSString *)orderNumber{
    
    NSDictionary *postDic = @{@"orderNo":orderNumber, @"orderName":@"充值信用订单", @"orderPrice":self.myquotaMiddleV.realRepayTF.text, @"orderType":@"5", @"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]]};
    NSString *reqJson = [PublicClass convertToJsonData:postDic];
    NSString *threeDesStr = [PublicClass doEncryptStr:reqJson key:[[UserConfig token] substringWithRange:NSMakeRange(24, 24)]];
    [JJRequest testPostRequest:@"getAliPaySign" params:@{@"reqJson":threeDesStr, @"token":[UserConfig token]} serviceAddress:SERVERPREFIX success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        [[AlipaySDK defaultService] payOrder:messageStr fromScheme:@"ruyiruyiios" callback:^(NSDictionary *resultDic) {
            
        }];
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"获取订单签名错误:%@", error);
    }];
}

- (MyQuotaHeadView *)myquotaHeadV{
    
    if (_myquotaHeadV == nil) {
        
        _myquotaHeadV = [[MyQuotaHeadView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, 210)];
    }
    return _myquotaHeadV;
}

- (MyQuotaMiddleView *)myquotaMiddleV{
    
    if (_myquotaMiddleV == nil) {
        
        _myquotaMiddleV = [[MyQuotaMiddleView alloc] initWithFrame:CGRectMake(0, 211, MAINSCREEN.width, 120)];
    }
    return _myquotaMiddleV;
}

- (PaymentMethodView *)paymentMethodView{
    
    if (_paymentMethodView == nil) {
        
        _paymentMethodView = [[PaymentMethodView alloc] initWithFrame:CGRectMake(0, 332, MAINSCREEN.width, 125)];
        [_paymentMethodView.weixinBtn addTarget:self action:@selector(chickWeixinBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_paymentMethodView.alipayBtn addTarget:self action:@selector(chickAlipayBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _paymentMethodView;
}

- (void)chickWeixinBtn:(UIButton *)button{
    
    payFlagStr = @"1";
    _paymentMethodView.weixinBtn.selected = YES;
    _paymentMethodView.alipayBtn.selected = NO;
}

- (void)chickAlipayBtn:(UIButton *)button{
    
    payFlagStr = @"2";
    _paymentMethodView.weixinBtn.selected = NO;
    _paymentMethodView.alipayBtn.selected = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的额度";
    
    DelegateConfiguration *delegateConfiguration = [DelegateConfiguration sharedConfiguration];
    [delegateConfiguration registerLoginStatusChangedListener:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chickPayResult) name:@"payStatus" object:nil];
    
    payFlagStr = @"2";
    [self addViews];
    [self queryCarCreditMyQuota];
    // Do any additional setup after loading the view.
}

- (IBAction)backButtonAction:(id)sender{
    
    DelegateConfiguration *delegateConfiguration = [DelegateConfiguration sharedConfiguration];
    [delegateConfiguration unregisterLoginStatusChangedListener:self];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addViews{
    
    [self.view addSubview:self.mainScrollV];
    [self.view addSubview:self.repayBtn];
    [_mainScrollV addSubview:self.myquotaHeadV];
    [_mainScrollV addSubview:self.myquotaMiddleV];
    [_mainScrollV addSubview:self.paymentMethodView];
    [_mainScrollV setContentSize:CGSizeMake(MAINSCREEN.width, self.paymentMethodView.frame.size.height+self.paymentMethodView.frame.origin.y)];
}

- (void)setdatatoViews{
    
    [_myquotaHeadV setDatatoHeadView:[self.creditCarInfo.credit floatValue] remainCredit:[self.creditCarInfo.remain floatValue]];
    [_myquotaMiddleV setDatatoHeadView:[self.creditCarInfo.credit floatValue] remainCredit:[self.creditCarInfo.remain floatValue]];
}

- (void)queryCarCreditMyQuota{
    
    NSDictionary *carCreditPostDic = @{@"userId":[NSNumber numberWithInteger:[[UserConfig user_id] integerValue]], @"userCarId":[NSNumber numberWithInteger:[[UserConfig userCarId] integerValue]]};
    NSString *reJson = [PublicClass convertToJsonData:carCreditPostDic];
    [JJRequest postRequest:@"userCarInfo/queryCarCreditInfo" params:@{@"reqJson":reJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
//            NSLog(@"%@", data);
            [self analySizeData:data];
        }else if ([statusStr isEqualToString:@"-999"]){
            
            [self alertIsequallyTokenView];
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"查询个人额度错误:%@", error);
    }];
}

- (void)analySizeData:(NSArray *)dataArray{
    
    NSDictionary *dataDic = [dataArray objectAtIndex:0];
    [self.creditCarInfo setValuesForKeysWithDictionary:dataDic];
    [self setdatatoViews];
}

//information
- (void)chickPayResult{
    
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popToRootViewControllerAnimated:YES];
//    PaySuccessViewController *paySuccessVC = [[PaySuccessViewController alloc] init];
//    paySuccessVC.orderTypeStr = @"5";
//    [self.navigationController pushViewController:paySuccessVC animated:YES];
}

//LoginStatusDelegate
- (void)updateLoginStatus{
    
    [self queryCarCreditMyQuota];
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"payStatus" object:nil];
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

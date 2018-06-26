//
//  CashierViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/30.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "CashierViewController.h"
#import "CashierPayView.h"
#import "ToBePaidViewController.h"
#import "BuyCommdityViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "PaySuccessViewController.h"

@interface CashierViewController ()

@property(nonatomic, strong)UILabel *shouldPayLabel;
@property(nonatomic, strong)UILabel *moneyLabel;
@property(nonatomic, strong)UIButton *surePayBtn;
@property(nonatomic, strong)CashierPayView *cashierPayView;
@property(nonatomic, strong)NSString *payTypeStr; //1---jinepay 2---weixinpay 3---alipay

@end

@implementation CashierViewController
@synthesize totalPriceStr;
@synthesize orderTypeStr;
@synthesize orderNoStr;

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
}

- (UILabel *)shouldPayLabel{
    
    if (_shouldPayLabel == nil) {
        
        _shouldPayLabel = [[UILabel alloc] init];
        _shouldPayLabel.frame = CGRectMake(20, 20, 70, 20);
        _shouldPayLabel.text = @"应付余额: ";
        _shouldPayLabel.textColor = TEXTCOLOR64;
        _shouldPayLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
    }
    return _shouldPayLabel;
}

- (UILabel *)moneyLabel{
    
    if (_moneyLabel == nil) {
        
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.frame = CGRectMake(90, 19, MAINSCREEN.width - 90, 22);
        _moneyLabel.text = [NSString stringWithFormat:@"%.2f元", [totalPriceStr floatValue]];
        _moneyLabel.textColor = [UIColor redColor];
        _moneyLabel.font = [UIFont fontWithName:TEXTFONT size:22.0];
    }
    return _moneyLabel;
}

- (UIButton *)surePayBtn{
    
    if (_surePayBtn == nil) {
        
        _surePayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _surePayBtn.frame = CGRectMake(10, MAINSCREEN.height - 104, MAINSCREEN.width - 20, 34);
        _surePayBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _surePayBtn.layer.cornerRadius = 4.0;
        _surePayBtn.layer.masksToBounds = YES;
        [_surePayBtn setTitle:@"确认支付" forState:UIControlStateNormal];
        [_surePayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_surePayBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [_surePayBtn addTarget:self action:@selector(chickSurePayBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _surePayBtn;
}

- (void)chickSurePayBtn:(UIButton *)button{
    
    NSString *orderNameStr = @"";
    if ([orderTypeStr isEqualToString:@"0"]) {
        
        orderNameStr = @"轮胎购买订单";
    }else if ([orderTypeStr isEqualToString:@"1"]){
        
        orderNameStr = @"普通商品购买订单";
    }else if ([orderTypeStr isEqualToString:@"2"]){
        
        orderNameStr = @"首次更换订单";
    }else if ([orderTypeStr isEqualToString:@"3"]){
        
        orderNameStr = @"免费再换订单";
    }else if ([orderTypeStr isEqualToString:@"4"]){
        
        orderNameStr = @"轮胎修补订单";
    }else if ([orderTypeStr isEqualToString:@"5"]){
        
        orderNameStr = @"充值信用订单";
    }else if ([orderTypeStr isEqualToString:@"6"]){
        
        orderNameStr = @"轮胎补差订单";
    }else if ([orderTypeStr isEqualToString:@"7"]){
        
        orderNameStr = @"补邮费订单";
    }
    //1--blanceMoney  2--wxPay  3--alipay
    if ([self.payTypeStr isEqualToString:@"1"]) {
        
        [PublicClass showHUD:@"金额不足支付" view:self.view];
    }else if ([self.payTypeStr isEqualToString:@"2"]){
        
        NSDictionary *wxPostDic = @{@"orderNo":orderNoStr, @"orderName":orderNameStr, @"orderPrice":@"0.01", @"orderType":orderTypeStr, @"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]]};
        NSString *reqJson = [PublicClass convertToJsonData:wxPostDic];
        NSString *threeDesStr = [PublicClass doEncryptStr:reqJson key:[[UserConfig token] substringWithRange:NSMakeRange(24, 24)]];
//        NSLog(@"%@", @{@"reqJson":threeDesStr, @"token":[UserConfig token]});
        [JJRequest commonPostRequest:@"getWeixinPaySign" params:@{@"reqJson":threeDesStr, @"token":[UserConfig token]} hostNameStr:TEXTSERVERPREFIX success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
            
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
    }else{
        
        NSDictionary *postDic = @{@"orderNo":orderNoStr, @"orderName":orderNameStr, @"orderPrice":@"0.01", @"orderType":orderTypeStr, @"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]]};
        NSString *reqJson = [PublicClass convertToJsonData:postDic];
        NSString *threeDesStr = [PublicClass doEncryptStr:reqJson key:[[UserConfig token] substringWithRange:NSMakeRange(24, 24)]];
        NSLog(@"%@", @{@"reqJson":threeDesStr, @"token":[UserConfig token]});
        [JJRequest testPostRequest:@"getAliPaySign" params:@{@"reqJson":threeDesStr, @"token":[UserConfig token]} serviceAddress:SERVERPREFIX success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
            
            NSString *messageStr = [NSString stringWithFormat:@"%@", message];
//            NSLog(@"%@", messageStr);
            [[AlipaySDK defaultService] payOrder:messageStr fromScheme:@"ruyiruyiios" callback:^(NSDictionary *resultDic) {
                
            }];
        } failure:^(NSError * _Nullable error) {
            
            NSLog(@"获取支付宝支付签名错误:%@", error);
        }];
    }
}

//information
- (void)chickPayResult{
    
    PaySuccessViewController *paySuccessVC = [[PaySuccessViewController alloc] init];
    paySuccessVC.orderTypeStr = orderTypeStr;
    [self.navigationController pushViewController:paySuccessVC animated:YES];
}

- (CashierPayView *)cashierPayView{
    
    if (_cashierPayView == nil) {
        
        _cashierPayView = [[CashierPayView alloc] initWithFrame:CGRectMake(0, 55, MAINSCREEN.width, 230)];
        _cashierPayView.blanceBtn.tag = 1;
        _cashierPayView.wxBtn.tag = 2;
        _cashierPayView.alipayBtn.tag = 3;
        [_cashierPayView.blanceBtn addTarget:self action:@selector(chickCashierBtns:) forControlEvents:UIControlEventTouchUpInside];
        [_cashierPayView.wxBtn addTarget:self action:@selector(chickCashierBtns:) forControlEvents:UIControlEventTouchUpInside];
        [_cashierPayView.alipayBtn addTarget:self action:@selector(chickCashierBtns:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cashierPayView;
}

- (void)chickCashierBtns:(UIButton *)button{
    
    switch (button.tag) {
        case 1:
            
            self.payTypeStr = @"1";
            _cashierPayView.blanceBtn.selected = YES;
            _cashierPayView.wxBtn.selected = NO;
            _cashierPayView.alipayBtn.selected = NO;
            break;
            
        case 2:
            
            self.payTypeStr = @"2";
            _cashierPayView.blanceBtn.selected = NO;
            _cashierPayView.wxBtn.selected = YES;
            _cashierPayView.alipayBtn.selected = NO;
            break;
            
        case 3:
            
            self.payTypeStr = @"3";
            _cashierPayView.blanceBtn.selected = NO;
            _cashierPayView.wxBtn.selected = NO;
            _cashierPayView.alipayBtn.selected = YES;
            break;
            
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"收银台";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chickPayResult) name:@"payStatus" object:nil];
    self.payTypeStr = @"1";
    [self addView];
    // Do any additional setup after loading the view.
}

- (IBAction)backButtonAction:(id)sender{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"如驿如意" message:@"您确认离开支付订单界面，离开订单会变为待付款订单，可在待付款订单中查看" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([orderTypeStr isEqualToString:@"0"]) {
            
            ToBePaidViewController *tobePaidVC = [[ToBePaidViewController alloc] init];
            tobePaidVC.orderNoStr = orderNoStr;
            tobePaidVC.totalPriceStr = totalPriceStr;
            tobePaidVC.orderTypeStr = orderTypeStr;
            [self.navigationController pushViewController:tobePaidVC animated:YES];
            
        }else if ([orderTypeStr isEqualToString:@"1"]){

            for (UIViewController *popVC in self.navigationController.viewControllers) {
                
                if ([popVC isKindOfClass:[BuyCommdityViewController class]]) {
                    
                    BuyCommdityViewController *buyCommodityVc = (BuyCommdityViewController *)popVC;
                    
                    buyCommodityVc.popSelfBlock(self.orderNoStr, self.orderTypeStr);
                    
                    [self.navigationController popToViewController:popVC animated:YES];
                }
            }
        }
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:ok];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)addView{
    
    [self.view addSubview:self.shouldPayLabel];
    [self.view addSubview:self.moneyLabel];
    [self.view addSubview:self.surePayBtn];
    [self.view addSubview:self.cashierPayView];
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

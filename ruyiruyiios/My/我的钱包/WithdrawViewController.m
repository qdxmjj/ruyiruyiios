//
//  WithdrawViewController.m
//  ruyiRuyi
//
//  Created by 姚永敏 on 2018/10/16.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "WithdrawViewController.h"
#import "MBProgressHUD+YYM_category.h"
#import "VTCodeView.h"
#import "WeChatViewController.h"
#import "RecordingViewController.h"
#import "AlipayInfoViewController.h"
@interface WithdrawViewController ()
@property (weak, nonatomic) IBOutlet UIButton *zfbBtn;
@property (weak, nonatomic) IBOutlet UIButton *wxBtn;
@property (weak, nonatomic) IBOutlet UILabel *alipayPhoneLab;
@property (weak, nonatomic) IBOutlet UILabel *wecahtNameLab;
@property (weak, nonatomic) IBOutlet UITextField *sumTextField;
@property (weak, nonatomic) IBOutlet UILabel *AvailableBalanceLab;

@property (weak, nonatomic) IBOutlet UIButton *alipayStatusBtn;
@property (weak, nonatomic) IBOutlet UIButton *wechatStatusBen;

@property (copy, nonatomic) NSString *alipayName;
@property (copy, nonatomic) NSString *alipayID;
@property (copy, nonatomic) NSString *alipayAccount;

@property (copy, nonatomic) NSString *wechatOpenID;

@property (assign, nonatomic) NSInteger bindingTime;

@property (copy, nonatomic) NSString *withdrawing;//每次只允许一笔提现订单

@end

@implementation WithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"提现";
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"记录" style:UIBarButtonItemStyleDone target:self action:@selector(pushWithdrawalsRecordViewController)];
    
    [MBProgressHUD showWaitMessage:@"正在获取提现数据..." showView:self.view];
    
    [JJRequest interchangeablePostRequestWithIP:GL_RuYiRuYiIP path:@"/bindingInfo/queryUserAccountInfo" params:@{@"userId":@([[UserConfig user_id] integerValue])} success:^(id  _Nullable data) {
        
        [MBProgressHUD hideWaitViewAnimated:self.view];
        
        if ( !data || [data objectForKey:@"data"] == [NSNull null]) {
            
            [MBProgressHUD showTextMessage:@"数据异常！"];
            return ;
        }
        
        NSDictionary *incomeVCInfo = [data objectForKey:@"data"];
        
        if ([[data objectForKey:@"isSuccess"] boolValue] == YES) {
            
            self.AvailableBalanceLab.text = [NSString stringWithFormat:@"%@",[incomeVCInfo objectForKey:@"availableMoney"]];
            
            if ([[incomeVCInfo objectForKey:@"bindingStatus"] longLongValue] == 0) {
                
                [self.alipayStatusBtn setTitle:@"未绑定>" forState:UIControlStateNormal];
            }else{
                [self.alipayStatusBtn setTitle:@"解绑>" forState:UIControlStateNormal];
                self.alipayPhoneLab.text = [incomeVCInfo objectForKey:@"aliAccount"];
            }
            
            self.alipayName = [incomeVCInfo objectForKey:@"realName"];
            self.alipayID = [incomeVCInfo objectForKey:@"iDNumber"];
            self.alipayAccount = [incomeVCInfo objectForKey:@"aliAccount"];
            self.bindingTime = [incomeVCInfo objectForKey:@"bindingTime"] == [NSNull null] ? 0 : [[incomeVCInfo objectForKey:@"bindingTime"] integerValue];
            self.withdrawing = [NSString stringWithFormat:@"%@",[incomeVCInfo objectForKey:@"withdrawing"]];
            
            //            NSLog(@"%ld",self.bindingTime);
        }else{
            
            [MBProgressHUD showTextMessage:@"获取失败！"];
        }
        
    } failure:^(NSError * _Nullable error) {
        
        [MBProgressHUD hideWaitViewAnimated:self.view];
    }];

}

- (IBAction)withdrawEvent:(UIButton *)sender {
    
    if (![self.withdrawing isEqualToString:@"0"]) {
        
        [MBProgressHUD showTextMessage:@"您当前有正在提现的订单！"];
        return;
    }
    
    NSDecimalNumberHandler *rounUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    
    NSDecimalNumber *num_1 = [NSDecimalNumber decimalNumberWithString:self.sumTextField.text];
    NSDecimalNumber *availableBalance = [NSDecimalNumber decimalNumberWithString:self.AvailableBalanceLab.text];
    
    NSDecimalNumber *newNum = [num_1 decimalNumberByRoundingAccordingToBehavior:rounUp];
    NSDecimalNumber *newAvailableBalance = [availableBalance decimalNumberByRoundingAccordingToBehavior:rounUp];
    
    if ([newNum doubleValue] <= 0 ) {
        
        [MBProgressHUD showTextMessage:@"请输入正确的提现金额！"];
        return;
    }
    
//    if ([newNum doubleValue] < 10) {
//
//        [MBProgressHUD showTextMessage:@"最低提现10元！"];
//        return;
//    }
//
    if ([newNum doubleValue] > [newAvailableBalance doubleValue]) {
        
        [MBProgressHUD showTextMessage:@"提现金额不可大于可提现金额！"];
        return;
    }

    
    NSInteger payStatus = 0;
    
    NSString *wechatID;
    NSString *wechatName;
    if (self.zfbBtn.selected) {
        
        if ([self.alipayStatusBtn.titleLabel.text isEqualToString:@"未绑定>"]) {
            
            [MBProgressHUD showTextMessage:@"请先绑定支付宝，再进行提现！"];
            return;
        }
        
        payStatus = 1;

        wechatID = @"kong";
        wechatName = @"无名";
    }else if (self.wxBtn.selected){
        
        [MBProgressHUD showTextMessage:@"暂不支持微信提现！"];
        return;
//        if ([self.wechatStatusBen.titleLabel.text isEqualToString:@"未登录>"]) {
//
//            [MBProgressHUD showTextMessage:@"请先授权微信登录，再进行提现！"];
//            return;
//        }
//
//        payStatus = 2;
//
//        wechatID = self.wechatOpenID;
//        wechatName = self.wecahtNameLab.text;
    }else{
        
        [MBProgressHUD showTextMessage:@"请选择提现方式!"];
        
        return;
    }
    
    [MBProgressHUD showWaitMessage:@"正在提现..." showView:self.view];

    NSDictionary *params = @{@"userId":[UserConfig user_id],@"userName":[UserConfig nick],@"type":@(payStatus),@"availableMoney":self.AvailableBalanceLab.text,@"withdrawMoney":self.sumTextField.text,@"wxOpenId":wechatID,@"realName":wechatName};

    [JJRequest interchangeablePostRequestWithIP:GL_RuYiRuYiIP path:@"withdrawInfo/applyWithdrawOrder" params:params success:^(id  _Nullable data) {
        
        [MBProgressHUD hideWaitViewAnimated:self.view];
        
        if ([[data objectForKey:@"isSuccess"] boolValue] == YES) {
            
            [MBProgressHUD showTextMessage:@"发起提现申请成功！"];
            
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
            [MBProgressHUD showTextMessage:@"提现失败！"];
        }
        
    } failure:^(NSError * _Nullable error) {
        [MBProgressHUD hideWaitViewAnimated:self.view];
    }];
}

-(void)pushWithdrawalsRecordViewController{
    
    RecordingViewController *recordingVC = [[RecordingViewController alloc] init];
    
    [self.navigationController pushViewController:recordingVC animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}

- (IBAction)fullWithdrawalEvent:(UIButton *)sender{
    
    if ([self.AvailableBalanceLab.text isEqualToString:@"0"] || self.AvailableBalanceLab.text.length <=0 ) {
        
        [MBProgressHUD showTextMessage:@"无可提现余额！"];
        return;
    }
    
    self.sumTextField.text = self.AvailableBalanceLab.text;
    

}
- (IBAction)selectPayWay:(UIButton *)sender {
    
    sender.selected = !sender.selected;

    if ([sender isEqual:self.zfbBtn]) {
        //支付宝支付
        
        self.wxBtn.selected = !self.zfbBtn.selected;
    }else{
        //微信支付
        self.zfbBtn.selected = !self.wxBtn.selected;
    }
}

- (IBAction)alipayBindingEvent:(UIButton *)sender{
    
    if ([sender.titleLabel.text isEqualToString:@"解绑>"]) {
        
        if (self.bindingTime != 0 && self.bindingTime) {
        
            BOOL isCurrentMonth = [PublicClass isCurrentMonth:[NSString stringWithFormat:@"%ld",(long)self.bindingTime]];
            
            if (!isCurrentMonth) {
                
                [MBProgressHUD showTextMessage:@"当月只允许解绑一次！"];
                return;
            }
        }
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"如驿如意商家版" message:@"当月只能解绑一次支付宝账号，确定要解绑吗？" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"再看看" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            VTCodeView *vtcodeView = [[VTCodeView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height)];
            
            vtcodeView.block = ^(BOOL status) {
                
                if (status) {
                    
                    [MBProgressHUD showWaitMessage:@"正在解绑.." showView:self.view];
                    //调用解绑接口
                    [JJRequest interchangeablePostRequestWithIP:GL_RuYiRuYiIP path:@"/bindingInfo/updateUserAccountStatusInfo" params:@{@"storeId":[UserConfig user_id]} success:^(id  _Nullable data) {
                        
                        [MBProgressHUD hideWaitViewAnimated:self.view];
                        
                        if (data && data !=NULL && [[data objectForKey:@"isSuccess"] boolValue] == YES) {
                            
                            [MBProgressHUD showTextMessage:@"解绑成功！"];
                            
                            [sender setTitle:@"未绑定>" forState:UIControlStateNormal];
                            self.alipayPhoneLab.text = @"";
                        }
                        
                    } failure:^(NSError * _Nullable error) {
                        [MBProgressHUD hideWaitViewAnimated:self.view];
                    }];
                }
            };
            
            [vtcodeView showWithSuperView:self.view];
           
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        
    }else{
        
        AlipayInfoViewController *alipayInfoVC =  [[AlipayInfoViewController alloc]init];
        
        alipayInfoVC.name = self.alipayName;
        alipayInfoVC.IDNumber = self.alipayID;
        alipayInfoVC.account = self.alipayAccount;
        
        alipayInfoVC.block = ^(NSString *alipayPhone) {
            
            if (alipayPhone) {
                
                self.alipayPhoneLab.text = alipayPhone;
                [sender setTitle:@"解绑>" forState:UIControlStateNormal];
            }
        };
        
        [self.navigationController pushViewController:alipayInfoVC animated:YES];
        
        self.hidesBottomBarWhenPushed = YES;
    }
}

- (IBAction)weChatLogin:(UIButton *)sender{
    
    [MBProgressHUD showTextMessage:@"暂不支持微信提现！"];
    return;
    
//    VTCodeView *vtcodeView = [[VTCodeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    
//    vtcodeView.block = ^(BOOL status) {
//        
//        if (status) {
//            
//            WeChatViewController *wechatVC = [[WeChatViewController alloc]init];
//            wechatVC.block = ^(NSString *name,NSString *openID) {
//                
//                [sender setTitle:@"解绑>" forState:UIControlStateNormal];
//                self.wecahtNameLab.text = name;
//                self.wechatOpenID = openID;
//            };
//            
//            [self.navigationController pushViewController:wechatVC animated:YES];
//            self.hidesBottomBarWhenPushed = YES;
//        }
//    };
//    
//    [vtcodeView showWithSuperView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

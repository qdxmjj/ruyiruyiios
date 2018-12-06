//
//  AlipayInfoViewController.m
//  ruyiRuyi
//
//  Created by 姚永敏 on 2018/10/17.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "AlipayInfoViewController.h"
#import "VTCodeView.h"
#import "MBProgressHUD+YYM_category.h"
@interface AlipayInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *NameTextField;
@property (weak, nonatomic) IBOutlet UITextField *idNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *alipayAccountTextField;

@end

@implementation AlipayInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"绑定提现账户";
    
    self.edgesForExtendedLayout = UIRectEdgeAll;

    self.NameTextField.text = self.name;
    self.idNumberTextField.text = self.IDNumber;
    self.alipayAccountTextField.text = self.account;
    
    if (self.NameTextField.text.length>0) {
        self.NameTextField.enabled = NO;
    }
    
    if (self.idNumberTextField.text.length>0) {
        self.idNumberTextField.enabled = NO;
    }
    
}


- (IBAction)immediatelyBindingEvent:(UIButton *)sender {
    
    if (self.NameTextField.text.length == 0) {
        
        [MBProgressHUD showTextMessage:@"请输入真实姓名！"];
        return;
    }
    
    if (self.idNumberTextField.text.length<18) {
        
        [MBProgressHUD showTextMessage:@"身份证号错误！"];
        return;
    }
    
    if (self.alipayAccountTextField.text.length == 0) {
        
        [MBProgressHUD showTextMessage:@"请输入支付宝账号"];
        return;
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"如驿如意商家版" message:@"实名信息绑定后无法修改，确认绑定吗" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"再看看" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        VTCodeView *vtcodeView = [[VTCodeView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height)];
        
        vtcodeView.block = ^(BOOL status) {
            
            if (status) {
                
                [MBProgressHUD showWaitMessage:@"正在绑定.." showView:self.view];

                NSDictionary *params = @{@"userId":[UserConfig user_id],@"realName":self.NameTextField.text,@"iDNumber":self.idNumberTextField.text,@"aliAccount":self.alipayAccountTextField.text};
                
                [JJRequest interchangeablePostRequest:@"bindingInfo/bindingUserAccountInfo" params:params success:^(id data) {
                    
                    [MBProgressHUD hideWaitViewAnimated:self.view];
                    if ([[data objectForKey:@"isSuccess"] boolValue] == YES) {
                        
                        [MBProgressHUD showTextMessage:@"绑定支付宝成功"];
                        //绑定成功退出页面
                        self.block(self.alipayAccountTextField.text);
                        [self.navigationController popViewControllerAnimated:YES];
                    }else{
                        [MBProgressHUD showTextMessage:@"绑定失败！"];
                    }
                    
                } failure:^(NSError * _Nullable error) {
                    [MBProgressHUD hideWaitViewAnimated:self.view];
                }];
                
            }
        };
        
        [vtcodeView showWithSuperView:self.view];

    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

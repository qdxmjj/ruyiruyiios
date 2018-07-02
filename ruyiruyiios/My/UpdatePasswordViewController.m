//
//  UpdatePasswordViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/19.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "UpdatePasswordViewController.h"
#import "UpdatePasswordView.h"
#import "CodeLoginViewController.h"

@interface UpdatePasswordViewController ()

@property(nonatomic, strong)UpdatePasswordView *updatePasswordV;
@property(nonatomic, strong)UIButton *completeBtn;

@end

@implementation UpdatePasswordViewController

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
}

- (UpdatePasswordView *)updatePasswordV{
    
    if (_updatePasswordV == nil) {
        
        _updatePasswordV = [[UpdatePasswordView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, 130)];
    }
    return _updatePasswordV;
}

- (UIButton *)completeBtn{
    
    if (_completeBtn == nil) {
        
        _completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _completeBtn.frame = CGRectMake(10, MAINSCREEN.height - SafeDistance - 40, MAINSCREEN.width - 20, 34);
        _completeBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _completeBtn.layer.cornerRadius = 6.0;
        _completeBtn.layer.masksToBounds = YES;
        [_completeBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_completeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_completeBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [_completeBtn addTarget:self action:@selector(chickCompleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _completeBtn;
}

- (void)chickCompleteBtn:(UIButton *)button{
    
    if (self.updatePasswordV.originalTF.text.length == 0 || self.updatePasswordV.newTF.text.length == 0 || self.updatePasswordV.sureNewTF.text.length == 0) {
        
        [PublicClass showHUD:@"输入的内容不能为空" view:self.view];
    }else{
        
        if (![self.updatePasswordV.newTF.text isEqualToString:self.updatePasswordV.sureNewTF.text]) {
            
            [PublicClass showHUD:@"二次输入的密码不一致" view:self.view];
        }else{
            
            NSString *oldPasswordStr = [[PublicClass md5:self.updatePasswordV.originalTF.text] uppercaseString];
            NSString *newPasswordStr = [[PublicClass md5:self.updatePasswordV.newTF.text] uppercaseString];
            NSDictionary *changePostDic = @{@"phone":[UserConfig phone], @"oldPassword":oldPasswordStr, @"newPassword":newPasswordStr, @"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]]};
            NSString *reqJson = [PublicClass convertToJsonData:changePostDic];
            [JJRequest postRequest:@"changeUserPwdByOldPwd" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
                
                NSString *statusStr = [NSString stringWithFormat:@"%@", code];
                NSString *messageStr = [NSString stringWithFormat:@"%@", message];
                if ([statusStr isEqualToString:@"1"]) {
                    
                    CodeLoginViewController *codeLoginVC = [[CodeLoginViewController alloc] init];
                    codeLoginVC.homeTologinStr = @"2";
                    [self.navigationController pushViewController:codeLoginVC animated:YES];
                }else{
                    
                    [PublicClass showHUD:messageStr view:self.view];
                }
            } failure:^(NSError * _Nullable error) {
                
                NSLog(@"根据原密码修改密码错误:%@", error);
            }];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    [self.view addSubview:self.completeBtn];
    [self.view addSubview:self.updatePasswordV];
    // Do any additional setup after loading the view.
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

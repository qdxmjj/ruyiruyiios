//
//  ForgetPasswordViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/8.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "ForgetPasswordViewController.h"

@interface ForgetPasswordViewController ()<UITextFieldDelegate>{
    
    UITextField *telephoneTF;
    UITextField *codeTF;
    UITextField *resetPasswordTF;
    UITextField *surePasswordTF;
    UIButton *getCodeBtn;
    NSInteger timeCount;
}

@property(nonatomic, weak)NSTimer *timer;

@end

@implementation ForgetPasswordViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setHidden:NO];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"密码重置";
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height)];
    backBtn.tag = 2001;
    [backBtn addTarget:self action:@selector(chickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: backBtn];
    
    [self addCustomerView];
    [self addButtons];
    // Do any additional setup after loading the view.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

//2001背景按钮
- (void)chickBtn:(UIButton *)button{
    
    switch (button.tag) {
        case 2001:
            
            [telephoneTF resignFirstResponder];
            [codeTF resignFirstResponder];
            [resetPasswordTF resignFirstResponder];
            [surePasswordTF resignFirstResponder];
            break;
            
        case 2002:
            [self forgetYanZhengMa];
            break;
            
        default:
            break;
    }
}

- (void)forgetYanZhengMa{
    
    if (![PublicClass valiMobile:telephoneTF.text]) {
        
        [PublicClass showHUD:@"输入合法的手机号码" view:self.view];
    }else{
        
        NSDictionary *postDic = @{@"phone":telephoneTF.text};
        NSString *reqJson = [PublicClass convertToJsonData:postDic];
        [JJRequest postRequest:@"sendMsgChangePwd" params:@{@"reqJson":reqJson} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
            
            NSString *statusStr = [NSString stringWithFormat:@"%@", code];
            NSString *mesgStr = [NSString stringWithFormat:@"%@", message];
            if ([statusStr isEqualToString:@"-1"]) {
                
                [PublicClass showHUD:mesgStr view:self.view];
            }
            else{
                
                _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerValue) userInfo:nil repeats:YES];
                [_timer fire];
                [self timerValue];
            }
        } failure:^(NSError * _Nullable error) {
            NSLog(@"验证密码获取验证码错误:%@", error);
        }];
    }
}

- (void)timerValue{
    
    [getCodeBtn setTitle:[NSString stringWithFormat:@"等待(%ld)", (long)30 - timeCount] forState:UIControlStateNormal];
    [getCodeBtn setTitleColor:LOGINBACKCOLOR forState:UIControlStateNormal];
    [getCodeBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
    timeCount ++;
    if (timeCount == 30) {
        
        [_timer invalidate];
        _timer = nil;
        timeCount = 0;
        getCodeBtn.enabled = YES;
        [getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [getCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [getCodeBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
    }else{
        
        getCodeBtn.enabled = NO;
    }
}

- (void)addCustomerView{
    
    int offset = 35;
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake((MAINSCREEN.width/2 - 50), 36, 100, 100)];
    headImageView.image = [UIImage imageNamed:@"icon"];
    [self.view addSubview:headImageView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(35, (headImageView.frame.origin.y + headImageView.frame.size.height + offset), MAINSCREEN.width - 70, 200)];
    bottomView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bottomView];
    
    UIImageView *iphoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 0, 16, 26)];
    iphoneImageView.image = [UIImage imageNamed:@"手机"];
    [bottomView addSubview:iphoneImageView];
    
    telephoneTF = [[UITextField alloc] initWithFrame:CGRectMake(40, 0, bottomView.frame.size.width - 40, 25)];
    telephoneTF.borderStyle = UITextBorderStyleNone;
    telephoneTF.keyboardType = UIKeyboardTypeNumberPad;
    telephoneTF.delegate = self;
    telephoneTF.textColor = [UIColor lightGrayColor];
    telephoneTF.placeholder = @"请输入手机号码";
    [bottomView addSubview:telephoneTF];
    
    UIView *underLineView = [[UIView alloc] initWithFrame:CGRectMake(40, 26.5, bottomView.frame.size.width - 40, 0.5)];
    underLineView.backgroundColor = [UIColor lightGrayColor];
    [bottomView addSubview:underLineView];
    
    UIImageView *codeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 55, 22, 26)];
    codeImageView.image = [UIImage imageNamed:@"验证码(1)"];
    [bottomView addSubview:codeImageView];
    
    codeTF = [[UITextField alloc] initWithFrame:CGRectMake(40, 55, bottomView.frame.size.width - 40, 25)];
    codeTF.borderStyle = UITextBorderStyleNone;
    codeTF.keyboardType = UIKeyboardTypeNumberPad;
    codeTF.delegate = self;
    codeTF.textColor = [UIColor lightGrayColor];
    codeTF.placeholder = @"请输入验证码";
    [bottomView addSubview:codeTF];
    
    getCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(bottomView.frame.size.width - 90, 50, 90, 28)];
    getCodeBtn.tag = 2002;
    [getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [getCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    getCodeBtn.layer.cornerRadius = 15.0;
    getCodeBtn.layer.masksToBounds = YES;
    [getCodeBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
    [getCodeBtn addTarget:self action:@selector(chickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:getCodeBtn];
    
    UIView *underLineView1 = [[UIView alloc] initWithFrame:CGRectMake(40, 81, bottomView.frame.size.width - 40, 0.5)];
    underLineView1.backgroundColor = [UIColor lightGrayColor];
    [bottomView addSubview:underLineView1];
    
    UIImageView *resetPImageView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 109.5, 16, 26)];
    resetPImageView.image = [UIImage imageNamed:@"密码"];
    [bottomView addSubview:resetPImageView];
    
    resetPasswordTF = [[UITextField alloc] initWithFrame:CGRectMake(40, 109.5, bottomView.frame.size.width - 40, 25)];
    resetPasswordTF.borderStyle = UITextBorderStyleNone;
    resetPasswordTF.delegate = self;
    resetPasswordTF.secureTextEntry = YES;
    resetPasswordTF.textColor = [UIColor lightGrayColor];
    resetPasswordTF.placeholder = @"请重置你的密码";
    [bottomView addSubview:resetPasswordTF];
    
    UIView *underLineView2 = [[UIView alloc] initWithFrame:CGRectMake(40, 136, bottomView.frame.size.width - 40, 0.5)];
    underLineView2.backgroundColor = [UIColor lightGrayColor];
    [bottomView addSubview:underLineView2];
    
    UIImageView *surePImageView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 164.5, 16, 26)];
    surePImageView.image = [UIImage imageNamed:@"密码"];
    [bottomView addSubview:surePImageView];
    
    surePasswordTF = [[UITextField alloc] initWithFrame:CGRectMake(40, 164.5, bottomView.frame.size.width - 40, 25)];
    surePasswordTF.borderStyle = UITextBorderStyleNone;
    surePasswordTF.secureTextEntry = YES;
    surePasswordTF.delegate = self;
    surePasswordTF.textColor = [UIColor lightGrayColor];
    surePasswordTF.placeholder = @"请确认你的密码";
    [bottomView addSubview:surePasswordTF];
    
    UIView *underLineView3 = [[UIView alloc] initWithFrame:CGRectMake(40, 191, bottomView.frame.size.width - 40, 0.5)];
    underLineView3.backgroundColor = [UIColor lightGrayColor];
    [bottomView addSubview:underLineView3];
}

- (void)addButtons{
    
    UIButton *resetButton = [[UIButton alloc] initWithFrame:CGRectMake(55, 406, MAINSCREEN.width - 110, 40)];
    resetButton.layer.cornerRadius = 22.0;
    resetButton.layer.masksToBounds = YES;
    resetButton.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:20.0];
    [resetButton setTitle:@"密码重置" forState:UIControlStateNormal];
    [resetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [resetButton setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
    [resetButton addTarget:self action:@selector(chickResetBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetButton];
}

- (void)chickResetBtn{
    
    if (telephoneTF.text.length == 0 || codeTF.text.length == 0 || resetPasswordTF.text.length == 0 || surePasswordTF.text.length == 0) {
        
        [PublicClass showHUD:@"输入不能为空" view:self.view];
    }else if (![PublicClass valiMobile:telephoneTF.text]){
        
        [PublicClass showHUD:@"请输入合法的手机号" view:self.view];
    }else if (![resetPasswordTF.text isEqualToString:surePasswordTF.text]){
        
        [PublicClass showHUD:@"二次输入的密码不一致" view:self.view];
    }else{
        
        NSString *md5PasswordStr = [[PublicClass md5:resetPasswordTF.text] uppercaseString];
        NSDictionary *resetPostforgetDic = @{@"password":md5PasswordStr, @"phone":telephoneTF.text, @"code":codeTF.text};
        NSString *resetPasswordReqjson = [PublicClass convertToJsonData:resetPostforgetDic];
        [JJRequest postRequest:@"changeUserPwd" params:@{@"reqJson":resetPasswordReqjson} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
            
            NSString *statusStr = [NSString stringWithFormat:@"%@", code];
            NSString *messStr = [NSString stringWithFormat:@"%@", message];
            if ([statusStr isEqualToString:@"-1"]) {
                
                [PublicClass showHUD:messStr view:self.view];
            }else{
                
                [PublicClass showHUD:messStr view:self.view];
                [_timer invalidate];
                _timer = nil;
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSError * _Nullable error) {
            
            NSLog(@"修改密码接口错误:%@",error);
        }];
        
    }
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

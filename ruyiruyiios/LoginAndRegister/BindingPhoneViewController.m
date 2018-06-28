//
//  BindingPhoneViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/27.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "BindingPhoneViewController.h"
#import "MainTabBarViewController.h"
#import "RegisterViewController.h"
#import "FMDBUserInfo.h"
#import "DelegateConfiguration.h"

@interface BindingPhoneViewController ()<UITextFieldDelegate>{
    
    NSInteger timeCount;
}

@property(nonatomic, weak)NSTimer *timer;
@property(nonatomic, strong)UITextField *telephoneTF;
@property(nonatomic, strong)UITextField *codeTF;
@property(nonatomic, strong)UIButton *getCodeBtn;
@property(nonatomic, strong)UILabel *detialLabel;
@property(nonatomic, strong)UIButton *sureBtn;

@end

@implementation BindingPhoneViewController
@synthesize weixinIDStr;

- (void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.navigationBar.hidden = YES;
}

- (UITextField *)telephoneTF{
    
    if (_telephoneTF == nil) {
        
        _telephoneTF = [[UITextField alloc] initWithFrame:CGRectMake(72, 40, MAINSCREEN.width - 112, 25)];
        _telephoneTF.borderStyle = UITextBorderStyleNone;
        _telephoneTF.keyboardType = UIKeyboardTypeNumberPad;
        _telephoneTF.delegate = self;
        _telephoneTF.textColor = [UIColor lightGrayColor];
        _telephoneTF.placeholder = @"请输入手机号码";
    }
    return _telephoneTF;
}

- (UITextField *)codeTF{
    
    if (_codeTF == nil) {
        
        _codeTF = [[UITextField alloc] initWithFrame:CGRectMake(72, 95, MAINSCREEN.width - 112, 25)];
        _codeTF.borderStyle = UITextBorderStyleNone;
        _codeTF.keyboardType = UIKeyboardTypeNumberPad;
        _codeTF.delegate = self;
        _codeTF.textColor = [UIColor lightGrayColor];
        _codeTF.placeholder = @"请输入验证码";
    }
    return _codeTF;
}

- (UIButton *)getCodeBtn{
    
    if (_getCodeBtn == nil) {
        
        _getCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(MAINSCREEN.width - 130, 90, 90, 28)];
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_getCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _getCodeBtn.layer.cornerRadius = 15.0;
        _getCodeBtn.layer.masksToBounds = YES;
        [_getCodeBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [_getCodeBtn addTarget:self action:@selector(chickGetCodeBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getCodeBtn;
}

- (UILabel *)detialLabel{
    
    if (_detialLabel == nil) {
        
        _detialLabel = [[UILabel alloc] init];
        [_detialLabel setNumberOfLines:0];
        _detialLabel.text = @"*已注册过如驿如意App的手机号将绑定该微信，可通过微信直接登录原账号，未注册过的手机号将注册新的如驿如意App";
        _detialLabel.textColor = TEXTCOLOR64;
        _detialLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attrubutes = @{NSFontAttributeName: _detialLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        CGSize labelSize = [_detialLabel.text boundingRectWithSize:CGSizeMake(MAINSCREEN.width - 80, MAINSCREEN.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrubutes context:nil].size;
        [_detialLabel setFrame:CGRectMake(40, 160, labelSize.width, labelSize.height)];
    }
    return _detialLabel;
}

- (UIButton *)sureBtn{
    
    if (_sureBtn == nil) {
        
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame = CGRectMake(40, self.detialLabel.frame.size.height + self.detialLabel.frame.origin.y + 40, MAINSCREEN.width - 80, 40);
        _sureBtn.layer.cornerRadius = 10.0;
        _sureBtn.layer.masksToBounds = YES;
        _sureBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        [_sureBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sureBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(chickSureBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"绑定手机号";
    NSArray *imgArray = @[@"手机", @"验证码(1)"];
    [self addViews:imgArray];
    // Do any additional setup after loading the view.
}

- (void)addViews:(NSArray *)array{
    
    for (int i = 0; i<array.count; i++) {
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(40, 38+55*i, 22, 26)];
        img.image = [UIImage imageNamed:array[i]];
        
        UIView *underLineView = [[UIView alloc] initWithFrame:CGRectMake(72, 68+55*i, MAINSCREEN.width - 112, 0.5)];
        underLineView.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:img];
        [self.view addSubview:underLineView];
    }
    [self.view addSubview:self.telephoneTF];
    [self.view addSubview:self.codeTF];
    [self.view addSubview:self.getCodeBtn];
    [self.view addSubview:self.detialLabel];
    [self.view addSubview:self.sureBtn];
}

- (void)chickGetCodeBtn:(UIButton *)button{
    
    if (![PublicClass valiMobile:self.telephoneTF.text]) {
        
        [PublicClass showHUD:@"输入合法的手机号码" view:self.view];
    }else{
        
        NSDictionary *postDic = [[NSDictionary alloc] initWithObjectsAndKeys:self.telephoneTF.text, @"phone", nil];
        NSString *reqJson = [PublicClass convertToJsonData:postDic];
        [JJRequest postRequest:@"sendMsg" params:@{@"reqJson":reqJson} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
            
            NSString *statusStr = [NSString stringWithFormat:@"%@", code];
            NSString *mesgStr = [NSString stringWithFormat:@"%@", message];
            if ([statusStr isEqualToString:@"-1"]) {
                
                [PublicClass showHUD:mesgStr view:self.view];
            }else{
                
                _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerValue) userInfo:nil repeats:YES];
                [_timer fire];
                [self timerValue];
            }
        } failure:^(NSError * _Nullable error) {
            
            NSLog(@"登录获取验证码错误:%@", error);
        }];
    }
}

//调用定时器
- (void)timerValue{
    
    [self.getCodeBtn setTitle:[NSString stringWithFormat:@"等待(%ld)",(long)30 - timeCount] forState:UIControlStateNormal];
    [self.getCodeBtn setTitleColor:LOGINBACKCOLOR forState:UIControlStateNormal];
    [self.getCodeBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
    timeCount ++;
    NSLog(@"time = %ld",(long)timeCount);
    if (timeCount == 30) {
        
        [_timer invalidate];
        _timer = nil;
        timeCount = 0;
        self.getCodeBtn.enabled = YES;
        [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.getCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.getCodeBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
    }else{
        
        self.getCodeBtn.enabled = NO;
    }
    
}

- (void)chickSureBtn:(UIButton *)button{
    
    if (self.telephoneTF.text.length == 0 || self.codeTF.text.length == 0) {
        
        [PublicClass showHUD:@"输入不能为空" view:self.view];
    }else if (![PublicClass valiMobile:self.telephoneTF.text]){
        
        [PublicClass showHUD:@"输入合法的手机号" view:self.view];
    }else{
        
        NSDictionary *loginpostDic =@{@"phone":self.telephoneTF.text,@"code":self.codeTF.text, @"wxInfoId":weixinIDStr};
        NSString *loginreqJson = [PublicClass convertToJsonData:loginpostDic];
        [JJRequest postRequest:@"verificationCode" params:@{@"reqJson":loginreqJson} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
            
            NSString *statusStr = [NSString stringWithFormat:@"%@", code];
            NSString *messStr = [NSString stringWithFormat:@"%@", message];
            [_timer invalidate];
            _timer = nil;
            if ([statusStr isEqualToString:@"111111"]) {
                
                //保存数据库操作
                NSLog(@"验证码登录返回数据:%@", data);
                [self insertDatabase:data];
                
                DelegateConfiguration *delegateConfiguration = [DelegateConfiguration sharedConfiguration];
                [delegateConfiguration removeAllDelegateMutableA];
                MainTabBarViewController *mainTabVC = [[MainTabBarViewController alloc] init];
                [self.navigationController pushViewController:mainTabVC animated:YES];
            }else if ([statusStr isEqualToString:@"-1"]){
                
                [PublicClass showHUD:messStr view:self.view];
            }else if ([statusStr isEqualToString:@"-2"]){
                
                [PublicClass showHUD:messStr view:self.view];
            }else{
                
                RegisterViewController *registerVC = [[RegisterViewController alloc] init];
                registerVC.teleStr = self.telephoneTF.text;
                [self.navigationController pushViewController:registerVC animated:YES];
            }
        } failure:^(NSError * _Nullable error) {
            
            NSLog(@"登录请求错误:%@", error);
        }];
    }
}

- (void)insertDatabase:(NSDictionary *)dataDic{
    
    FMDBUserInfo *userInfo = [[FMDBUserInfo alloc] init];
    [userInfo setValuesForKeysWithDictionary:dataDic];
    [UserConfig userDefaultsSetObject:userInfo.age key:@"age"];
    [UserConfig userDefaultsSetObject:userInfo.birthday key:@"birthday"];
    [UserConfig userDefaultsSetObject:userInfo.createTime key:@"createTime"];
    [UserConfig userDefaultsSetObject:userInfo.createdBy key:@"createdBy"];
    [UserConfig userDefaultsSetObject:userInfo.createdTime key:@"createdTime"];
    [UserConfig userDefaultsSetObject:userInfo.deletedBy key:@"deletedBy"];
    [UserConfig userDefaultsSetObject:userInfo.deletedFlag key:@"deletedFlag"];
    [UserConfig userDefaultsSetObject:userInfo.deletedTime key:@"deletedTime"];
    [UserConfig userDefaultsSetObject:userInfo.email key:@"email"];
    [UserConfig userDefaultsSetObject:userInfo.firstAddCar key:@"firstAddCar"];
    [UserConfig userDefaultsSetObject:userInfo.gender key:@"gender"];
    [UserConfig userDefaultsSetObject:userInfo.headimgurl key:@"headimgurl"];
    [UserConfig userDefaultsSetObject:userInfo.user_id key:@"user_id"];
    [UserConfig userDefaultsSetObject:userInfo.invitationCode key:@"invitationCode"];
    [UserConfig userDefaultsSetObject:userInfo.lastUpdatedBy key:@"lastUpdatedBy"];
    [UserConfig userDefaultsSetObject:userInfo.lastUpdatedTime key:@"lastUpdatedTime"];
    [UserConfig userDefaultsSetObject:userInfo.ml key:@"ml"];
    [UserConfig userDefaultsSetObject:userInfo.nick key:@"nick"];
    [UserConfig userDefaultsSetObject:userInfo.password key:@"password"];
    [UserConfig userDefaultsSetObject:userInfo.payPwd key:@"payPwd"];
    [UserConfig userDefaultsSetObject:userInfo.phone key:@"phone"];
    [UserConfig userDefaultsSetObject:userInfo.qqInfoId key:@"qqInfoId"];
    [UserConfig userDefaultsSetObject:userInfo.remark key:@"remark"];
    [UserConfig userDefaultsSetObject:userInfo.status key:@"status"];
    [UserConfig userDefaultsSetObject:userInfo.token key:@"token"];
    [UserConfig userDefaultsSetObject:userInfo.updateTime key:@"updateTime"];
    [UserConfig userDefaultsSetObject:userInfo.version key:@"version"];
    [UserConfig userDefaultsSetObject:userInfo.wxInfoId key:@"wxInfoId"];
}

//UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
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

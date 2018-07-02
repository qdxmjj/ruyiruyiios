//
//  CodeLoginViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/7.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "CodeLoginViewController.h"
#import "MainTabBarViewController.h"
#import "ForgetPasswordViewController.h"
#import "RegisterViewController.h"
#import "FMDBUserInfo.h"
#import "DBRecorder.h"
#import "UILabel+YBAttributeTextTapAction.h"
#import "UserProtocolViewController.h"
#import "JJUILabel.h"
#import "DelegateConfiguration.h"
#import "WXApi.h"
#import "AppDelegate.h"
#import <AFNetworking.h>
#import "BindingPhoneViewController.h"
#import "DelegateConfiguration.h"

@interface CodeLoginViewController ()<UITextFieldDelegate, YBAttributeTapActionDelegate, WXApiDelegate>{
    
    UITextField *telephoneTF;
    UITextField *codeTF;
    UIButton *passwordBtn;
    UIButton *getCodeBtn;
    UIImageView *codeImageView;
    NSInteger timeCount;
    int offset;
}

@property(nonatomic, weak)NSTimer *timer;
@property(nonatomic, strong)JJUILabel *promptLabel;
@property(nonatomic, strong)UIView *bottomView;
@property(nonatomic, strong)UIImageView *headImageView;

@end

@implementation CodeLoginViewController
@synthesize homeTologinStr;

- (void)viewWillAppear:(BOOL)animated{
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.tabBarController.tabBar.hidden = YES;
    if ([homeTologinStr isEqualToString:@"1"]) {
        
        [self.navigationController.navigationBar setHidden:NO];
    }else{
        
        [self.navigationController.navigationBar setHidden:YES];
    }
//    [self.navigationController.navigationBar setHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
}

- (UIImageView *)headImageView{
    
    if (_headImageView == nil) {
        
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake((MAINSCREEN.width/2 - 50), 36+(SafeAreaTopHeight - 64), 100, 100)];
        _headImageView.image = [UIImage imageNamed:@"icon"];
    }
    return _headImageView;
}

- (UILabel *)promptLabel{
    
    if (_promptLabel == nil) {
        
        _promptLabel = [[JJUILabel alloc] initWithFrame:CGRectMake(0, 94, _bottomView.frame.size.width, 54)];
        NSString *str = @"未注册小马驾驾账号的手机号，登录时将自动完成注册，且代表您已阅读并同意《小马驾驾用户协议》";
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(str.length - 10, 10)];
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, str.length - 10)];
        _promptLabel.attributedText = attrStr;
        _promptLabel.numberOfLines = 0;
        _promptLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _promptLabel.font = [UIFont systemFontOfSize:14.0];
        _promptLabel.backgroundColor = [UIColor clearColor];
        [_promptLabel setVerticalAlignment:VerticalAlignmentTop]; 
        [_promptLabel yb_addAttributeTapActionWithStrings:@[@"《小马驾驾用户协议》"] delegate:self];
    }
    return _promptLabel;
}

- (UIView *)bottomView{
    
    if (_bottomView == nil) {
        
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(35, (_headImageView.frame.origin.y + _headImageView.frame.size.height + offset), MAINSCREEN.width - 70, 140)];
        _bottomView.backgroundColor = [UIColor clearColor];
    }
    return _bottomView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weiXinLoginCallBack:) name:@"weiXinLoginCallBack" object:nil];
    self.navigationItem.title = @"登录";
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height)];
    backBtn.tag = 1001;
    [backBtn addTarget:self action:@selector(chickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: backBtn];
    
    [self addCustomerView];
    [self addButtons];
    [self addthridView];
    // Do any additional setup after loading the view.
}

- (void)addCustomerView{
    
    offset = 35;
    
    [self.view addSubview:self.headImageView];
    
    [self.view addSubview:self.bottomView];
    
    UIImageView *iphoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 0, 16, 26)];
    iphoneImageView.image = [UIImage imageNamed:@"手机"];
    [_bottomView addSubview:iphoneImageView];

    telephoneTF = [[UITextField alloc] initWithFrame:CGRectMake(40, 0, _bottomView.frame.size.width - 40, 25)];
    telephoneTF.borderStyle = UITextBorderStyleNone;
    telephoneTF.keyboardType = UIKeyboardTypeNumberPad;
    telephoneTF.delegate = self;
    telephoneTF.textColor = [UIColor lightGrayColor];
    telephoneTF.placeholder = @"请输入手机号码";
    [_bottomView addSubview:telephoneTF];
    
    UIView *underLineView = [[UIView alloc] initWithFrame:CGRectMake(40, 26.5, _bottomView.frame.size.width - 40, 0.5)];
    underLineView.backgroundColor = [UIColor lightGrayColor];
    [_bottomView addSubview:underLineView];
    
    codeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 55, 22, 26)];
    codeImageView.image = [UIImage imageNamed:@"验证码(1)"];
    [_bottomView addSubview:codeImageView];
    
    codeTF = [[UITextField alloc] initWithFrame:CGRectMake(40, 55, _bottomView.frame.size.width - 40, 25)];
    codeTF.borderStyle = UITextBorderStyleNone;
    codeTF.keyboardType = UIKeyboardTypeNumberPad;
    codeTF.delegate = self;
    codeTF.textColor = [UIColor lightGrayColor];
    codeTF.placeholder = @"请输入验证码";
    [_bottomView addSubview:codeTF];
    
    getCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(_bottomView.frame.size.width - 90, 50, 90, 28)];
    getCodeBtn.tag = 1002;
    [getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [getCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    getCodeBtn.layer.cornerRadius = 15.0;
    getCodeBtn.layer.masksToBounds = YES;
    [getCodeBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
    [getCodeBtn addTarget:self action:@selector(chickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:getCodeBtn];
    
    UIView *underLineView1 = [[UIView alloc] initWithFrame:CGRectMake(40, 81, _bottomView.frame.size.width - 40, 0.5)];
    underLineView1.backgroundColor = [UIColor lightGrayColor];
    [_bottomView addSubview:underLineView1];
    [_bottomView addSubview:self.promptLabel];
}

//delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (void)yb_attributeTapReturnString:(NSString *)string range:(NSRange)range index:(NSInteger)index{
    
    UserProtocolViewController *userProtocolVC = [[UserProtocolViewController alloc] init];
    userProtocolVC.dealIdStr = @"1";
    [self.navigationController pushViewController:userProtocolVC animated:YES];
}

- (void)addButtons{
    
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(45, 331 + (SafeAreaTopHeight - 64), MAINSCREEN.width - 90, 40)];
    loginButton.tag = 1003;
    loginButton.layer.cornerRadius = 22.0;
    loginButton.layer.masksToBounds = YES;
    loginButton.titleLabel.font = [UIFont fontWithName:TEXTFONT size:20.0];
    loginButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(chickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [loginButton setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
    [self.view addSubview:loginButton];
    
    passwordBtn = [[UIButton alloc] initWithFrame:CGRectMake(MAINSCREEN.width/2 - 40, 381+(SafeAreaTopHeight - 64), 80, 20)];
    passwordBtn.tag = 1004;
    passwordBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:12.0];
    [passwordBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [passwordBtn setTitle:@"密码登录" forState:UIControlStateNormal];
    [passwordBtn setImage:[UIImage imageNamed:@"切换登录方式"] forState:UIControlStateNormal];
    passwordBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    passwordBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [passwordBtn setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 10.0)];
    [passwordBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, 70.0, 0.0, 0.0)];
    [passwordBtn addTarget:self action:@selector(chickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:passwordBtn];
}

//调用定时器
- (void)timerValue{
    
    [getCodeBtn setTitle:[NSString stringWithFormat:@"等待(%ld)",(long)30 - timeCount] forState:UIControlStateNormal];
    [getCodeBtn setTitleColor:LOGINBACKCOLOR forState:UIControlStateNormal];
    [getCodeBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
    timeCount ++;
    NSLog(@"time = %ld",(long)timeCount);
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

- (void)addthridView{
    
    UIView *thridView = [[UIView alloc] initWithFrame:CGRectMake(15, MAINSCREEN.height - 105 - SafeDistance, MAINSCREEN.width - 30, 115)];
    thridView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:thridView];
    
    UILabel *loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(thridView.frame.size.width/2 - 40, 10, 80, 20)];
    loginLabel.text = @"第三方登录";
    loginLabel.font = [UIFont systemFontOfSize:14.0];
    loginLabel.textColor = [UIColor lightGrayColor];
    loginLabel.backgroundColor = [UIColor clearColor];
    loginLabel.textAlignment = NSTextAlignmentCenter;
    [thridView addSubview:loginLabel];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 21, thridView.frame.size.width/2- 40, 0.5)];
    leftView.backgroundColor = [UIColor lightGrayColor];
    [thridView addSubview:leftView];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(thridView.frame.size.width/2 + 40, 21, thridView.frame.size.width/2- 40, 0.5)];
    rightView.backgroundColor = [UIColor lightGrayColor];
    [thridView addSubview:rightView];
    
    UIButton *wxButton = [[UIButton alloc] initWithFrame:CGRectMake(thridView.frame.size.width/2 - 25, 40, 50, 66)];
    wxButton.tag = 1005;
    wxButton.backgroundColor = [UIColor clearColor];
    wxButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    wxButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [wxButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [wxButton setTitle:@"微信" forState:UIControlStateNormal];
    [wxButton setImage:[UIImage imageNamed:@"微信-2"] forState:UIControlStateNormal];
    [wxButton setImageEdgeInsets:UIEdgeInsetsMake(-16.0, 4.0, 0.0, 0.0)];
    [wxButton setTitleEdgeInsets:UIEdgeInsetsMake(wxButton.imageView.frame.size.height+4, -36.0, 0.0, 0.0)];
    [wxButton addTarget:self action:@selector(chickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [thridView addSubview:wxButton];
}

- (void)chickBtn:(UIButton *)button{
    
    //1001背景按钮，1002获取验证码，1003登录，1004密码登录，1005微信登录
    switch (button.tag) {
        case 1001:
            [telephoneTF resignFirstResponder];
            [codeTF resignFirstResponder];
            break;
            
        case 1002:
            
            if ([getCodeBtn.titleLabel.text isEqualToString:@"获取验证码"]) {
                
                [self getYanZhengMa];
            }else{
                
                [self forgetPassword];
            }
            break;
            
        case 1003:
            
            if ([getCodeBtn.titleLabel.text isEqualToString:@"忘记密码？"]) {
                
                [self chickPassLoginBtn];
            }else{
                
                [self chickLoginBtn];
            }
            break;
            
        case 1004:
            
            if ([passwordBtn.titleLabel.text isEqualToString:@"密码登录"]) {
                
                codeImageView.image = [UIImage imageNamed:@"密码"];
                [passwordBtn setTitle:@"验证码登录" forState:UIControlStateNormal];
                [getCodeBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
                [getCodeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                [getCodeBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [getCodeBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateSelected];
                codeTF.placeholder = @"请输入密码";
                codeTF.text = @"";
                codeTF.secureTextEntry = YES;
                codeTF.keyboardType = UIKeyboardTypeDefault;
            }else{
                
                codeImageView.image = [UIImage imageNamed:@"验证码(1)"];
                [passwordBtn setTitle:@"密码登录" forState:UIControlStateNormal];
                [getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                [getCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [getCodeBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
                codeTF.placeholder = @"请输入验证码";
                codeTF.text = @"";
                codeTF.secureTextEntry = NO;
                codeTF.keyboardType = UIKeyboardTypeNumberPad;
            }
        
            break;
        case 1005:
            
            [self chickWeiXinBtn];
            break;
            
        default:
            break;
    }
}

- (void)getYanZhengMa{
    
    if (![PublicClass valiMobile:telephoneTF.text]) {

        [PublicClass showHUD:@"输入合法的手机号码" view:self.view];
    }else{

        NSDictionary *postDic = [[NSDictionary alloc] initWithObjectsAndKeys:telephoneTF.text, @"phone", nil];
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

- (void)forgetPassword{
    
    ForgetPasswordViewController *forgetVC = [[ForgetPasswordViewController alloc] init];
    [self.navigationController pushViewController:forgetVC animated:YES];
}

- (void)chickLoginBtn{
    
    if (telephoneTF.text.length == 0 || codeTF.text.length == 0) {
        
        [PublicClass showHUD:@"输入不能为空" view:self.view];
    }else if (![PublicClass valiMobile:telephoneTF.text]){
        
        [PublicClass showHUD:@"输入合法的手机号" view:self.view];
    }else{
        
        NSDictionary *loginpostDic =@{@"phone":telephoneTF.text,@"code":codeTF.text};
        NSString *loginreqJson = [PublicClass convertToJsonData:loginpostDic];
        [JJRequest postRequest:@"verificationCode" params:@{@"reqJson":loginreqJson} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
            
            NSString *statusStr = [NSString stringWithFormat:@"%@", code];
            NSString *messStr = [NSString stringWithFormat:@"%@", message];
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
                
                [_timer invalidate];
                _timer = nil;
                RegisterViewController *registerVC = [[RegisterViewController alloc] init];
                registerVC.teleStr = telephoneTF.text;
                [self.navigationController pushViewController:registerVC animated:YES];
            }
        } failure:^(NSError * _Nullable error) {
            
            NSLog(@"登录请求错误:%@", error);
        }];
    }
}

//password login
- (void)chickPassLoginBtn{
    
    DelegateConfiguration *delegateConfiguation = [DelegateConfiguration sharedConfiguration];
    if (telephoneTF.text.length == 0 || codeTF.text.length == 0) {
        
        [PublicClass showHUD:@"输入不能为空" view:self.view];
    }else{
        
        NSString *md5Str = [[PublicClass md5:codeTF.text] uppercaseString];
        NSDictionary *loginpostDic =@{@"phone":telephoneTF.text,@"password":md5Str};
        NSString *loginreqJson = [PublicClass convertToJsonData:loginpostDic];
        [JJRequest postRequest:@"pwdLogin" params:@{@"reqJson":loginreqJson} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
            
            NSString *statusStr = [NSString stringWithFormat:@"%@", code];
            NSString *messStr = [NSString stringWithFormat:@"%@", message];
            if ([statusStr isEqualToString:@"111111"]) {
                
                [_timer invalidate];
                _timer = nil;
                NSLog(@"登录返回的数据:%@", data);
                [self insertDatabase:data];
                [delegateConfiguation changeLoginStatus];
                
                //从修改密码的页面跳转
                if ([homeTologinStr isEqualToString:@"2"]) {
                    
                    self.tabBarController.tabBar.hidden = NO;
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }else{
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }
//                MainTabBarViewController *mainTabVC = [[MainTabBarViewController alloc] init];
//                [self.navigationController pushViewController:mainTabVC animated:YES];
            }else if ([statusStr isEqualToString:@"100001"]){
                
                [PublicClass showHUD:messStr view:self.view];
            }else{
                
                [PublicClass showHUD:messStr view:self.view];
            }
        } failure:^(NSError * _Nullable error) {
            
            NSLog(@"请求错误:%@", error);
        }];
    }
}

- (void)chickWeiXinBtn{
    
    if ([WXApi isWXAppInstalled]) {
        
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.scope = @"snsapi_userinfo";
        req.openID = WEIXINID;
        req.state = @"12345";
        [WXApi sendReq:req];
    }else{
        
        [PublicClass showHUD:@"微信未安装" view:self.view];
    }
}

//weixin Login success
- (void)weiXinLoginCallBack:(NSNotification *)notification{
    
    NSString *codeStr = notification.userInfo[@"key"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json",@"text/plain", nil, nil];
    [manager GET:[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",WEIXINID,@"62a20f41249091afa6075d3cfb7ea93f",codeStr] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {  //获得access_token，然后根据access_token获取用户信息请求。
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"dic %@",dic);
        
        [self checkWXInfoIdToInternet:dic];
        /*
         access_token   接口调用凭证
         expires_in access_token接口调用凭证超时时间，单位（秒）
         refresh_token  用户刷新access_token
         openid 授权用户唯一标识
         scope  用户授权的作用域，使用逗号（,）分隔
         unionid     当且仅当该移动应用已获得该用户的userinfo授权时，才会出现该字段
         */
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error %@",error.localizedFailureReason);
    }];
}

- (void)checkWXInfoIdToInternet:(NSDictionary *)wxDic{
    
    NSDictionary *postDic = @{@"wxInfoId":[wxDic objectForKey:@"openid"]};
//    NSLog(@"%@", [wxDic objectForKey:@"openid"]);
    NSString *reqJson = [PublicClass convertToJsonData:postDic];
    [JJRequest postRequest:@"checkWXInfoId" params:@{@"reqJson":reqJson} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
            NSLog(@"微信授权登录的返回数据:%@", data);
            [self insertDatabase:data];
            [self.navigationController popViewControllerAnimated:YES];
        }else if ([statusStr isEqualToString:@"2"]){
            
            BindingPhoneViewController *bindingVC = [[BindingPhoneViewController alloc] init];
            bindingVC.weixinIDStr = [wxDic objectForKey:@"openid"];
            [self.navigationController pushViewController:bindingVC animated:YES];
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"查询用户是否绑定微信错误:%@", error);
    }];
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

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"weiXinLoginCallBack" object:nil];
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

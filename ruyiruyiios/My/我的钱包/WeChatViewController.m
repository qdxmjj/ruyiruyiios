//
//  WeChatViewController.m
//  ruyiRuyi
//
//  Created by 姚永敏 on 2018/10/17.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "WeChatViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "MBProgressHUD+YYM_category.h"
#import <UIImageView+WebCache.h>
@interface WeChatViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *wechatHeadPortrait;
@property (weak, nonatomic) IBOutlet UILabel *wechatName;

@property (weak, nonatomic) IBOutlet UITextField *actualNameTextfield;

@property (copy, nonatomic) NSString *openid;
@end

@implementation WeChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"补充提现信息";
    
    [MBProgressHUD showWaitMessage:@"正在进行微信认证.." showView:self.view];
    
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        
        [MBProgressHUD hideWaitViewAnimated:self.view];
        
        if (state == SSDKResponseStateSuccess)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"已获取授权"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            
            NSLog(@"uid=%@"        ,user.uid);
            NSLog(@"%@"            ,user.credential);
            NSLog(@"token=%@"      ,user.credential.token);
            NSLog(@"nickname=%@"   ,user.nickname);
            NSLog(@"rawData=%@"   ,user.rawData);
            
            self.openid = [user.rawData objectForKey:@"openid"];
            
            self.wechatName.text = user.nickname;
            
            [self.wechatHeadPortrait sd_setImageWithURL:[NSURL URLWithString:user.icon]];
            
            
        }else if (state == SSDKResponseStateCancel){
            
            [MBProgressHUD showTextMessage:@"用户取消认证!"];
            [self.navigationController popViewControllerAnimated:NO];
        }
        else
        {
            [MBProgressHUD showTextMessage:@"微信认证失败!"];
            [self.navigationController popViewControllerAnimated:NO];
        }
    }];
}


- (IBAction)submitEvent:(UIButton *)sender {
    
    if (self.actualNameTextfield.text.length<=0) {
        
        [MBProgressHUD showTextMessage:@"请填写您的真实姓名！"];
        return;
    }
    
    self.block(self.actualNameTextfield.text,self.openid);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

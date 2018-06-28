//
//  UserProtocolViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/14.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "UserProtocolViewController.h"
#import <SVProgressHUD.h>

@interface UserProtocolViewController ()<UIWebViewDelegate>

@property(nonatomic, strong)UIWebView *mainWebV;

@end

@implementation UserProtocolViewController
@synthesize dealIdStr;

- (void)viewWillAppear:(BOOL)animated{
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController.navigationBar setHidden:NO];
    self.tabBarController.tabBar.hidden = YES;
}

- (UIWebView *)mainWebV{
    
    if (_mainWebV == nil) {
        
        _mainWebV = [[UIWebView alloc] initWithFrame:CGRectMake(20, 0, MAINSCREEN.width - 40, MAINSCREEN.height - SafeDistance)];
        _mainWebV.delegate = self;
        _mainWebV.clipsToBounds = NO;
    }
    return _mainWebV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"用户协议";
    [self.view addSubview:self.mainWebV];
    [self getDeal:dealIdStr];
    // Do any additional setup after loading the view.
}

- (void)getDeal:(NSString *)dealStr{
    
    [SVProgressHUD showWithStatus:BeingLoaded];
    NSDictionary *dealPostDic = @{@"dealId":dealStr};
    NSString *reqJson = [PublicClass convertToJsonData:dealPostDic];
    [JJRequest postRequest:@"getDeal" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
//            YLog(@"%@", data);
            [self analySize:data];
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"获取协议错误:%@", error);
    }];
}

- (void)analySize:(NSDictionary *)dataDic{
    
    NSString *contentStr = [self htmlEntityDecode:[dataDic objectForKey:@"content"]];
    [self.mainWebV loadHTMLString:contentStr baseURL:nil];
}

//将 &lt 等类似的字符转化为HTML中的“<”等
- (NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]; // Do this last so that, e.g. @"&amp;lt;" goes to @"&lt;" not @"<"
    
    return string;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [SVProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [SVProgressHUD dismiss];
    [PublicClass showHUD:@"加载失败" view:self.view];
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

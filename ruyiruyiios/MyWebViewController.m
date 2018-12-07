//
//  MyWebViewController.m
//  JCMO
//
//  Created by JCreate on 2017/7/24.
//  Copyright © 2017年 JCreate. All rights reserved.
//

#import "MyWebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "YMTools.h"
#import "JJShare.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
@interface MyWebViewController ()<UIWebViewDelegate>

@property(nonatomic,strong)UIView *Progressview;//假的进度条
@property(nonatomic,strong)UIWebView *webview;
@property(nonatomic)UIBarButtonItem* customBackBarItem;//返回按钮
@property(nonatomic)UIBarButtonItem* closeButtonItem;//关闭按钮

@property(nonatomic,copy)NSString *shareText;//分享页面的内容
@property(nonatomic,copy)NSString *shareUrl;//分享页面的url
@end

@implementation MyWebViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    //按钮白色
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    [self.view addSubview:self.webview];
    [self.view addSubview:self.Progressview];
    [self updateNavigationItems];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.webview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-bottom_height-SafeAreaTopHeight);
    self.Progressview.frame = CGRectMake(0, 0, 0, 2);
}

-(void)activityInfoWithShareType:(shareType)type shareText:(NSString *)text shareUrl:(NSString *)url{
    
    if (type == shareStatusAble) {
        self.shareText = text;
        self.shareUrl = url;
        
        //添加右边分享按钮
        UIBarButtonItem *roadLoad = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(shareClicked)];
        self.navigationItem.rightBarButtonItem = roadLoad;
    }
}

#pragma mark 左侧按钮
-(void)updateNavigationItems{
    if (self.webview.canGoBack)
    {
        UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceButtonItem.width = -6.5;
        [self.navigationItem setLeftBarButtonItems:@[spaceButtonItem,self.customBackBarItem,self.closeButtonItem] animated:NO];
    }
    else
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        [self.navigationItem setLeftBarButtonItems:@[self.customBackBarItem]];
    }
}
#pragma mark 左侧点击事件
-(void)customBackItemClicked{
    
    if (self.webview.canGoBack)
    {
       
        [self.webview goBack];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)closeItemClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 右侧点击
- (void)shareClicked{
    
    [JJShare ShareDescribe:@"如驿如意" images:@[[UIImage imageNamed:@"icon"]] url:self.shareUrl title:self.shareText type:SSDKContentTypeAuto];
}

#pragma mark WebViewDelegate
-(void)webViewDidStartLoad:(UIWebView *)webView{
    
    if (_Progressview.hidden ==YES)
    {
        _Progressview.hidden = NO;
    }
    [UIView animateWithDuration:1 animations:^{
        
        CGRect frame = _Progressview.frame;
        frame.size.width = SCREEN_WIDTH*0.8;
        _Progressview.frame = frame;
    }];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = _Progressview.frame;
        frame.size.width = SCREEN_WIDTH;
        _Progressview.frame = frame;
        [self performSelector:@selector(removeFromSuperView) withObject:nil afterDelay:.5];
    }];
    
//    NSString *allHtml = @"document.documentElement.innerHTML";
    
//    NSString *htmlNum = @"document.getElementById('title').innerText";
    
//    NSString *allHtmlInfo = [webView stringByEvaluatingJavaScriptFromString:allHtml];
    
//    NSLog(@"所有的HTML%@",allHtmlInfo);
//    NSString *numHtmlInfo = [webView stringByEvaluatingJavaScriptFromString:htmlNum];
    
//    NSLog(@"WEb内容%@",numHtmlInfo);
    
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    [self updateNavigationItems];
}


#pragma mark setUI
-(UIBarButtonItem*)customBackBarItem{
    
    if (!_customBackBarItem)
    {
        UIImage* backItemImage = [[UIImage imageNamed:@"返回"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImage* backItemHlImage = [[UIImage imageNamed:@"返回"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIButton* backButton = [[UIButton alloc] init];
//        [backButton setTitle:@"返回" forState:UIControlStateNormal];
//        [backButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [backButton setImage:backItemImage forState:UIControlStateNormal];
        [backButton setImage:backItemHlImage forState:UIControlStateHighlighted];
        [backButton sizeToFit];
        [backButton addTarget:self action:@selector(customBackItemClicked) forControlEvents:UIControlEventTouchUpInside];
        _customBackBarItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    return _customBackBarItem;
}
-(UIBarButtonItem*)closeButtonItem{
    
    if (!_closeButtonItem)
    {
        _closeButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeItemClicked)];
    }
    return _closeButtonItem;
}
-(UIWebView *)webview{

    if (!_webview)
    {
        _webview = [[UIWebView alloc] init];
        _webview.delegate = self;
        _webview.paginationMode = UIWebPaginationModeUnpaginated;
        NSURL *url = [NSURL URLWithString:[self.url UTF8Value]];
        NSURLRequest *urkRequest = [NSURLRequest requestWithURL:url];
        [self.webview loadRequest:urkRequest];
    }
    return _webview;
}

-(UIView *)Progressview{
    
    if (!_Progressview)
    {
        _Progressview = [[UIView alloc] init];
        _Progressview.backgroundColor = [UIColor greenColor];
    }
    return _Progressview;
}
-(void)removeFromSuperView{
    
    //    [_Progressview removeFromSuperview];
    CGRect frame = _Progressview.frame;
    frame.size.width = 0;
    _Progressview.frame = frame;
    [_Progressview setHidden:YES];
}

-(void)dealloc{
    
    NSLog(@"webview释放!");
}
@end

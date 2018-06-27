//
//  MyCodeViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/21.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "MyCodeViewController.h"
#import "MyCodeView.h"

@interface MyCodeViewController ()

@property(nonatomic, strong)UIView *backView;
@property(nonatomic, strong)MyCodeView *mycodeView;

@end

@implementation MyCodeViewController
@synthesize extensionInfo;

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
}

- (UIView *)backView{
    
    if (_backView == nil) {
        
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height - SafeDistance)];
        _backView.backgroundColor = [UIColor blackColor];
    }
    return _backView;
}

- (MyCodeView *)mycodeView{
    
    if (_mycodeView == nil) {
        
        _mycodeView = [[MyCodeView alloc] initWithFrame:CGRectMake(15, 40, MAINSCREEN.width - 30, MAINSCREEN.height - SafeDistance - 40 - 40)];
        _mycodeView.layer.cornerRadius = 4.0;
        _mycodeView.layer.masksToBounds = YES;
        _mycodeView.backgroundColor = [UIColor whiteColor];
    }
    return _mycodeView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的二维码";
    
    [self addViews];
    // Do any additional setup after loading the view.
}

- (void)addViews{
    
    [self.view addSubview:self.backView];
    [self.view addSubview:self.mycodeView];
    [self setdatatoSubviews];
}

- (void)setdatatoSubviews{
    
    [self.mycodeView setdatatoViews:self.extensionInfo];
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

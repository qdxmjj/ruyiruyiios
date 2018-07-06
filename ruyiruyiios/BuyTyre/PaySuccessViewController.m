//
//  PaySuccessViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/13.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "PaySuccessViewController.h"
#import "PaySuccessBackView.h"
#import "FirstUpdateViewController.h"
#import "MyOrderViewController.h"

@interface PaySuccessViewController ()

@property(nonatomic, strong)PaySuccessBackView *paySuccessBackView;
@property(nonatomic, strong)UIButton *toOrderTypeControlBtn;
@property(nonatomic, strong)UIButton *returnHomeControlBtn;

@end

@implementation PaySuccessViewController
@synthesize orderTypeStr;

- (void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

- (PaySuccessBackView *)paySuccessBackView{
    
    if (_paySuccessBackView == nil) {
        
        _paySuccessBackView = [[PaySuccessBackView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height - 164)];
        [_paySuccessBackView setDatatoViews];
    }
    return _paySuccessBackView;
}

- (UIButton *)toOrderTypeControlBtn{
    
    if (_toOrderTypeControlBtn == nil) {
        
        _toOrderTypeControlBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _toOrderTypeControlBtn.frame = CGRectMake(10, MAINSCREEN.height - 80 - 64, MAINSCREEN.width - 20, 34);
        _toOrderTypeControlBtn.layer.cornerRadius = 6.0;
        _toOrderTypeControlBtn.layer.masksToBounds = YES;
        _toOrderTypeControlBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        [_toOrderTypeControlBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [_toOrderTypeControlBtn setTitle:@"我的订单" forState:UIControlStateNormal];
        [_toOrderTypeControlBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_toOrderTypeControlBtn addTarget:self action:@selector(chickOrderTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _toOrderTypeControlBtn;
}

- (void)chickOrderTypeBtn:(UIButton *)button{
    
    MyOrderViewController *myOrderVC = [[MyOrderViewController alloc] init];
    myOrderVC.statusStr = @"0";
    [self.navigationController pushViewController:myOrderVC animated:YES];
//    if ([orderTypeStr isEqualToString:@"0"]) {
//
//        FirstUpdateViewController *firstUpdateVC = [[FirstUpdateViewController alloc] init];
//        [self.navigationController pushViewController:firstUpdateVC animated:YES];
//    }
}

- (UIButton *)returnHomeControlBtn{
    
    if (_returnHomeControlBtn == nil) {
        
        _returnHomeControlBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _returnHomeControlBtn.frame = CGRectMake(10, MAINSCREEN.height - 40 - 64, MAINSCREEN.width - 20, 34);
        _returnHomeControlBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _returnHomeControlBtn.layer.cornerRadius = 6.0;
        _returnHomeControlBtn.layer.masksToBounds = YES;
        _returnHomeControlBtn.layer.borderColor = [LOGINBACKCOLOR CGColor];
        _returnHomeControlBtn.layer.borderWidth = 1.0;
        [_returnHomeControlBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_returnHomeControlBtn setTitleColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [_returnHomeControlBtn setTitle:@"返回首页" forState:UIControlStateNormal];
        [_returnHomeControlBtn addTarget:self action:@selector(chickReturnBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _returnHomeControlBtn;
}

- (void)chickReturnBtn:(UIButton *)button{
    
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"支付成功";
    [self addViews];
    // Do any additional setup after loading the view.
}

- (IBAction)backButtonAction:(id)sender{
    
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)addViews{
    
    [self.view addSubview:self.paySuccessBackView];
    [self.view addSubview:self.toOrderTypeControlBtn];
    [self.view addSubview:self.returnHomeControlBtn];
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

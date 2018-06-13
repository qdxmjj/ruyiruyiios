//
//  BuyPassViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/12.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "BuyPassViewController.h"
#import "BuyPassMiddleView.h"
#import "BuyPassBottomView.h"
#import "UILabel+YBAttributeTextTapAction.h"
#import "UserProtocolViewController.h"

@interface BuyPassViewController ()<UIScrollViewDelegate, YBAttributeTapActionDelegate>

@property(nonatomic, strong)UIScrollView *mainScrollV;
@property(nonatomic, strong)UIImageView *passDetialImageV;
@property(nonatomic, strong)BuyPassMiddleView *buypassMiddleV;
@property(nonatomic, strong)BuyPassBottomView *buypassBottomV;

@end

@implementation BuyPassViewController

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
}

- (UIScrollView *)mainScrollV{
    
    if (_mainScrollV == nil) {
        
        _mainScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height - 64-90)];
        _mainScrollV.showsVerticalScrollIndicator = NO;
        _mainScrollV.showsHorizontalScrollIndicator = NO;
        _mainScrollV.bounces = NO;
        _mainScrollV.delegate = self;
        _mainScrollV.tag = 2;
        _mainScrollV.scrollsToTop = NO;
    }
    return _mainScrollV;
}

- (UIImageView *)passDetialImageV{
    
    if (_passDetialImageV == nil) {
        
        _passDetialImageV = [[UIImageView alloc] init];
        _passDetialImageV.frame = CGRectMake(0, 0, MAINSCREEN.width, 230);
        _passDetialImageV.image = [UIImage imageNamed:@"ic_chang"];
    }
    return _passDetialImageV;
}

- (BuyPassMiddleView *)buypassMiddleV{
    
    if (_buypassMiddleV == nil) {
        
        _buypassMiddleV = [[BuyPassMiddleView alloc] initWithFrame:CGRectMake(0, 231, MAINSCREEN.width, 250)];
    }
    return _buypassMiddleV;
}

- (BuyPassBottomView *)buypassBottomV{
    
    if (_buypassBottomV == nil) {
        
        _buypassBottomV = [[BuyPassBottomView alloc] initWithFrame:CGRectMake(0, MAINSCREEN.height - 64 - 90, MAINSCREEN.width, 90)];
        [_buypassBottomV.sureBuyBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [_buypassBottomV.sureBuyBtn addTarget:self action:@selector(chickSureBuyBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_buypassBottomV.agreementLabel yb_addAttributeTapActionWithStrings:@[@"《如驿如意畅行无忧使用协议》"] delegate:self];
    }
    return _buypassBottomV;
}

- (void)chickSureBuyBtn:(UIButton *)button{
    
    
}

- (void)yb_attributeTapReturnString:(NSString *)string range:(NSRange)range index:(NSInteger)index{
    
    UserProtocolViewController *userProtocolVC = [[UserProtocolViewController alloc] init];
    [self.navigationController pushViewController:userProtocolVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"畅行无忧";
    [self addViews];
    // Do any additional setup after loading the view.
}

- (void)addViews{
    
    [self.view addSubview:self.mainScrollV];
    [self.view addSubview:self.buypassBottomV];
    [_mainScrollV addSubview:self.passDetialImageV];
    [_mainScrollV addSubview:self.buypassMiddleV];
    [_mainScrollV setContentSize:CGSizeMake(MAINSCREEN.width, self.buypassMiddleV.frame.size.height+self.buypassMiddleV.frame.origin.y)];
    [self setdatatoSubviews];
}

- (void)setdatatoSubviews{
    
    [_buypassMiddleV setdatatoViews];
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

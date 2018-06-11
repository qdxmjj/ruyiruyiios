//
//  ToBePaidViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/30.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "ToBePaidViewController.h"
#import "TopayMiddleView.h"
#import "TopayBottomView.h"
#import "CashierViewController.h"
#import "TobepayInfo.h"
#import "ShoeOrderVo.h"

@interface ToBePaidViewController ()<UIScrollViewDelegate>

@property(nonatomic, strong)UIScrollView *mainScrollV;
@property(nonatomic, strong)UIImageView *headImageV;
@property(nonatomic, strong)UIButton *topayBtn;
@property(nonatomic, strong)TopayMiddleView *topayMiddleView;
@property(nonatomic, strong)TopayBottomView *topayBottomView;
@property(nonatomic, strong)ShoeOrderVo *shoeOrdervo;
@property(nonatomic, strong)TobepayInfo *tobepayInfo;

@end

@implementation ToBePaidViewController
@synthesize totalPriceStr;
@synthesize orderNoStr;
@synthesize orderTypeStr;

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
}

- (UIScrollView *)mainScrollV{
    
    if (_mainScrollV == nil) {
        
        _mainScrollV = [[UIScrollView alloc] init];
        _mainScrollV.frame = CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height - 104);
        _mainScrollV.showsVerticalScrollIndicator = NO;
        _mainScrollV.showsHorizontalScrollIndicator = NO;
        _mainScrollV.bounces = NO;
        _mainScrollV.scrollsToTop = NO;
        _mainScrollV.tag = 1;
        _mainScrollV.delegate = self;
    }
    return _mainScrollV;
}

- (UIImageView *)headImageV{
    
    if (_headImageV == nil) {
        
        _headImageV = [[UIImageView alloc] init];
        _headImageV.frame = CGRectMake(0, 0, MAINSCREEN.width, 120);
        _headImageV.image = [UIImage imageNamed:@"ic_banner"];
    }
    return _headImageV;
}

- (UIButton *)topayBtn{
    
    if (_topayBtn == nil) {
        
        _topayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _topayBtn.frame = CGRectMake(10, MAINSCREEN.height - 104, MAINSCREEN.width - 20, 34);
        _topayBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _topayBtn.layer.cornerRadius = 4.0;
        _topayBtn.layer.masksToBounds = YES;
        [_topayBtn setTitle:@"前往支付" forState:UIControlStateNormal];
        [_topayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_topayBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [_topayBtn addTarget:self action:@selector(chickTopayBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _topayBtn;
}

- (TopayMiddleView *)topayMiddleView{
    
    if (_topayMiddleView == nil) {
        
        _topayMiddleView = [[TopayMiddleView alloc] initWithFrame:CGRectMake(0, 120, MAINSCREEN.width, 150)];
    }
    return _topayMiddleView;
}

- (TopayBottomView *)topayBottomView{
    
    if (_topayBottomView == nil) {
        
        _topayBottomView = [[TopayBottomView alloc] initWithFrame:CGRectMake(0, 270, MAINSCREEN.width, 200)];
    }
    return _topayBottomView;
}

- (ShoeOrderVo *)shoeOrdervo{
    
    if (_shoeOrdervo == nil) {
        
        _shoeOrdervo = [[ShoeOrderVo alloc] init];
    }
    return _shoeOrdervo;
}

- (TobepayInfo *)tobepayInfo{
    
    if (_tobepayInfo == nil) {
        
        _tobepayInfo = [[TobepayInfo alloc] init];
    }
    return _tobepayInfo;
}

- (void)chickTopayBtn:(UIButton *)button{
    
    [self.navigationController popViewControllerAnimated:YES];
//    CashierViewController *cashierVC = [[CashierViewController alloc] init];
//    cashierVC.orderNoStr = orderNoStr;
//    cashierVC.totalPriceStr = totalPriceStr;
//    cashierVC.userStatusStr = orderTypeStr;
//    [self.navigationController pushViewController:cashierVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"待支付";
    
    [self.view addSubview:self.mainScrollV];
    [self.view addSubview:self.topayBtn];
    [self addView];
    [self getUserOrderInfoByNoAndType];
    // Do any additional setup after loading the view.
}

- (void)getUserOrderInfoByNoAndType{
    
    NSDictionary *orderInfoPostDic = @{@"orderNo":orderNoStr, @"orderType":orderTypeStr, @"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]]};
    NSString *reqJson = [PublicClass convertToJsonData:orderInfoPostDic];
    [JJRequest postRequest:@"getUserOrderInfoByNoAndType" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
            NSLog(@"%@", data);
            [self analysizeData:data];
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"查询用户订单详情错误：%@", error);
    }];
}

- (void)analysizeData:(NSDictionary *)dataDic{
    
    [self.tobepayInfo setValuesForKeysWithDictionary:dataDic];
    [self.shoeOrdervo setValuesForKeysWithDictionary:[[dataDic objectForKey:@"shoeOrderVoList"] objectAtIndex:0]];
    [self setdataToViews];
}

- (IBAction)backButtonAction:(id)sender{
    
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)addView{
    
    [_mainScrollV addSubview:self.headImageV];
    [_mainScrollV addSubview:self.topayMiddleView];
    [_mainScrollV addSubview:self.topayBottomView];
    [_mainScrollV setContentSize:CGSizeMake(MAINSCREEN.width, (self.topayBottomView.frame.size.height + self.topayBottomView.frame.origin.y))];
}

- (void)setdataToViews{
    
    [_topayMiddleView setPayMiddleViewData:self.tobepayInfo];
    [_topayBottomView setTopayBottomViewData:self.shoeOrdervo tobePayinfo:self.tobepayInfo];
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

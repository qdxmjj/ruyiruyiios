//
//  AllOrderDetialViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/28.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "AllOrderDetialViewController.h"

@interface AllOrderDetialViewController ()<UIScrollViewDelegate>

@property(nonatomic, strong)UIScrollView *mainScrollV;
@property(nonatomic, strong)UIButton *submitBtn;

@end

@implementation AllOrderDetialViewController
@synthesize titleStr;
@synthesize orderTypeStr;
@synthesize orderNoStr;

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
}

- (UIScrollView *)mainScrollV{
    
    if (_mainScrollV == nil) {
        
        _mainScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height - SafeDistance - 40)];
        _mainScrollV.backgroundColor = [UIColor redColor];
        _mainScrollV.bounces = NO;
        _mainScrollV.showsVerticalScrollIndicator = NO;
        _mainScrollV.showsHorizontalScrollIndicator = NO;
        _mainScrollV.delegate = self;
        _mainScrollV.scrollsToTop = NO;
        _mainScrollV.tag = 2;
    }
    return _mainScrollV;
}

- (UIButton *)submitBtn{
    
    if (_submitBtn == nil) {
        
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.frame = CGRectMake(10, MAINSCREEN.height - SafeDistance - 40, MAINSCREEN.width - 20, 34);
        _submitBtn.layer.cornerRadius = 6.0;
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.userInteractionEnabled = NO;
        [_submitBtn setTitle:titleStr forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn setBackgroundColor:[PublicClass colorWithHexString:@"#ececec"] forState:UIControlStateNormal];
    }
    return _submitBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = titleStr;
    [self addViews];
    [self getUserOrderInfoByNoAndType];
    // Do any additional setup after loading the view.
}

- (void)addViews{
    
    [self.view addSubview:self.mainScrollV];
    [self.view addSubview:self.submitBtn];
}

- (void)getUserOrderInfoByNoAndType{
    
    NSDictionary *postDic = @{@"orderNo":orderNoStr, @"orderType":orderTypeStr, @"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]]};
    NSString *reqJson = [PublicClass convertToJsonData:postDic];
    [JJRequest postRequest:@"getUserOrderInfoByNoAndType" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
            YLog(@"%@", data);
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"所有订单详情中查询用户订单详情错误:%@", error);
    }];
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

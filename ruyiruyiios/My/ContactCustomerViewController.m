//
//  ContactCustomerViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/19.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "ContactCustomerViewController.h"

@interface ContactCustomerViewController ()

@property(nonatomic, strong)UIButton *backBtn;
@property(nonatomic, strong)UIButton *callPhoneBtn;

@end

@implementation ContactCustomerViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (UIButton *)backBtn{
    
    if (_backBtn == nil) {
        
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.frame = CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height - SafeDistance);
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"ic_m_kefu"] forState:UIControlStateNormal];
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"ic_m_kefu"] forState:UIControlStateHighlighted];
//        [_backBtn setImage:[UIImage imageNamed:@"ic_m_kefu"] forState:UIControlStateNormal];
//        [_backBtn setImage:[UIImage imageNamed:@"ic_m_kefu"] forState:UIControlStateHighlighted];
        [_backBtn addTarget:self action:@selector(chickBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;;
}

- (void)chickBackBtn:(UIButton *)button{
    
    [UIView animateWithDuration:1.0 animations:^{
        
        self.callPhoneBtn.frame = CGRectMake(MAINSCREEN.width - 80, MAINSCREEN.height - SafeDistance - 60, 80, 40);
        [self.callPhoneBtn setImage:[UIImage imageNamed:@"ic_m_first"] forState:UIControlStateNormal];
    }];
}

- (UIButton *)callPhoneBtn{
    
    if (_callPhoneBtn == nil) {
        
        _callPhoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _callPhoneBtn.frame = CGRectMake(MAINSCREEN.width - 80, MAINSCREEN.height - SafeDistance - 60, 80, 40);
        [_callPhoneBtn setImage:[UIImage imageNamed:@"ic_m_first"] forState:UIControlStateNormal];
        [_callPhoneBtn addTarget:self action:@selector(chickCallPhoneBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _callPhoneBtn;
}

- (void)chickCallPhoneBtn:(UIButton *)button{
    
    if (button.frame.size.width == 162) {
        
        NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@", @"4008080136"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }else{
        
        [UIView animateWithDuration:1.0 animations:^{
            
            button.frame = CGRectMake(MAINSCREEN.width - 162, MAINSCREEN.height - SafeDistance - 60, 162, 40);
            [button setImage:[UIImage imageNamed:@"ic_m_two"] forState:UIControlStateNormal];
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"联系客服";
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.callPhoneBtn];
    // Do any additional setup after loading the view.
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

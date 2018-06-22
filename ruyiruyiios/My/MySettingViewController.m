//
//  MySettingViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/19.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "MySettingViewController.h"
#import "MySettingTableViewCell.h"
#import "UpdatePasswordViewController.h"
#import "ContactCustomerViewController.h"
#import "AboutUsViewController.h"

@interface MySettingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *settingTableV;
@property(nonatomic, strong)UIButton *signOutBtn;

@end

@implementation MySettingViewController

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
}

- (UITableView *)settingTableV{
    
    if (_settingTableV == nil) {
        
        _settingTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height - 104) style:UITableViewStylePlain];
        _settingTableV.delegate = self;
        _settingTableV.dataSource = self;
        _settingTableV.bounces = NO;
        _settingTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _settingTableV;
}

- (UIButton *)signOutBtn{
    
    if (_signOutBtn == nil) {
        
        _signOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _signOutBtn.frame = CGRectMake(10, MAINSCREEN.height - 64 - 40, MAINSCREEN.width - 20, 34);
        _signOutBtn.layer.cornerRadius = 6.0;
        _signOutBtn.layer.masksToBounds = YES;
        _signOutBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        [_signOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [_signOutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_signOutBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [_signOutBtn addTarget:self action:@selector(chickSignOutBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _signOutBtn;
}

- (void)chickSignOutBtn:(UIButton *)button{
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self.view addSubview:self.settingTableV];
    [self.view addSubview:self.signOutBtn];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 55.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIndentifier = @"cell";
    MySettingTableViewCell *mysettingCell = [tableView dequeueReusableCellWithIdentifier:reuseIndentifier];
    if (mysettingCell == nil) {
        
        mysettingCell = [[MySettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIndentifier];
        mysettingCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [mysettingCell setDatatoViews:indexPath.row];
    return mysettingCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        UpdatePasswordViewController *updateVC = [[UpdatePasswordViewController alloc] init];
        [self.navigationController pushViewController:updateVC animated:YES];
    }else if (indexPath.row == 1){
        
        ContactCustomerViewController *contactVC = [[ContactCustomerViewController alloc] init];
        [self.navigationController pushViewController:contactVC animated:YES];
    }else{
        
        AboutUsViewController *aboutVC = [[AboutUsViewController alloc] init];
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
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

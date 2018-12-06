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
#import "CodeLoginViewController.h"

@interface MySettingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *settingTableV;
@property(nonatomic, strong)UIButton *signOutBtn;

@end

@implementation MySettingViewController


- (UITableView *)settingTableV{
    
    if (_settingTableV == nil) {
        
        _settingTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height - SafeDistance - 40) style:UITableViewStylePlain];
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
        _signOutBtn.frame = CGRectMake(10, MAINSCREEN.height - SafeDistance - 40, MAINSCREEN.width - 20, 34);
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
    
    [self setdataEmptying];
    CodeLoginViewController *codeLoginVC = [[CodeLoginViewController alloc] init];
    codeLoginVC.homeTologinStr = @"2";
    [self.navigationController pushViewController:codeLoginVC animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}

- (void)setdataEmptying{
    
    [UserConfig userDefaultsSetObject:@"" key:@"age"];
    [UserConfig userDefaultsSetObject:@"" key:@"birthday"];
    [UserConfig userDefaultsSetObject:@"" key:@"createTime"];
    [UserConfig userDefaultsSetObject:@"" key:@"createdBy"];
    [UserConfig userDefaultsSetObject:@"" key:@"createdTime"];
    [UserConfig userDefaultsSetObject:@"" key:@"deletedBy"];
    [UserConfig userDefaultsSetObject:@"" key:@"deletedFlag"];
    [UserConfig userDefaultsSetObject:@"" key:@"deletedTime"];
    [UserConfig userDefaultsSetObject:@"" key:@"email"];
    [UserConfig userDefaultsSetObject:@"" key:@"firstAddCar"];
    [UserConfig userDefaultsSetObject:@"" key:@"gender"];
    [UserConfig userDefaultsSetObject:@"" key:@"headimgurl"];
    [UserConfig userDefaultsSetObject:@"" key:@"user_id"];
    [UserConfig userDefaultsSetObject:@"" key:@"invitationCode"];
    [UserConfig userDefaultsSetObject:@"" key:@"lastUpdatedBy"];
    [UserConfig userDefaultsSetObject:@"" key:@"lastUpdatedTime"];
    [UserConfig userDefaultsSetObject:@"" key:@"ml"];
    [UserConfig userDefaultsSetObject:@"" key:@"nick"];
    [UserConfig userDefaultsSetObject:@"" key:@"password"];
    [UserConfig userDefaultsSetObject:@"" key:@"payPwd"];
    [UserConfig userDefaultsSetObject:@"" key:@"phone"];
    [UserConfig userDefaultsSetObject:@"" key:@"qqInfoId"];
    [UserConfig userDefaultsSetObject:@"" key:@"remark"];
    [UserConfig userDefaultsSetObject:@"" key:@"status"];
    [UserConfig userDefaultsSetObject:@"" key:@"token"];
    [UserConfig userDefaultsSetObject:@"" key:@"updateTime"];
    [UserConfig userDefaultsSetObject:@"" key:@"version"];
    [UserConfig userDefaultsSetObject:@"" key:@"wxInfoId"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self.view addSubview:self.settingTableV];
    [self.view addSubview:self.signOutBtn];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
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
        self.hidesBottomBarWhenPushed = YES;
    }else{
        
        AboutUsViewController *aboutVC = [[AboutUsViewController alloc] init];
        [self.navigationController pushViewController:aboutVC animated:YES];
        self.hidesBottomBarWhenPushed = YES;
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

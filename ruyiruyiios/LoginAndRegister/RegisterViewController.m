//
//  RegisterViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/9.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterTableViewCell.h"
#import "PasswordTableViewCell.h"
//#import "DateTableViewCell.h"
//#import "SexTableViewCell.h"
#import "WXZPickDateView.h"
#import "WXZCustomPickView.h"
#import "MainTabBarViewController.h"
#import "DBRecorder.h"
#import "DelegateConfiguration.h"

@interface RegisterViewController ()<UITableViewDelegate, UITableViewDataSource, PickerDateViewDelegate, CustomPickViewDelegate>{
    
    NSInteger x;
    CGFloat nameW;
    CGFloat top;
    BOOL isShowDay;
}

@property(nonatomic, strong)UITableView *registerTabV;
@property(nonatomic, strong)UIButton *saveBtn;
@property(nonatomic, strong)UIView *dateView;
@property(nonatomic, strong)UILabel *dateLabel;
@property(nonatomic, strong)UIButton *dateBtn;
@property(nonatomic, strong)UIImageView *jianTouimgV;
@property(nonatomic, strong)UIView *sexView;
@property(nonatomic, strong)UILabel *sexLabel;
@property(nonatomic, strong)UIButton *sexBtn;
@property(nonatomic, strong)UIImageView *sexjianTouimgV;
@property(nonatomic, strong)NSString *resetPStr, *surePStr, *nickStr, *emailStr, *sexNumberStr;

@end

@implementation RegisterViewController
@synthesize teleStr;

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (UITableView *)registerTabV{
    
    if (_registerTabV == nil) {
        
        _registerTabV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, 306) style:UITableViewStylePlain];
        _registerTabV.tableHeaderView = nil;
        _registerTabV.tableFooterView = nil;
        _registerTabV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _registerTabV.bounces = NO;
        _registerTabV.backgroundColor = [UIColor whiteColor];
        _registerTabV.showsVerticalScrollIndicator = YES;
        _registerTabV.dataSource = self;
        _registerTabV.delegate = self;
    }
    return _registerTabV;
}

- (UIView *)dateView{
    
    if (_dateView == nil) {
        
        _dateView = [[UIView alloc] initWithFrame:CGRectMake(0, 307, MAINSCREEN.width, 61)];
        UIView *dateunderView = [[UIView alloc] initWithFrame:CGRectMake(20, 49, MAINSCREEN.width - 20, 0.5)];
        dateunderView.backgroundColor = [UIColor lightGrayColor];
        [_dateView addSubview:self.dateLabel];
        [_dateView addSubview:self.dateBtn];
        [_dateView addSubview:self.jianTouimgV];
        [_dateView addSubview:dateunderView];
    }
    return _dateView;
}

- (UILabel *)dateLabel{
    
    if (_dateLabel == nil) {
        
        CGFloat x = 20;
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.text = @"出生年月";
        _dateLabel.textColor = [UIColor blackColor];
        CGSize size = [PublicClass getLabelSize:_dateLabel fontsize:18.0];
        nameW = size.width;
        _dateLabel.frame = CGRectMake(x,top, nameW, 20);
    }
    return _dateLabel;
}

- (UIButton *)dateBtn{
    
    if (_dateBtn == nil) {
        
        _dateBtn = [[UIButton alloc] initWithFrame:CGRectMake(nameW + x, top, (MAINSCREEN.width - (nameW + x + 50)), 20)];
        _dateBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_dateBtn setTitle:@"2018-05-10" forState:UIControlStateNormal];
        [_dateBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_dateBtn addTarget:self action:@selector(chickDateBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dateBtn;
}

- (UIImageView *)jianTouimgV{
    
    if (_jianTouimgV == nil) {
        
        _jianTouimgV = [[UIImageView alloc] initWithFrame:CGRectMake(MAINSCREEN.width-38, top+3, 10, 15)];
        _jianTouimgV.image = [UIImage imageNamed:@"箭头"];
    }
    return _jianTouimgV;
}

- (UIView *)sexView{
    
    if (_sexView == nil) {
        
        _sexView = [[UIView alloc] initWithFrame:CGRectMake(0, 368, MAINSCREEN.width, 61)];
        UIView *sexunderView2 = [[UIView alloc] initWithFrame:CGRectMake(20, 49, MAINSCREEN.width - 20, 0.5)];
        sexunderView2.backgroundColor = [UIColor lightGrayColor];
        [_sexView addSubview:self.sexLabel];
        [_sexView addSubview:self.sexBtn];
        [_sexView addSubview:self.sexjianTouimgV];
        [_sexView addSubview:sexunderView2];
    }
    return _sexView;
}

- (UILabel *)sexLabel{
    
    if (_sexLabel == nil) {
        
        CGFloat x = 20;
        _sexLabel = [[UILabel alloc] init];
        _sexLabel.text = @"性别";
        _sexLabel.textColor = [UIColor blackColor];
        CGSize size = [PublicClass getLabelSize:_sexLabel fontsize:18.0];
        nameW = size.width;
        _sexLabel.frame = CGRectMake(x,top, nameW, 20);
    }
    return _sexLabel;
}

- (UIButton *)sexBtn{
    
    if (_sexBtn == nil) {
        
        _sexBtn = [[UIButton alloc] initWithFrame:CGRectMake(nameW + x, top, (MAINSCREEN.width - (nameW + x + 50)), 20)];
        _sexBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_sexBtn setTitle:@"女" forState:UIControlStateNormal];
        [_sexBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_sexBtn addTarget:self action:@selector(chickSexBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sexBtn;
}

- (UIImageView *)sexjianTouimgV{
    
    if (_sexjianTouimgV == nil) {
        
        _sexjianTouimgV = [[UIImageView alloc] initWithFrame:CGRectMake(MAINSCREEN.width-38, top+3, 10, 15)];
        _sexjianTouimgV.image = [UIImage imageNamed:@"箭头"];
    }
    return _sexjianTouimgV;
}

- (void)chickDateBtn{
    
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"joinStatusStr"];
    isShowDay=YES;
    WXZPickDateView *pickerDate = [[WXZPickDateView alloc]init];
//    pickerDate.joinStatusStr = @"0";
    [pickerDate setIsAddYetSelect:NO];//是否显示至今选项
    [pickerDate setIsShowDay:isShowDay];//是否显示日信息
    [pickerDate setDefaultTSelectYear:2018 defaultSelectMonth:5 defaultSelectDay:10];//设定默认显示的日期
    [pickerDate setDelegate:self];
    [pickerDate show];
}

- (void)chickSexBtn{
    
    NSMutableArray *arrayData = [NSMutableArray arrayWithObjects:@"男", @"女", nil];
    
    WXZCustomPickView *pickerSingle = [[WXZCustomPickView alloc]init];
    
    [pickerSingle setDataArray:arrayData];
    [pickerSingle setDefalutSelectRowStr:arrayData[0]];
    
    
    [pickerSingle setDelegate:self];
    
    [pickerSingle show];
    [self.view endEditing:YES];
}

- (UIButton *)saveBtn{
    
    if (_saveBtn == nil) {
        
        _saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, MAINSCREEN.height - 50 - SafeDistance, MAINSCREEN.width - 30, 40)];
        _saveBtn.layer.cornerRadius = 8.0;
        _saveBtn.layer.masksToBounds = YES;
        _saveBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:20.0];
        [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(chickSaveBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}

- (void)chickSaveBtn{
    
    [_registerTabV reloadData];
    if (_resetPStr.length == 0 || _surePStr == 0 || _nickStr == 0) {
        
        [PublicClass showHUD:@"输入不能为空" view:self.view];
    }else if (![_resetPStr isEqualToString:_surePStr]){
        
        [PublicClass showHUD:@"二次输入的密码不一致" view:self.view];
    }else{
        
        if ([_sexBtn.titleLabel.text isEqualToString:@"男"]) {
            
            _sexNumberStr = @"1";
        }else{
            
            _sexNumberStr = @"2";
        }
        _resetPStr = [[PublicClass md5:_resetPStr] uppercaseString];
        _surePStr = [[PublicClass md5:_surePStr] uppercaseString];
        NSLog(@"加密之后的字符串:%@", _resetPStr);
        if (_emailStr.length != 0) {
            
            if (![PublicClass validateEmail:_emailStr]){
                
                [PublicClass showHUD:@"请输入正确的邮箱" view:self.view];
                return;
            }
        }
        NSDictionary *registerPostDic = @{@"age":@"0",@"birthday": _dateBtn.titleLabel.text,@"email": _emailStr,@"gender":_sexNumberStr,@"nick":_nickStr,@"password":_resetPStr,@"phone":teleStr};
        NSString *regsterReqJson = [PublicClass convertToJsonData:registerPostDic];
        [JJRequest postRequest:@"registerUser" params:@{@"reqJson":regsterReqJson} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
            
            NSString *statusStr = [NSString stringWithFormat:@"%@", code];
            NSString *messStr = [NSString stringWithFormat:@"%@", message];
            if ([statusStr isEqualToString:@"-1"]) {
                
                [PublicClass showHUD:messStr view:self.view];
            }else{
                
                NSLog(@"注册成功返回的数据:%@", data);
                //保存数据库操作
                [self insertDatabase:data];
                [self removeDelegates];
                MainTabBarViewController *mainTabVC = [[MainTabBarViewController alloc] init];
                [self.navigationController pushViewController:mainTabVC animated:YES];
            }
        } failure:^(NSError * _Nullable error) {
            
            NSLog(@"请求错误:%@", error);
        }];
    }
    NSLog(@"手机号码:%@, 设置密码%@, 确认密码:%@, 昵称:%@, 邮箱:%@, 出生年月:%@, 性别:%@", teleStr, _resetPStr, _surePStr, _nickStr, _emailStr, _dateBtn.titleLabel.text, _sexBtn.titleLabel.text);
}

- (void)insertDatabase:(NSDictionary *)dataDic{
    
    FMDBUserInfo *userInfo = [[FMDBUserInfo alloc] init];
    [userInfo setValuesForKeysWithDictionary:dataDic];
    [UserConfig userDefaultsSetObject:userInfo.age key:@"age"];
    [UserConfig userDefaultsSetObject:userInfo.birthday key:@"birthday"];
    [UserConfig userDefaultsSetObject:userInfo.createTime key:@"createTime"];
    [UserConfig userDefaultsSetObject:userInfo.createdBy key:@"createdBy"];
    [UserConfig userDefaultsSetObject:userInfo.createdTime key:@"createdTime"];
    [UserConfig userDefaultsSetObject:userInfo.deletedBy key:@"deletedBy"];
    [UserConfig userDefaultsSetObject:userInfo.deletedFlag key:@"deletedFlag"];
    [UserConfig userDefaultsSetObject:userInfo.deletedTime key:@"deletedTime"];
    [UserConfig userDefaultsSetObject:userInfo.email key:@"email"];
    [UserConfig userDefaultsSetObject:userInfo.firstAddCar key:@"firstAddCar"];
    [UserConfig userDefaultsSetObject:userInfo.gender key:@"gender"];
    [UserConfig userDefaultsSetObject:userInfo.headimgurl key:@"headimgurl"];
    [UserConfig userDefaultsSetObject:userInfo.user_id key:@"user_id"];
    [UserConfig userDefaultsSetObject:userInfo.invitationCode key:@"invitationCode"];
    [UserConfig userDefaultsSetObject:userInfo.lastUpdatedBy key:@"lastUpdatedBy"];
    [UserConfig userDefaultsSetObject:userInfo.lastUpdatedTime key:@"lastUpdatedTime"];
    [UserConfig userDefaultsSetObject:userInfo.ml key:@"ml"];
    [UserConfig userDefaultsSetObject:userInfo.nick key:@"nick"];
    [UserConfig userDefaultsSetObject:userInfo.password key:@"password"];
    [UserConfig userDefaultsSetObject:userInfo.payPwd key:@"payPwd"];
    [UserConfig userDefaultsSetObject:userInfo.phone key:@"phone"];
    [UserConfig userDefaultsSetObject:userInfo.qqInfoId key:@"qqInfoId"];
    [UserConfig userDefaultsSetObject:userInfo.remark key:@"remark"];
    [UserConfig userDefaultsSetObject:userInfo.status key:@"status"];
    [UserConfig userDefaultsSetObject:userInfo.token key:@"token"];
    [UserConfig userDefaultsSetObject:userInfo.updateTime key:@"updateTime"];
    [UserConfig userDefaultsSetObject:userInfo.version key:@"version"];
    [UserConfig userDefaultsSetObject:userInfo.wxInfoId key:@"wxInfoId"];
}

- (void)removeDelegates{
    
    DelegateConfiguration *delegateConfiguration = [DelegateConfiguration sharedConfiguration];
    [delegateConfiguration removeAllDelegateMutableA];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _emailStr = @"";
    top = 13.0;
    self.title = @"完善个人资料";
    [self.view addSubview:self.registerTabV];
    [self.view addSubview:self.dateView];
    [self.view addSubview:self.sexView];
    [self.view addSubview:self.saveBtn];
    // Do any additional setup after loading the view.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 61.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIndentifier = @"cell";
    __weak typeof(self) weakSelf = self;
    if (indexPath.row == 0 || indexPath.row == 3 || indexPath.row == 4) {

        RegisterTableViewCell *registerCell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (registerCell == nil) {
            
            registerCell = [[RegisterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            registerCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSArray *firstnameArray = @[@"手机号", @"昵称", @"邮箱"];
        if (indexPath.row == 0) {
            
            registerCell.leftLabel.text = firstnameArray[indexPath.row];
            registerCell.rightTF.text = teleStr;
            registerCell.rightTF.enabled = NO;
        }else{
            
            registerCell.leftLabel.text = firstnameArray[indexPath.row - 2];
            if (indexPath.row == 4) {
                
                registerCell.rightTF.keyboardType = UIKeyboardTypeEmailAddress;
            }
            registerCell.block = ^(NSString *text) {
                
                if (indexPath.row == 4) {
                    
                    weakSelf.emailStr = text;
                }else{
                    
                    weakSelf.nickStr = text;
                }
            };
        }
        return registerCell;
        
    }else if (indexPath.row == 1 || indexPath.row == 2){

        PasswordTableViewCell *passCell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (passCell == nil) {

            passCell = [[PasswordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            passCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSArray *secondArray = @[@"设置密码", @"确认密码"];
        passCell.leftLabel.text = secondArray[indexPath.row - 1];
        passCell.block = ^(NSString *text) {
            
            if (indexPath.row == 1) {
                
                weakSelf.resetPStr = text;
            }else{
                
                weakSelf.surePStr = text;
            }
        };
        return passCell;
    }else{

        return nil;
    }
}

-(void)pickerDateView:(WXZBasePickView *)pickerDateView selectYear:(NSInteger)year selectMonth:(NSInteger)month selectDay:(NSInteger)day{
    
    NSString *dateStr = [PublicClass returnDateStrselectYear:year selectMonth:month selectDay:day];
    [_dateBtn setTitle:dateStr forState:UIControlStateNormal];
}

-(void)customPickView:(WXZCustomPickView *)customPickView selectedTitle:(NSString *)selectedTitle{
    NSLog(@"选择%@",selectedTitle);
    [_sexBtn setTitle:selectedTitle forState:UIControlStateNormal];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

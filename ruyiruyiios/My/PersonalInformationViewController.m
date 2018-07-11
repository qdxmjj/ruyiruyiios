//
//  PersonalInformationViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/14.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "PersonalInformationViewController.h"
#import "PersonHeadImgTableViewCell.h"
#import "PersonOtherTableViewCell.h"
#import "WXZPickDateView.h"
#import "WXZCustomPickView.h"
#import "ZZYPhotoHelper.h"
#import "PersonAlertEmailView.h"

@interface PersonalInformationViewController ()<UITableViewDelegate, UITableViewDataSource, PickerDateViewDelegate, CustomPickViewDelegate>{
    
    NSString *genderStr;
}

@property(nonatomic, strong)UITableView *personTableV;
@property(nonatomic, strong)UIButton *inforSaveBtn;
@property(nonatomic, strong)NSArray *titleArray;
@property(nonatomic, strong)NSArray *dataArray;
@property(nonatomic, strong)NSMutableArray *sexArray;
@property(nonatomic, strong)UIView *backView;
@property(nonatomic, strong)PersonAlertEmailView *personAlertView;

@end

@implementation PersonalInformationViewController

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
}

- (UITableView *)personTableV{
    
    if (_personTableV == nil) {
        
        _personTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height - 40 - SafeDistance) style:UITableViewStylePlain];
        _personTableV.delegate = self;
        _personTableV.dataSource = self;
        _personTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _personTableV.bounces = NO;
    }
    return _personTableV;
}

- (UIView *)backView{
    
    if (_backView == nil) {
        
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height)];
        _backView.backgroundColor = [UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:0.2];
        _backView.hidden = YES;
    }
    return _backView;
}

- (PersonAlertEmailView *)personAlertView{
    
    if (_personAlertView == nil) {
        
        _personAlertView = [[PersonAlertEmailView alloc] initWithFrame:CGRectMake(20, MAINSCREEN.height/2 - 60-64, MAINSCREEN.width - 40, 120)];
        _personAlertView.layer.cornerRadius = 6.0;
        _personAlertView.layer.masksToBounds = YES;
        _personAlertView.backgroundColor = [UIColor whiteColor];
        [_personAlertView.sureBtn addTarget:self action:@selector(chickSureBtn) forControlEvents:UIControlEventTouchUpInside];
        [_personAlertView.cancelBtn addTarget:self action:@selector(chickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _personAlertView;
}

- (void)chickSureBtn{
    
    if (![PublicClass validateEmail:self.personAlertView.emailTF.text]) {
        
        [PublicClass showHUD:@"请输入正确的邮箱格式" view:self.view];
    }else{
        
        self.block(self.personAlertView.emailTF.text);
        self.backView.hidden = YES;
    }
}

- (void)chickCancelBtn{
    
    self.backView.hidden = YES;
}

- (UIButton *)inforSaveBtn{
    
    if (_inforSaveBtn == nil) {
        
        _inforSaveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _inforSaveBtn.frame = CGRectMake(10, MAINSCREEN.height - SafeDistance - 40, MAINSCREEN.width - 20, 34);
        _inforSaveBtn.layer.cornerRadius = 6.0;
        _inforSaveBtn.layer.masksToBounds = YES;
        _inforSaveBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        [_inforSaveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_inforSaveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_inforSaveBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [_inforSaveBtn addTarget:self action:@selector(chickInforSaveBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _inforSaveBtn;
}

- (void)chickInforSaveBtn:(UIButton *)button{
    
    PersonHeadImgTableViewCell *headimgCell = [_personTableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    PersonOtherTableViewCell *nickCell = [_personTableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    PersonOtherTableViewCell *sexCell = [_personTableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    PersonOtherTableViewCell *emailCell = [_personTableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    PersonOtherTableViewCell *dateCell = [_personTableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    if ([sexCell.dataLabel.text isEqualToString:@"男"]) {
        
        genderStr = @"1";
    }else{
        
        genderStr = @"2";
    }
    float imgCompressionQuality = 0.3;
    NSData *headData = UIImageJPEGRepresentation(headimgCell.headImgV.image, imgCompressionQuality);
    NSArray <JJFileParam *> *fileArray = @[[JJFileParam fileConfigWithfileData:headData name:@"user_head_img" fileName:@"user_head_img.png" mimeType:@"image/jpg/png/jpeg"]];
    NSDictionary *postDic = @{@"age":@"0", @"birthday":dateCell.dataLabel.text, @"email":emailCell.dataLabel.text, @"gender":genderStr, @"nick":nickCell.nameTF.text, @"headimgurl":[UserConfig headimgurl], @"password":@"", @"phone":[UserConfig phone], @"remark":@"", @"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]]};
    NSString *reqJson = [PublicClass convertToJsonData:postDic];
    [JJRequest updateRequest:@"updateUser" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} fileConfig:fileArray progress:^(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        
    } success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
//            NSLog(@"%@", data);
            [UserConfig userDefaultsSetObject:[data objectForKey:@"headimgurl"] key:@"headimgurl"];
            [UserConfig userDefaultsSetObject:[data objectForKey:@"nick"] key:@"nick"];
            [UserConfig userDefaultsSetObject:[NSNumber numberWithInt:[[data objectForKey:@"gender"] intValue]] key:@"gender"];
            [UserConfig userDefaultsSetObject:[data objectForKey:@"email"] key:@"email"];
            [UserConfig userDefaultsSetObject:[NSString stringWithFormat:@"%@", [data objectForKey:@"birthday"]] key:@"birthday"];
            self.updateViewBlock(@"update");
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } complete:^(id  _Nullable dataObj, NSError * _Nullable error) {
        
        NSLog(@"修改用户信息接口错误:%@", error);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人信息";
    NSString *currentdateStr = [PublicClass timestampSwitchTime:[[UserConfig birthday] integerValue] andFormatter:@"YYYY-MM-dd"];
    self.titleArray = @[@"昵称", @"性别", @"邮箱", @"出生年月"];
    self.dataArray = @[[UserConfig nick], [NSString stringWithFormat:@"%@", [UserConfig gender]], [UserConfig email], currentdateStr];
    self.sexArray = [[NSMutableArray alloc] initWithObjects:@"男", @"女", nil];
    [self addViews];
    // Do any additional setup after loading the view.
}

- (void)addViews{
    
    [self.view addSubview:self.personTableV];
    [self.view addSubview:self.inforSaveBtn];
    [self.view addSubview:self.backView];
    [_backView addSubview:self.personAlertView];
}

//UITableViewDelegate and UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.titleArray count] + 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        return 80.0;
    }
    return 50.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        static NSString *imgIndentifier = @"imgCell";
        PersonHeadImgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:imgIndentifier];
        if (cell == nil) {
            
            cell = [[PersonHeadImgTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:imgIndentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setDatatoCellViews];
        return cell;
    }else{
        
        static NSString *otherIndentifier = @"otherCell";
        PersonOtherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:otherIndentifier];
        if (cell == nil) {
            
            if (indexPath.row == 1) {
                
                cell = [[PersonOtherTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:otherIndentifier flag:@"0" email:@"0"];
            }else if (indexPath.row == 3){
                
                cell = [[PersonOtherTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:otherIndentifier flag:@"1" email:@"1"];
            }else{
                
                cell = [[PersonOtherTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:otherIndentifier flag:@"1" email:@"0"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setdatatoCellViewstitleStr:[self.titleArray objectAtIndex:(indexPath.row - 1)] data:[self.dataArray objectAtIndex:(indexPath.row - 1)]];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        
        PersonHeadImgTableViewCell *imgCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [[ZZYPhotoHelper shareHelper] showImageViewSelcteWithResultBlock:^(id data) {
            
            [imgCell.headImgV setImage:(UIImage *)data];
        }];
    }else{
        
        PersonOtherTableViewCell *otherCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
        __weak typeof(self) weakSelf = self;
        if (indexPath.row == 1){
            
        }else if (indexPath.row == 2){
            
            WXZCustomPickView *pickerSingle = [[WXZCustomPickView alloc] init];
            [pickerSingle setDataArray:self.sexArray];
            [pickerSingle setDefalutSelectRowStr:self.dataArray[0]];
            [pickerSingle setDelegate:self];
            [pickerSingle show];
            [self.view endEditing:YES];
            self.block = ^(NSString *sexStr) {
                
                [otherCell setdatatoCellViewstitleStr:weakSelf.titleArray[indexPath.row - 1] data:sexStr];
            };
        }else if (indexPath.row == 3){
            
            self.backView.hidden = NO;
            self.block = ^(NSString *emailStr) {
                
                [otherCell setdatatoCellViewstitleStr:weakSelf.titleArray[indexPath.row - 1] data:emailStr];
            };
        }else if (indexPath.row == 4){
            
            [self chickDateBtnotherCell:otherCell index:indexPath.row];
        }
    }
}

- (void)chickDateBtnotherCell:(PersonOtherTableViewCell *)cell index:(NSInteger)index{
    
    NSString *dataStr = self.dataArray[(index - 1)];
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"joinStatusStr"];
    WXZPickDateView *pickerDate = [[WXZPickDateView alloc] init];
    [pickerDate setIsAddYetSelect:NO];
    [pickerDate setIsShowDay:YES];
    [pickerDate setDefaultTSelectYear:[[dataStr substringWithRange:NSMakeRange(0, 4)] integerValue] defaultSelectMonth:[[dataStr substringWithRange:NSMakeRange(5, 2)] integerValue] defaultSelectDay:[[dataStr substringWithRange:NSMakeRange(8, 2)] integerValue]];
    [pickerDate setDelegate:self];
    [pickerDate show];
    [self.view endEditing:YES];
    __weak typeof(self) weakSelf = self;
    self.block = ^(NSString *dateStr) {
        
        [cell setdatatoCellViewstitleStr:weakSelf.titleArray[(index - 1)] data:dateStr];
    };
}

//DateDelegate
- (void)pickerDateView:(WXZBasePickView *)pickerDateView selectYear:(NSInteger)year selectMonth:(NSInteger)month selectDay:(NSInteger)day{
    
    NSString *selectDateStr = [PublicClass returnDateStrselectYear:year selectMonth:month selectDay:day];
    self.block(selectDateStr);
}

//SexDelegate
- (void)customPickView:(WXZCustomPickView *)customPickView selectedTitle:(NSString *)selectedTitle{
    
    self.block(selectedTitle);
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

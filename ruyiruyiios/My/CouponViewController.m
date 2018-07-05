//
//  CouponViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/20.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "CouponViewController.h"
#import "CouponTableViewCell.h"
#import "CouponInfo.h"
#import "DelegateConfiguration.h"

@interface CouponViewController ()<UITableViewDelegate, UITableViewDataSource, LoginStatusDelegate>

@property(nonatomic, strong)NSArray *buttonNameArray;
@property(nonatomic, strong)UIView *btnUnderView;
@property(nonatomic, strong)UITableView *couponTableView;
@property(nonatomic, strong)NSMutableArray *availableMutableA;
@property(nonatomic, strong)NSMutableArray *historyMutableA;
@property(nonatomic, strong)NSString *couponStatusStr; //1---available,  2---history

@end

@implementation CouponViewController
@synthesize couponTypeStr;

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
}

- (UIView *)btnUnderView{
    
    if (_btnUnderView == nil) {
        
        _btnUnderView = [[UIView alloc] initWithFrame:CGRectMake(0, 39, MAINSCREEN.width/2, 1)];
        _btnUnderView.backgroundColor = LOGINBACKCOLOR;
    }
    return _btnUnderView;
}

- (UITableView *)couponTableView{
    
    if (_couponTableView == nil) {
        
        _couponTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, MAINSCREEN.width, MAINSCREEN.height - SafeDistance - 40) style:UITableViewStylePlain];
        _couponTableView.backgroundColor = [UIColor clearColor];
        _couponTableView.delegate = self;
        _couponTableView.dataSource = self;
        _couponTableView.bounces = NO;
        _couponTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _couponTableView;
}

- (NSMutableArray *)availableMutableA{
    
    if (_availableMutableA == nil) {
        
        _availableMutableA = [[NSMutableArray alloc] init];
    }
    return _availableMutableA;
}

- (NSMutableArray *)historyMutableA{
    
    if (_historyMutableA == nil) {
        
        _historyMutableA = [[NSMutableArray alloc] init];
    }
    return _historyMutableA;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的优惠券";
    
    DelegateConfiguration *delegateConfiguration = [DelegateConfiguration sharedConfiguration];
    [delegateConfiguration registerLoginStatusChangedListener:self];
    
    self.couponStatusStr = @"1";
    [self addViews];
    [self getUserCouponsFromInternet];
    // Do any additional setup after loading the view.
}

- (void)addViews{
    
    self.buttonNameArray = @[@"可用", @"历史"];
    [self addButtons:self.buttonNameArray];
    [self.view addSubview:self.btnUnderView];
    [self.view addSubview:self.couponTableView];
}

- (IBAction)backButtonAction:(id)sender{
    
    DelegateConfiguration *delegateConfiguration = [DelegateConfiguration sharedConfiguration];
    [delegateConfiguration unregisterLoginStatusChangedListener:self];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addButtons:(NSArray *)nameArray{
    
    for (int i = 0; i<nameArray.count; i++) {
        
        UIButton *functionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        functionBtn.frame = CGRectMake(MAINSCREEN.width/2*i, 0, MAINSCREEN.width/2, 40);
        functionBtn.tag = 1000+i;
        [functionBtn setTitle:nameArray[i] forState:UIControlStateNormal];
        [functionBtn setTitleColor:TEXTCOLOR64 forState:UIControlStateNormal];
        [functionBtn setTitleColor:LOGINBACKCOLOR forState:UIControlStateSelected];
        if (i == 0) {
            
            functionBtn.selected = YES;
        }
        [functionBtn addTarget:self action:@selector(chickFunctionBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:functionBtn];
    }
}

- (void)chickFunctionBtn:(UIButton *)button{
    
    for (int i = 0; i<self.buttonNameArray.count; i++) {
        
        UIButton *btn = (UIButton *)[[button superview] viewWithTag:1000+i];
        if (button.tag == btn.tag) {
            
            button.selected = YES;
        }else{
            
            [btn setSelected:NO];
        }
    }
    if (button.tag == 1000) {
        
        self.couponStatusStr = @"1";
    }else{
        
        self.couponStatusStr = @"2";
    }
    self.btnUnderView.frame = CGRectMake(MAINSCREEN.width/2*(button.tag - 1000), 39, MAINSCREEN.width/2, 1);
    [self.couponTableView reloadData];
}

- (void)getUserCouponsFromInternet{
    
//    NSLog(@"%@---%@", [UserConfig user_id], [UserConfig userCarId]);
    NSDictionary *userCouponsDic = @{@"userId":[UserConfig user_id]};
    NSString *reqJson = [PublicClass convertToJsonData:userCouponsDic];
    [JJRequest postRequest:@"preferentialInfo/selectsUserCoupons" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {

        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {

            YLog(@"获取优惠券数据：%@", data);
            [self analySizeData:data];
        }else if ([statusStr isEqualToString:@"-999"]){
            
            [self alertIsequallyTokenView];
        }else{

            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {

        NSLog(@"获取用户优惠券列表错误:%@", error);
    }];
}

- (void)analySizeData:(NSDictionary *)dataDic{
    
    NSArray *availableArray = [dataDic objectForKey:@"availableList"];
    NSArray *unusableArray = [dataDic objectForKey:@"unusableList"];
    for (int a = 0; a<availableArray.count; a++) {
        
        NSDictionary *availableDic = [availableArray objectAtIndex:a];
        CouponInfo *a_counponInfo = [[CouponInfo alloc] init];
        [a_counponInfo setValuesForKeysWithDictionary:availableDic];
        [self.availableMutableA addObject:a_counponInfo];
    }
    for (int u = 0; u<unusableArray.count; u++) {
        
        NSDictionary *unusableDic = [unusableArray objectAtIndex:u];
        CouponInfo *u_counponInfo = [[CouponInfo alloc] init];
        [u_counponInfo setValuesForKeysWithDictionary:unusableDic];
        [self.historyMutableA addObject:u_counponInfo];
    }
    [self.couponTableView reloadData];
}

//UITableViewDelegate and UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([self.couponStatusStr isEqualToString:@"1"]) {
        
        return self.availableMutableA.count;
    }else{
        
        return self.historyMutableA.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 135.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIndentifier = @"cell";
    CouponTableViewCell *couponCell = [tableView dequeueReusableCellWithIdentifier:reuseIndentifier];
    if (couponCell == nil) {
        
        couponCell = [[CouponTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIndentifier];
        couponCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    CouponInfo *couponInfo = [[CouponInfo alloc] init];
    if ([self.couponStatusStr isEqualToString:@"1"]) {
        
        couponInfo = [self.availableMutableA objectAtIndex:indexPath.row];
    }else{
        
        couponInfo = [self.historyMutableA objectAtIndex:indexPath.row];
    }
    [couponCell setdatatoViews:couponInfo couponType:couponTypeStr];
    return couponCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.couponStatusStr isEqualToString:@"1"]) {
        
        CouponInfo *couponInfo = [[CouponInfo alloc] init];
        couponInfo = [self.availableMutableA objectAtIndex:indexPath.row];
//        NSLog(@"%@--%@",couponInfo.userCarId, [UserConfig userCarId]);
        if ([couponInfo.userCarId intValue] == [[UserConfig userCarId] intValue]) {
            
            if ([couponTypeStr isEqualToString:@"0"]) {
                
                if ([couponInfo.type intValue] == 2) {
                    
                    self.callBuyStore([NSString stringWithFormat:@"%@", couponInfo.salesId], [NSString stringWithFormat:@"%@", couponInfo.type], couponInfo.couponName);
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }else if ([couponTypeStr isEqualToString:@"1"]){
                
                if ([couponInfo.couponName isEqualToString:@"精致洗车券"] || [couponInfo.type intValue] == 2) {
                    
                    self.callBuyStore([NSString stringWithFormat:@"%@", couponInfo.salesId], [NSString stringWithFormat:@"%@", couponInfo.type], couponInfo.couponName);
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }else if ([couponTypeStr isEqualToString:@"2"]){
                
                if ([couponInfo.couponName isEqualToString:@"四轮定位券"] || [couponInfo.type intValue] == 2) {
                    
                    self.callBuyStore([NSString stringWithFormat:@"%@", couponInfo.salesId], [NSString stringWithFormat:@"%@", couponInfo.type], couponInfo.couponName);
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }else if ([couponTypeStr isEqualToString:@"3"]){
                
                if ([couponInfo.couponName isEqualToString:@"精致洗车券"] || [couponInfo.couponName isEqualToString:@"四轮定位券"] || [couponInfo.type intValue] == 2) {
                    
                    self.callBuyStore([NSString stringWithFormat:@"%@", couponInfo.salesId], [NSString stringWithFormat:@"%@", couponInfo.type], couponInfo.couponName);
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
        }else{
            
//            NSLog(@"%@", couponTypeStr);
            if (couponTypeStr != NULL) {
                
                if ([couponInfo.type intValue] == 2) {
                    
                    self.callBuyStore([NSString stringWithFormat:@"%@", couponInfo.salesId], [NSString stringWithFormat:@"%@", couponInfo.type], couponInfo.couponName);
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
        }
    }
}

//LoginStatusDelegate
- (void)updateLoginStatus{
    
    [self getUserCouponsFromInternet];
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

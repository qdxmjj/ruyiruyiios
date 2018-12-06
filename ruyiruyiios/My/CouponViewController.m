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
@property(nonatomic, strong)UIImageView *backImageV;
@property(nonatomic, strong)NSMutableArray *availableMutableA;
@property(nonatomic, strong)NSMutableArray *historyMutableA;
@property(nonatomic, strong)NSString *couponStatusStr; //1---available,  2---history

@end

@implementation CouponViewController
@synthesize couponTypeStr;

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

- (UIImageView *)backImageV{
    
    if (_backImageV == nil) {
        
        _backImageV = [[UIImageView alloc] initWithFrame:CGRectMake((MAINSCREEN.width - 227)/2, (MAINSCREEN.height - SafeAreaTopHeight - 144)/2, 227, 144)];
        _backImageV.image = [UIImage imageNamed:@"ic_dakongbai"];
    }
    return _backImageV;
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
    [self.view addSubview:self.backImageV];
    self.backImageV.hidden = YES;
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

//            NSLog(@"获取优惠券数据：%@", data);
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
        
        [self hideOrShow:self.availableMutableA.count];
        return self.availableMutableA.count;
    }else{
        
        [self hideOrShow:self.historyMutableA.count];
        return self.historyMutableA.count;
    }
}

- (void)hideOrShow:(NSInteger)number{
    
    if (number == 0) {
        
        self.backImageV.hidden = NO;
    }else{
        
        self.backImageV.hidden = YES;
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
    }
    couponCell.selectionStyle = UITableViewCellSelectionStyleNone;
    CouponInfo *couponInfo;
    if ([self.couponStatusStr isEqualToString:@"1"]) {
        
        couponInfo = [self.availableMutableA objectAtIndex:indexPath.row];
    }else{
        
        couponInfo = [self.historyMutableA objectAtIndex:indexPath.row];
    }
//    [couponCell setdatatoViews:couponInfo couponType:couponTypeStr];
    [couponCell setdatatoViews:couponInfo commodityList:self.commodityList storeID:self.storesID];
    
    return couponCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CouponInfo *couponInfo;
    couponInfo = [self.availableMutableA objectAtIndex:indexPath.row];
    
    //可用优惠券
    if ([self.couponStatusStr isEqualToString:@"1"]) {
        
        //仅限指定车辆可用
        if ([couponInfo.userCarId intValue] == [[UserConfig userCarId] intValue]) {
            
            //判断是否是指定门店 门店ID  可以指定多个门店 也就是 可以是多个门店ID
            NSArray *storeIDArr = [couponInfo.storeIdList componentsSeparatedByString:@","];
            
            if ([storeIDArr containsObject:_storesID] || [couponInfo.storeIdList isEqualToString:@""]) {
                
                if ([couponInfo.type intValue] == 1) {
                    
                    //判断购买的商品列表 是否包含此优惠券对应的名称 包含即可使用此优惠券
                    if ([_commodityList containsObject:couponInfo.rule]) {
                        
                        self.callBuyStore([NSString stringWithFormat:@"%@", couponInfo.coupon_id], [NSString stringWithFormat:@"%@", couponInfo.type], couponInfo.rule);
                        [self.navigationController popViewControllerAnimated:YES];
                    }else{
                        
                    }
                }else if ([couponInfo.type intValue] == 2){
                    
                    //2为现金券 所有商品都可以使用 无任何限制条件  不是指定门店也可以使用
                    self.callBuyStore([NSString stringWithFormat:@"%@", couponInfo.coupon_id], [NSString stringWithFormat:@"%@", couponInfo.type], couponInfo.rule);
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }else{
                
                //2为现金券 所有商品都可以使用 无任何限制条件  不是指定门店也可以使用
                if ([couponInfo.type integerValue] == 2){
                    
                    self.callBuyStore([NSString stringWithFormat:@"%@", couponInfo.coupon_id], [NSString stringWithFormat:@"%@", couponInfo.type], couponInfo.rule);
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
        }else{
            
            //2为现金券 所有商品都可以使用 无任何限制条件 不是指定车辆也可以使用
            if ([couponInfo.type intValue] == 2) {
                
                self.callBuyStore([NSString stringWithFormat:@"%@", couponInfo.coupon_id], [NSString stringWithFormat:@"%@", couponInfo.type], couponInfo.rule);
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }else{
       
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

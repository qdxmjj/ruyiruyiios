//
//  FreeChargeOrderViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/7/7.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "FreeChargeOrderViewController.h"
#import "FreeChargeOrderView.h"
#import "StoreDetailsViewController.h"
#import "TireChaneOrderInfo.h"
#import "ToDeliveryTableViewCell.h"

@interface FreeChargeOrderViewController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UIScrollView *mainScrollV;
@property(nonatomic, strong)FreeChargeOrderView *freeChargeOrderView;
@property(nonatomic, strong)UITableView *freeChargeTableview;
@property(nonatomic, strong)NSMutableArray *changeTireNumberMutableA;
@property(nonatomic, strong)FirstUpdateOrFreeChangeInfo *firstUpdateInfo;
@property(nonatomic, strong)UIButton *submitBtn;

@end

@implementation FreeChargeOrderViewController
@synthesize titleStr;
@synthesize orderNoStr;
@synthesize orderTypeStr;

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (UIScrollView *)mainScrollV{
    
    if (_mainScrollV == nil) {
        
        _mainScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height - SafeDistance - 40)];
        _mainScrollV.bounces = NO;
        _mainScrollV.showsVerticalScrollIndicator = NO;
        _mainScrollV.showsHorizontalScrollIndicator = NO;
        _mainScrollV.delegate = self;
        _mainScrollV.scrollsToTop = NO;
        _mainScrollV.tag = 2;
    }
    return _mainScrollV;
}

- (FreeChargeOrderView *)freeChargeOrderView{
    
    if (_freeChargeOrderView == nil) {
        
        _freeChargeOrderView = [[FreeChargeOrderView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, 225)];
        [_freeChargeOrderView.storeNameBtn addTarget:self action:@selector(chickFreeStoreNameBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _freeChargeOrderView;
}

- (void)chickFreeStoreNameBtn:(UIButton *)button{
    
    StoreDetailsViewController *storeDetialVC = [[StoreDetailsViewController alloc] init];
    storeDetialVC.storeID = [NSString stringWithFormat:@"%@", self.firstUpdateInfo.storeId];
    [self.navigationController pushViewController:storeDetialVC animated:YES];
}

- (UITableView *)freeChargeTableview{
    
    if (_freeChargeTableview == nil) {
        
        _freeChargeTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 225, MAINSCREEN.width, self.changeTireNumberMutableA.count*150) style:UITableViewStylePlain];
        _freeChargeTableview.delegate = self;
        _freeChargeTableview.dataSource = self;
        _freeChargeTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _freeChargeTableview.bounces = NO;
    }
    return _freeChargeTableview;
}

- (UIButton *)submitBtn{
    
    if (_submitBtn == nil) {
        
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.frame = CGRectMake(10, MAINSCREEN.height - SafeDistance - 40, MAINSCREEN.width - 20, 34);
        _submitBtn.layer.cornerRadius = 6.0;
        _submitBtn.layer.masksToBounds = YES;
        if ([titleStr isEqualToString:@"审核通过"]) {
            
            [_submitBtn setTitle:@"更换轮胎" forState:UIControlStateNormal];
            [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_submitBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
            [_submitBtn addTarget:self action:@selector(chickSubmitBtn:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            
            [_submitBtn setTitle:titleStr forState:UIControlStateNormal];
            [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_submitBtn setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }
    }
    return _submitBtn;
}

- (void)chickSubmitBtn:(UIButton *)button{
    
    NSDictionary *postDic = @{@"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]], @"orderNo":orderNoStr, @"cxwyAmount":@"0"};
    NSString *reqJson = [PublicClass convertToJsonData:postDic];
    [JJRequest postRequest:@"confirmUserFreeChangeOrder" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
            self.backOrderBlock(@"update");
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"用户确认免费再换审核结果错误:%@", error);
    }];
}

- (FirstUpdateOrFreeChangeInfo *)firstUpdateInfo{
    
    if (_firstUpdateInfo == nil) {
        
        _firstUpdateInfo = [[FirstUpdateOrFreeChangeInfo alloc] init];
    }
    return _firstUpdateInfo;
}

- (NSMutableArray *)changeTireNumberMutableA{
    
    if (_changeTireNumberMutableA == nil) {
        
        _changeTireNumberMutableA = [[NSMutableArray alloc] init];
    }
    return _changeTireNumberMutableA;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = titleStr;
    
    if (![titleStr isEqualToString:@"审核通过"]) {
        
        [self addRightBtn];
    }
    [self addViews];
    [self getUserOrderInfoByNoAndType];
    // Do any additional setup after loading the view.
}

- (void)addRightBtn{
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
    rightBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14];
    [rightBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(chickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIView *rightBtnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rightBtn.frame.size.width, rightBtn.frame.size.height)];
    [rightBtnView addSubview:rightBtn];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtnView];
    self.navigationItem.rightBarButtonItem = barButton;
}

- (void)chickRightBtn:(UIButton *)button{
    
    NSString *postStr = @"";
    //0轮胎购买，1普通商品，2首次更换，3免费更换，4轮胎修补，5充值信用
    if ([orderTypeStr isEqualToString:@"0"]) {
        
        postStr = @"cancelShoeCxwyOrder";
    }else if ([orderTypeStr isEqualToString:@"1"]){
        
        postStr = @"cancelStockOrder";
    }else if ([orderTypeStr isEqualToString:@"2"]){
        
        postStr = @"cancelFirstChangeOrder";
    }else if ([orderTypeStr isEqualToString:@"3"]){
        
        postStr = @"cancelFreeChangeOrder";
    }else if ([orderTypeStr isEqualToString:@"4"]){
        
        postStr = @"cancelShoeRepairOrder";
    }
    NSDictionary *cancelPostDic = @{@"orderNo":orderNoStr, @"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]]};
    NSString *reqJson = [PublicClass convertToJsonData:cancelPostDic];
    [JJRequest postRequest:postStr params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
            self.tabBarController.tabBar.hidden = NO;
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"取消购买轮胎订单错误:%@", error);
    }];
}

- (void)addViews{
    
    [self.view addSubview:self.mainScrollV];
    [_mainScrollV addSubview:self.freeChargeOrderView];
    self.freeChargeOrderView.serProcessLabel.text = titleStr;
    [self.view addSubview:self.submitBtn];
}

- (void)getUserOrderInfoByNoAndType{
    
    NSDictionary *postDic = @{@"orderNo":orderNoStr, @"orderType":orderTypeStr, @"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]]};
    NSString *reqJson = [PublicClass convertToJsonData:postDic];
    [JJRequest postRequest:@"getUserOrderInfoByNoAndType" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
            //            YLog(@"%@", data);
            [self analySizeData:data];
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"所有订单详情中查询用户订单详情错误:%@", error);
    }];
}

- (void)analySizeData:(NSDictionary *)dataDic{
    
    [self.firstUpdateInfo setValuesForKeysWithDictionary:dataDic];
    
    if (self.firstUpdateInfo.freeChangeOrderVoList != NULL) {
        
        NSArray *dataArray = [dataDic objectForKey:@"freeChangeOrderVoList"];
        for (int i = 0; i<dataArray.count; i++) {
            
            NSDictionary *dic = [dataArray objectAtIndex:i];
            TireChaneOrderInfo *tireInfo = [[TireChaneOrderInfo alloc] init];
            [tireInfo setValuesForKeysWithDictionary:dic];
            [self.changeTireNumberMutableA addObject:tireInfo];
        }
    }
    
    [_mainScrollV addSubview:self.freeChargeTableview];
    [_mainScrollV setContentSize:CGSizeMake(MAINSCREEN.width, self.freeChargeTableview.frame.size.height + self.freeChargeTableview.frame.origin.y)];
    [self setdatatoViews];
}

- (void)setdatatoViews{
    
    [_freeChargeOrderView setDatatoDeliveryViews:self.firstUpdateInfo];
}

//UITableViewDelegate and UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.changeTireNumberMutableA.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIndentifier = @"cell";
    ToDeliveryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIndentifier];
    if (cell == nil) {
        
        cell = [[ToDeliveryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIndentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    TireChaneOrderInfo *tireInfo = [self.changeTireNumberMutableA objectAtIndex:indexPath.row];
    [cell setdatatoCellViews:tireInfo img:self.firstUpdateInfo.orderImg];
    return cell;
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

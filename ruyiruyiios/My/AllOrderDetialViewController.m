//
//  AllOrderDetialViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/28.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "AllOrderDetialViewController.h"
#import "ToDeliveryView.h"
#import "ToDeliveryTableViewCell.h"
#import "FirstUpdateOrFreeChangeInfo.h"
#import "StoreDetailsViewController.h"
#import "TireChaneOrderInfo.h"

@interface AllOrderDetialViewController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UIScrollView *mainScrollV;
@property(nonatomic, strong)ToDeliveryView *todeliveryView;
@property(nonatomic, strong)UITableView *tireChangeTableview;
@property(nonatomic, strong)NSMutableArray *changeTireNumberMutableA;
@property(nonatomic, strong)UIButton *submitBtn;
@property(nonatomic, strong)FirstUpdateOrFreeChangeInfo *firstUpdateInfo;

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
        _mainScrollV.bounces = NO;
        _mainScrollV.showsVerticalScrollIndicator = NO;
        _mainScrollV.showsHorizontalScrollIndicator = NO;
        _mainScrollV.delegate = self;
        _mainScrollV.scrollsToTop = NO;
        _mainScrollV.tag = 2;
    }
    return _mainScrollV;
}

- (ToDeliveryView *)todeliveryView{
    
    if (_todeliveryView == nil) {
        
        _todeliveryView = [[ToDeliveryView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, 190)];
        [_todeliveryView.storeNameBtn addTarget:self action:@selector(chickDeliveryStoreNameBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _todeliveryView;
}

- (UITableView *)tireChangeTableview{
    
    if (_tireChangeTableview == nil) {
        
        _tireChangeTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 190, MAINSCREEN.width, self.changeTireNumberMutableA.count*150) style:UITableViewStylePlain];
        _tireChangeTableview.delegate = self;
        _tireChangeTableview.dataSource = self;
        _tireChangeTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tireChangeTableview.bounces = NO;
    }
    return _tireChangeTableview;
}

- (void)chickDeliveryStoreNameBtn:(UIButton *)button{
    
    StoreDetailsViewController *storeDetialVC = [[StoreDetailsViewController alloc] init];
    storeDetialVC.storeID = [NSString stringWithFormat:@"%@", self.firstUpdateInfo.storeId];
    [self.navigationController pushViewController:storeDetialVC animated:YES];
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
        [_submitBtn setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    return _submitBtn;
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
    if ([titleStr isEqualToString:@"待发货"]) {
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
    [_mainScrollV addSubview:self.todeliveryView];
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
    if (self.firstUpdateInfo.firstChangeOrderVoList != NULL) {
    
        NSArray *dataArray = [dataDic objectForKey:@"firstChangeOrderVoList"];
        for (int i = 0; i<dataArray.count; i++) {
            
            NSDictionary *dic = [dataArray objectAtIndex:i];
            TireChaneOrderInfo *tireInfo = [[TireChaneOrderInfo alloc] init];
            [tireInfo setValuesForKeysWithDictionary:dic];
            [self.changeTireNumberMutableA addObject:tireInfo];
        }
    }
    if (self.firstUpdateInfo.freeChangeOrderVoList != NULL) {
        
        NSArray *dataArray = [dataDic objectForKey:@"freeChangeOrderVoList"];
        for (int i = 0; i<dataArray.count; i++) {
            
            NSDictionary *dic = [dataArray objectAtIndex:i];
            TireChaneOrderInfo *tireInfo = [[TireChaneOrderInfo alloc] init];
            [tireInfo setValuesForKeysWithDictionary:dic];
            [self.changeTireNumberMutableA addObject:tireInfo];
        }
    }
    [_mainScrollV addSubview:self.tireChangeTableview];
    [self setdatatoViews];
}

- (void)setdatatoViews{
    
    [_todeliveryView setDatatoDeliveryViews:self.firstUpdateInfo];
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

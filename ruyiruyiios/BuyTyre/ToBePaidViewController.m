//
//  ToBePaidViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/30.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "ToBePaidViewController.h"
#import "TopayMiddleView.h"
#import "TopayBottomView.h"
#import "CashierViewController.h"
#import "TobepayInfo.h"
#import "ShoeOrderVo.h"
#import "ToDeliveryTableViewCell.h"
#import "TireChaneOrderInfo.h"

@interface ToBePaidViewController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UIScrollView *mainScrollV;
@property(nonatomic, strong)UIImageView *headImageV;
@property(nonatomic, strong)UIButton *topayBtn;
@property(nonatomic, strong)TopayMiddleView *topayMiddleView;
@property(nonatomic, strong)TopayBottomView *topayBottomView;
@property(nonatomic, strong)UITableView *freeChangeTableV;
@property(nonatomic, strong)NSMutableArray *tireFreeChangeMutableA;
@property(nonatomic, strong)ShoeOrderVo *shoeOrdervo;
@property(nonatomic, strong)TobepayInfo *tobepayInfo;

@end

@implementation ToBePaidViewController
@synthesize statusStr;
@synthesize totalPriceStr;
@synthesize orderNoStr;
@synthesize orderTypeStr;

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
}

- (UIScrollView *)mainScrollV{
    
    if (_mainScrollV == nil) {
        
        _mainScrollV = [[UIScrollView alloc] init];
        _mainScrollV.frame = CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height - 40 - SafeDistance);
        _mainScrollV.showsVerticalScrollIndicator = NO;
        _mainScrollV.showsHorizontalScrollIndicator = NO;
        _mainScrollV.bounces = NO;
        _mainScrollV.scrollsToTop = NO;
        _mainScrollV.tag = 1;
        _mainScrollV.delegate = self;
    }
    return _mainScrollV;
}

- (UIImageView *)headImageV{
    
    if (_headImageV == nil) {
        
        _headImageV = [[UIImageView alloc] init];
        _headImageV.frame = CGRectMake(0, 0, MAINSCREEN.width, 120);
        _headImageV.image = [UIImage imageNamed:@"ic_banner"];
    }
    return _headImageV;
}

- (UIButton *)topayBtn{
    
    if (_topayBtn == nil) {
        
        _topayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _topayBtn.frame = CGRectMake(10, MAINSCREEN.height - 40 - SafeDistance, MAINSCREEN.width - 20, 34);
        _topayBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _topayBtn.layer.cornerRadius = 4.0;
        _topayBtn.layer.masksToBounds = YES;
        [_topayBtn setTitle:@"前往支付" forState:UIControlStateNormal];
        [_topayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_topayBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [_topayBtn addTarget:self action:@selector(chickTopayBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _topayBtn;
}

- (TopayMiddleView *)topayMiddleView{
    
    if (_topayMiddleView == nil) {
        
        _topayMiddleView = [[TopayMiddleView alloc] initWithFrame:CGRectMake(0, 120, MAINSCREEN.width, 150)];
    }
    return _topayMiddleView;
}

- (TopayBottomView *)topayBottomView{
    
    if (_topayBottomView == nil) {
        
        _topayBottomView = [[TopayBottomView alloc] initWithFrame:CGRectMake(0, 270, MAINSCREEN.width, 200)];
    }
    return _topayBottomView;
}

- (UITableView *)freeChangeTableV{
    
    if (_freeChangeTableV == nil) {
        
        _freeChangeTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 270, MAINSCREEN.width, self.tireFreeChangeMutableA.count*150) style:UITableViewStylePlain];
        _freeChangeTableV.delegate = self;
        _freeChangeTableV.dataSource = self;
        _freeChangeTableV.bounces = NO;
        _freeChangeTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _freeChangeTableV.showsVerticalScrollIndicator = NO;
        _freeChangeTableV.showsHorizontalScrollIndicator = NO;
    }
    return _freeChangeTableV;
}

- (NSMutableArray *)tireFreeChangeMutableA{
    
    if (_tireFreeChangeMutableA == nil) {
        
        _tireFreeChangeMutableA = [[NSMutableArray alloc] init];
    }
    return _tireFreeChangeMutableA;
}

- (ShoeOrderVo *)shoeOrdervo{
    
    if (_shoeOrdervo == nil) {
        
        _shoeOrdervo = [[ShoeOrderVo alloc] init];
    }
    return _shoeOrdervo;
}

- (TobepayInfo *)tobepayInfo{
    
    if (_tobepayInfo == nil) {
        
        _tobepayInfo = [[TobepayInfo alloc] init];
    }
    return _tobepayInfo;
}

- (void)chickTopayBtn:(UIButton *)button{
    
    if ([statusStr isEqualToString:@"1"]) {
        
        CashierViewController *cashierVC = [[CashierViewController alloc] init];
        cashierVC.orderNoStr = orderNoStr;
        cashierVC.totalPriceStr = totalPriceStr;
        cashierVC.orderTypeStr = orderTypeStr;
        [self.navigationController pushViewController:cashierVC animated:YES];
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }
//    CashierViewController *cashierVC = [[CashierViewController alloc] init];
//    cashierVC.orderNoStr = orderNoStr;
//    cashierVC.totalPriceStr = totalPriceStr;
//    cashierVC.userStatusStr = orderTypeStr;
//    [self.navigationController pushViewController:cashierVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"待支付";
    
    if ([self.orderTypeStr isEqualToString:@"0"]) {
        
        [self addRightBtn];
    }
    [self.view addSubview:self.mainScrollV];
    [self.view addSubview:self.topayBtn];
    [_mainScrollV addSubview:self.headImageV];
    [_mainScrollV addSubview:self.topayMiddleView];
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
            
            if ([self.statusStr isEqualToString:@"1"]) {
                
                __strong typeof(self) strongSelf = self;
                strongSelf.updateOrderVC(@"update");
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                
                self.tabBarController.tabBar.hidden = NO;
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"取消购买轮胎订单错误:%@", error);
    }];
}

- (void)getUserOrderInfoByNoAndType{
    
    NSDictionary *orderInfoPostDic = @{@"orderNo":orderNoStr, @"orderType":orderTypeStr, @"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]]};
    NSString *reqJson = [PublicClass convertToJsonData:orderInfoPostDic];
    [JJRequest postRequest:@"getUserOrderInfoByNoAndType" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
            NSLog(@"%@", data);
            [self analysizeData:data];
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"查询用户订单详情错误：%@", error);
    }];
}

- (void)analysizeData:(NSDictionary *)dataDic{
    
    [self.tobepayInfo setValuesForKeysWithDictionary:dataDic];
    
    if (![self.tobepayInfo.shoeOrderVoList isEqual:@[]]) {
        
        [self.shoeOrdervo setValuesForKeysWithDictionary:[[dataDic objectForKey:@"shoeOrderVoList"] objectAtIndex:0]];
    }
    
    if (self.tobepayInfo.freeChangeOrderVoList != NULL) {
        
        NSArray *dataArray = [dataDic objectForKey:@"freeChangeOrderVoList"];
        for (int i = 0; i<dataArray.count; i++) {
            
            NSDictionary *dic = [dataArray objectAtIndex:i];
            TireChaneOrderInfo *tireInfo = [[TireChaneOrderInfo alloc] init];
            [tireInfo setValuesForKeysWithDictionary:dic];
            [self.tireFreeChangeMutableA addObject:tireInfo];
        }
    }
    [self addView];
}

- (IBAction)backButtonAction:(id)sender{
    
    if ([statusStr isEqualToString:@"1"]) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        
        self.tabBarController.tabBar.hidden = NO;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)addView{
    
    if ([self.orderTypeStr isEqualToString:@"0"]) {
        
        [_mainScrollV addSubview:self.topayBottomView];
        [_mainScrollV setContentSize:CGSizeMake(MAINSCREEN.width, (self.topayBottomView.frame.size.height + self.topayBottomView.frame.origin.y))];
    }else{
        
        [_mainScrollV addSubview:self.freeChangeTableV];
        [_mainScrollV setContentSize:CGSizeMake(MAINSCREEN.width, (self.freeChangeTableV.frame.size.height + self.freeChangeTableV.frame.origin.y))];
    }
    [self setdataToViews];
}

- (void)setdataToViews{
    
    [_topayMiddleView setPayMiddleViewData:self.tobepayInfo totalPrice:totalPriceStr];
    if ([self.orderTypeStr isEqualToString:@"0"]) {
        
        [_topayBottomView setTopayBottomViewData:self.shoeOrdervo tobePayinfo:self.tobepayInfo];
    }
}

//UITableViewDelegate and UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.tireFreeChangeMutableA.count;
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
    TireChaneOrderInfo *tireInfo = [self.tireFreeChangeMutableA objectAtIndex:indexPath.row];
    [cell setdatatoCellViews:tireInfo img:self.tobepayInfo.orderImg];
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

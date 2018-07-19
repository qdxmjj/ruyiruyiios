//
//  ToServiceViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/7/1.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "ToServiceViewController.h"
#import "ToDeliveryView.h"
#import "FirstUpdateOrFreeChangeInfo.h"
#import "StoreDetailsViewController.h"
#import "ToDeliveryTableViewCell.h"
#import "StockOrderVoInfo.h"
#import "ToserviceStoreTableViewCell.h"
#import "BarCodeView.h"

@interface ToServiceViewController ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UIScrollView *mainScrollV;
@property(nonatomic, strong)ToDeliveryView *todeliveryView;
@property(nonatomic, strong)UITableView *toServiceTableview;
@property(nonatomic, strong)NSMutableArray *TireNumberOrStoreMutableA;
@property(nonatomic, strong)UIButton *submitBtn;
@property(nonatomic, strong)FirstUpdateOrFreeChangeInfo *firstUpdateInfo;
@property(nonatomic, strong)BarCodeView *barCodeView;
@property(nonatomic, strong)NSMutableArray *barCodeMutableA;

@end

@implementation ToServiceViewController
@synthesize titleStr;
@synthesize orderTypeStr;
@synthesize orderNoStr;

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

- (ToDeliveryView *)todeliveryView{
    
    if (_todeliveryView == nil) {
        
        _todeliveryView = [[ToDeliveryView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, 190)];
        [_todeliveryView.storeNameBtn addTarget:self action:@selector(chickDeliveryStoreNameBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _todeliveryView;
}

- (UITableView *)toServiceTableview{
    
    if (_toServiceTableview == nil) {
        
        _toServiceTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 190, MAINSCREEN.width, self.TireNumberOrStoreMutableA.count*150) style:UITableViewStylePlain];
        _toServiceTableview.delegate = self;
        _toServiceTableview.dataSource = self;
        _toServiceTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _toServiceTableview.bounces = NO;
    }
    return _toServiceTableview;
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
        [_submitBtn setTitle:titleStr forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _submitBtn;
}

- (FirstUpdateOrFreeChangeInfo *)firstUpdateInfo{
    
    if (_firstUpdateInfo == nil) {
        
        _firstUpdateInfo = [[FirstUpdateOrFreeChangeInfo alloc] init];
    }
    return _firstUpdateInfo;
}

- (NSMutableArray *)TireNumberOrStoreMutableA{
    
    if (_TireNumberOrStoreMutableA == nil) {
        
        _TireNumberOrStoreMutableA = [[NSMutableArray alloc] init];
    }
    return _TireNumberOrStoreMutableA;
}

- (NSMutableArray *)barCodeMutableA{
    
    if (_barCodeMutableA == nil) {
        
        _barCodeMutableA = [[NSMutableArray alloc] init];
    }
    return _barCodeMutableA;
}

- (BarCodeView *)barCodeView{
    
    if (_barCodeView == nil) {
        
        _barCodeView = [[BarCodeView alloc] initWithFrame:CGRectMake(0, self.toServiceTableview.frame.size.height + self.toServiceTableview.frame.origin.y, MAINSCREEN.width, (self.barCodeMutableA.count * 30 + 40)) number:self.barCodeMutableA];
    }
    return _barCodeView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = titleStr;
    if ([titleStr isEqualToString:@"待商家确认服务"]) {
        [self addRightBtn];
    }
    [self addViews];
    [self getUserOrderInfoByNoAndType];
    // Do any additional setup after loading the view.
}

- (void)addRightBtn{
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
    rightBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14];
    [rightBtn setTitle:@"退款" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(chickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIView *rightBtnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rightBtn.frame.size.width, rightBtn.frame.size.height)];
    [rightBtnView addSubview:rightBtn];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtnView];
    self.navigationItem.rightBarButtonItem = barButton;
}

- (void)chickRightBtn:(UIButton *)button{
    
    NSString *hostStr = @"";
    if ([orderTypeStr isEqualToString:@"0"]) {
        
        hostStr = @"refundShoeCxwyOrder";
    }else{
        
        hostStr = @"refundStockOrder";
    }
    NSDictionary *refundPostDic = @{@"orderNo":orderNoStr, @"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]]};
    NSString *reqJson = [PublicClass convertToJsonData:refundPostDic];
    [JJRequest postRequest:hostStr params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
            self.callBackBlock(@"3");
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"退款轮胎购买订单或商品订单错误:%@", error);
    }];
}

- (void)addViews{
    
    [self.view addSubview:self.mainScrollV];
    [_mainScrollV addSubview:self.todeliveryView];
    [self.view addSubview:self.submitBtn];
    if ([titleStr isEqualToString:@"确认服务"]) {
        
        [self.submitBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [self.submitBtn addTarget:self action:@selector(chickSubmitBtn:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        
        self.submitBtn.userInteractionEnabled = NO;
        [self.submitBtn setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
}

- (void)chickSubmitBtn:(UIButton *)button{
    
    NSDictionary *confirmPost = @{@"orderNo":orderNoStr, @"orderType":orderTypeStr, @"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]]};
    NSString *reqJson = [PublicClass convertToJsonData:confirmPost];
    [JJRequest postRequest:@"userConfirmOrderServiced" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
            self.callBackBlock(@"4");
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"确认服务错误:%@", error);
    }];
}

- (void)getUserOrderInfoByNoAndType{
    
    NSDictionary *postDic = @{@"orderNo":orderNoStr, @"orderType":orderTypeStr, @"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]]};
    NSString *reqJson = [PublicClass convertToJsonData:postDic];
    [JJRequest postRequest:@"getUserOrderInfoByNoAndType" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
            NSLog(@"%@", data);
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
            [self.TireNumberOrStoreMutableA addObject:tireInfo];
        }
    }
    
    if (self.firstUpdateInfo.freeChangeOrderVoList != NULL) {
        
        NSArray *dataArray = [dataDic objectForKey:@"freeChangeOrderVoList"];
        for (int i = 0; i<dataArray.count; i++) {
            
            NSDictionary *dic = [dataArray objectAtIndex:i];
            TireChaneOrderInfo *tireInfo = [[TireChaneOrderInfo alloc] init];
            [tireInfo setValuesForKeysWithDictionary:dic];
            [self.TireNumberOrStoreMutableA addObject:tireInfo];
        }
    }
    
    if (![self.firstUpdateInfo.stockOrderVoList isEqual:@[]]) {
        
        NSArray *stockArray = [dataDic objectForKey:@"stockOrderVoList"];
        for (int p = 0; p<stockArray.count; p++) {
            
            NSDictionary *dic = [stockArray objectAtIndex:p];
            StockOrderVoInfo *stockVoInfo = [[StockOrderVoInfo alloc] init];
            [stockVoInfo setValuesForKeysWithDictionary:dic];
            [self.TireNumberOrStoreMutableA addObject:stockVoInfo];
        }
    }
    if (self.firstUpdateInfo.userCarShoeBarCodeList != NULL) {
        
        NSArray *userCarArray = [dataDic objectForKey:@"userCarShoeBarCodeList"];
        for (int u = 0; u<userCarArray.count; u++) {
            
            NSDictionary *dic = [userCarArray objectAtIndex:u];
            NSString *barStr = [dic objectForKey:@"barCode"];
            [self.barCodeMutableA addObject:barStr];
        }
    }
    
    [_mainScrollV addSubview:self.toServiceTableview];
    if (self.barCodeMutableA.count != 0) {
        
        [_mainScrollV addSubview:self.barCodeView];
        [_mainScrollV setContentSize:CGSizeMake(MAINSCREEN.width, self.barCodeView.frame.size.height + self.barCodeView.frame.origin.y)];
    }else{
        
        [_mainScrollV setContentSize:CGSizeMake(MAINSCREEN.width, self.toServiceTableview.frame.size.height + self.toServiceTableview.frame.origin.y)];
    }
    [self setdatatoViews];
}

- (void)setdatatoViews{
    
    [_todeliveryView setDatatoDeliveryViews:self.firstUpdateInfo];
}

//UITableViewDelegate and UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.TireNumberOrStoreMutableA.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        
    if (self.firstUpdateInfo.firstChangeOrderVoList == NULL && self.firstUpdateInfo.freeChangeOrderVoList == NULL) {
        
        static NSString *reuseIndentifier = @"storeCell";
        ToserviceStoreTableViewCell *storeCell = [tableView dequeueReusableCellWithIdentifier:reuseIndentifier];
        if (storeCell == nil) {
            
            storeCell = [[ToserviceStoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIndentifier];
            storeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        StockOrderVoInfo *stockOrderInfo = [self.TireNumberOrStoreMutableA objectAtIndex:indexPath.row];
        [storeCell setdatatoCellViews:stockOrderInfo];
        return storeCell;
    }else{
        
        static NSString *reuseIndentifier = @"cell";
        ToDeliveryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIndentifier];
        if (cell == nil) {
            
            cell = [[ToDeliveryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIndentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        TireChaneOrderInfo *tireInfo = [self.TireNumberOrStoreMutableA objectAtIndex:indexPath.row];
        [cell setdatatoCellViews:tireInfo img:self.firstUpdateInfo.orderImg];
        return cell;
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

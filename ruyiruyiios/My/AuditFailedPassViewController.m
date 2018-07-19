//
//  AuditFailedPassViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/7/7.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "AuditFailedPassViewController.h"
#import "StoreDetailsViewController.h"
#import "TireChaneOrderInfo.h"
#import "ToDeliveryTableViewCell.h"
#import "ToDeliveryView.h"
#import "FreeChangeViewController.h"
#import "SupplementView.h"
#import "UserCarShoeOldBarCodeInfo.h"
#import "CarCXWYInfo.h"
#import "CashierViewController.h"

@interface AuditFailedPassViewController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UIScrollView *mainScrollV;
@property(nonatomic, strong)ToDeliveryView *toDeliveyView;
@property(nonatomic, strong)UILabel *realAuditLabel;
@property(nonatomic, strong)UILabel *failCauseLabel;
@property(nonatomic, strong)NSString *causeStr;
@property(nonatomic, strong)UITableView *freeChargeTableview;
@property(nonatomic, strong)NSMutableArray *changeTireNumberMutableA;
@property(nonatomic, strong)FirstUpdateOrFreeChangeInfo *firstUpdateInfo;
@property(nonatomic, strong)SupplementView *supplementView;
@property(nonatomic, strong)NSMutableArray *userCarShoeOldBarCodeMutableA;
@property(nonatomic, strong)NSMutableArray *cxwyCountMutableA;
@property(nonatomic, strong)UIButton *submitBtn;
@property(nonatomic, strong)UIButton *toSupplementBtn;
@property(nonatomic, strong)UIButton *toTireBtn;

@end

@implementation AuditFailedPassViewController
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

- (UILabel *)realAuditLabel{
    
    if (_realAuditLabel == nil) {
        
        _realAuditLabel = [[UILabel alloc] initWithFrame:CGRectMake(MAINSCREEN.width/2, 205, MAINSCREEN.width/2 - 20, 20)];
        _realAuditLabel.text = @"审核不通过";
        _realAuditLabel.textColor = [UIColor lightGrayColor];
        _realAuditLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _realAuditLabel.textAlignment = NSTextAlignmentRight;
    }
    return _realAuditLabel;
}

- (UILabel *)failCauseLabel{
    
    if (_failCauseLabel == nil) {
        
        _failCauseLabel = [[UILabel alloc] init];
        _failCauseLabel.numberOfLines = 0;
        _failCauseLabel.text = self.causeStr;
        _failCauseLabel.textColor = [UIColor lightGrayColor];
        _failCauseLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _failCauseLabel.textAlignment = NSTextAlignmentRight;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:_failCauseLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        CGSize labelsize = [_failCauseLabel.text boundingRectWithSize:CGSizeMake(MAINSCREEN.width/2 - 20, MAINSCREEN.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        [_failCauseLabel setFrame:CGRectMake(MAINSCREEN.width/2, 240, labelsize.width, labelsize.height)];
    }
    return _failCauseLabel;
}

- (ToDeliveryView *)toDeliveyView{
    
    if (_toDeliveyView == nil) {
        
        _toDeliveyView = [[ToDeliveryView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, 190)];
        [_toDeliveyView.storeNameBtn addTarget:self action:@selector(chickDeliveryStoreNameBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _toDeliveyView;
}

- (void)chickDeliveryStoreNameBtn:(UIButton *)button{
    
    StoreDetailsViewController *storeDetialVC = [[StoreDetailsViewController alloc] init];
    storeDetialVC.storeID = [NSString stringWithFormat:@"%@", self.firstUpdateInfo.storeId];
    [self.navigationController pushViewController:storeDetialVC animated:YES];
}

- (UITableView *)freeChargeTableview{
    
    if (_freeChargeTableview == nil) {
        
        _freeChargeTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, self.failCauseLabel.frame.origin.y + self.failCauseLabel.frame.size.height + 15, MAINSCREEN.width, self.changeTireNumberMutableA.count*150) style:UITableViewStylePlain];
        _freeChargeTableview.delegate = self;
        _freeChargeTableview.dataSource = self;
        _freeChargeTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _freeChargeTableview.bounces = NO;
    }
    return _freeChargeTableview;
}

- (SupplementView *)supplementView{
    
    if (_supplementView == nil) {
        
        _supplementView = [[SupplementView alloc] initWithFrame:CGRectMake(0, self.freeChargeTableview.frame.size.height + self.freeChargeTableview.frame.origin.y, MAINSCREEN.width, 35+self.userCarShoeOldBarCodeMutableA.count * 180 + 100) numberOfSupplement:self.userCarShoeOldBarCodeMutableA];
    }
    return _supplementView;
}

- (NSMutableArray *)userCarShoeOldBarCodeMutableA{
    
    if (_userCarShoeOldBarCodeMutableA == nil) {
        
        _userCarShoeOldBarCodeMutableA = [[NSMutableArray alloc] init];
    }
    return _userCarShoeOldBarCodeMutableA;
}

- (NSMutableArray *)cxwyCountMutableA{
    
    if (_cxwyCountMutableA == nil) {
        
        _cxwyCountMutableA = [[NSMutableArray alloc] init];
    }
    return _cxwyCountMutableA;
}

- (UIButton *)submitBtn{
    
    if (_submitBtn == nil) {
        
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.frame = CGRectMake(10, MAINSCREEN.height - SafeDistance - 40, MAINSCREEN.width - 20, 34);
        _submitBtn.layer.cornerRadius = 6.0;
        _submitBtn.layer.masksToBounds = YES;
        [_submitBtn setTitle:@"重新下单" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(chickSubmitBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

- (UIButton *)toSupplementBtn{
    
    if (_toSupplementBtn == nil) {
        
        _toSupplementBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _toSupplementBtn.frame = CGRectMake(0, MAINSCREEN.height - SafeDistance - 40, MAINSCREEN.width/2, 40);
        _toSupplementBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        [_toSupplementBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_toSupplementBtn setTitle:@"去补差" forState:UIControlStateNormal];
        [_toSupplementBtn setTitleColor:TEXTCOLOR64 forState:UIControlStateNormal];
        [_toSupplementBtn addTarget:self action:@selector(chickSupplementBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _toSupplementBtn;
}

- (void)chickSupplementBtn:(UIButton *)button{
    
    if ([self.supplementView.needMoneyLabel.text isEqualToString:@"¥ 0"]) {
        
        [PublicClass showHUD:@"您没有未达标轮胎，赶紧前往更换吧!" view:self.view];
    }else{
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请确认前往补差" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            CashierViewController *cashierVC = [[CashierViewController alloc] init];
            cashierVC.orderTypeStr = self.orderTypeStr;
            cashierVC.orderNoStr = self.orderNoStr;
//            NSLog(@"补差的价格:%@", [self.supplementView.needMoneyLabel.text substringWithRange:NSMakeRange(2, self.supplementView.needMoneyLabel.text.length - 2)]);
            cashierVC.totalPriceStr = [self.supplementView.needMoneyLabel.text substringWithRange:NSMakeRange(2, self.supplementView.needMoneyLabel.text.length - 2)];
            [self.navigationController pushViewController:cashierVC animated:YES];
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            
        }];
        [alert addAction:ok];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (UIButton *)toTireBtn{
    
    if (_toTireBtn == nil) {
        
        _toTireBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _toTireBtn.frame = CGRectMake(MAINSCREEN.width/2, MAINSCREEN.height - SafeDistance - 40, MAINSCREEN.width/2, 40);
        _toTireBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        [_toTireBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [_toTireBtn setTitle:@"去换轮胎" forState:UIControlStateNormal];
        [_toTireBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_toTireBtn addTarget:self action:@selector(chickTireBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _toTireBtn;
}

- (void)chickTireBtn:(UIButton *)button{
    
    if ([self.supplementView.needMoneyLabel.text isEqualToString:@"¥ 0"]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请确认前往更换" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSDictionary *postDic = @{@"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]], @"orderNo":self.orderNoStr, @"cxwyAmount":self.supplementView.passnotWorryView.numberLabel.text};
            NSString *reqJson = [PublicClass convertToJsonData:postDic];
            [JJRequest postRequest:@"confirmUserFreeChangeOrder" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
                
                NSString *statusStr = [NSString stringWithFormat:@"%@", code];
                NSString *messageStr = [NSString stringWithFormat:@"%@", message];
                if ([statusStr isEqualToString:@"1"]) {
                    
                    self.toOrderBlock(@"update");
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    
                    [PublicClass showHUD:messageStr view:self.view];
                }
            } failure:^(NSError * _Nullable error) {
                
                NSLog(@"用户确认免费再换审核结果的错误:%@", error);
            }];
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            
        }];
        [alert addAction:ok];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        
        [PublicClass showHUD:@"请使用畅行无忧或者补差后继续操作" view:self.view];
    }
}

- (void)chickSubmitBtn:(UIButton *)button{
    
    FreeChangeViewController *freeChangeVC = [[FreeChangeViewController alloc] init];
    freeChangeVC.popStatus = @"2";
    [self.navigationController pushViewController:freeChangeVC animated:YES];
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
    [self addViews];
    [self getUserOrderInfoByNoAndType];
    // Do any additional setup after loading the view.
}

- (void)addViews{
    
    NSArray *nameArrray = @[@"审核情况", @"失败原因"];
    [self.view addSubview:self.mainScrollV];
    [_mainScrollV addSubview:self.toDeliveyView];
    [self addUnchangeViews:nameArrray];
    [_mainScrollV addSubview:self.realAuditLabel];
    
    if (![titleStr isEqualToString:@"审核未通过"]) {
        
        [self.view addSubview:self.toSupplementBtn];
        [self.view addSubview:self.toTireBtn];
    }else{
        
        [self.view addSubview:self.submitBtn];
    }
}

- (void)addUnchangeViews:(NSArray *)array{
    
    for (int i = 0; i<array.count; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(20, 205+35*i, MAINSCREEN.width/2 - 20, 20);
        label.text = array[i];
        label.textColor = TEXTCOLOR64;
        label.textAlignment = NSTextAlignmentLeft;
        [_mainScrollV addSubview:label];
    }
}

- (void)addUnderView{
    
    UIView *underView = [[UIView alloc] initWithFrame:CGRectMake(0, self.failCauseLabel.frame.origin.y+self.failCauseLabel.frame.size.height + 13, MAINSCREEN.width, 1)];
    underView.backgroundColor = [PublicClass colorWithHexString:@"#ececec"];
    [_mainScrollV addSubview:underView];
}

- (void)getUserOrderInfoByNoAndType{
    
    NSDictionary *postDic = @{@"orderNo":orderNoStr, @"orderType":orderTypeStr, @"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]]};
    NSString *reqJson = [PublicClass convertToJsonData:postDic];
    [JJRequest postRequest:@"getUserOrderInfoByNoAndType" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
            NSLog(@"返回的数据：%@", data);
            [self analySizeData:data];
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"所有订单详情中查询用户订单详情错误:%@", error);
    }];
}

- (void)analySizeData:(NSDictionary *)dataDic{
    
    self.causeStr = [dataDic objectForKey:@"origin"];
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
    
    if (![self.firstUpdateInfo.userCarShoeOldBarCodeList isEqual:@[]]) {
        
        NSArray *barcodeArray = [dataDic objectForKey:@"userCarShoeOldBarCodeList"];
        for (int b = 0; b<barcodeArray.count; b++) {
            
            NSDictionary *barDic = [barcodeArray objectAtIndex:b];
            UserCarShoeOldBarCodeInfo *codeInfo = [[UserCarShoeOldBarCodeInfo alloc] init];
            [codeInfo setValuesForKeysWithDictionary:barDic];
            if ([codeInfo.stage intValue] == 1) {
                
                [self.userCarShoeOldBarCodeMutableA addObject:codeInfo];
            }
        }
    }
    
    [self queryCarCxwyInfo];
}

- (void)queryCarCxwyInfo{
    
    NSDictionary *postDic = @{@"userId":[UserConfig user_id], @"userCarId":[UserConfig userCarId]};
    NSString *reqJson = [PublicClass convertToJsonData:postDic];
    [JJRequest postRequest:@"userCarInfo/queryCarCxwyInfo" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
//            NSLog(@"%@", data);
            [self handleCXWYData:data];
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"查询用户车辆畅行无忧信息错误:%@", error);
    }];
}

- (void)handleCXWYData:(NSArray *)array{
    
    for (int i = 0; i<array.count; i++) {
        
        NSDictionary *dataDic = [array objectAtIndex:i];
        CarCXWYInfo *carCXWYInfo = [[CarCXWYInfo alloc] init];
        [carCXWYInfo setValuesForKeysWithDictionary:dataDic];
        if ([carCXWYInfo.cxwyState intValue] == 1) {
            
            [self.cxwyCountMutableA addObject:carCXWYInfo];
        }
    }
    [self setdatatoViews];
}

- (void)setdatatoViews{
    
    [_toDeliveyView setDatatoDeliveryViews:self.firstUpdateInfo];
    [_mainScrollV addSubview:self.failCauseLabel];
    [self addUnderView];
    [_mainScrollV addSubview:self.freeChargeTableview];
    if (![titleStr isEqualToString:@"审核未通过"]) {
        
        NSString *countStr = [NSString stringWithFormat:@"%ld", self.cxwyCountMutableA.count];
        [_mainScrollV addSubview:self.supplementView];
        [_supplementView setdatatoSupplementViews:countStr];
        [_mainScrollV setContentSize:CGSizeMake(MAINSCREEN.width, self.supplementView.frame.size.height + self.supplementView.frame.origin.y)];
    }else{
        
        [_mainScrollV setContentSize:CGSizeMake(MAINSCREEN.width, self.freeChargeTableview.frame.size.height + self.freeChargeTableview.frame.origin.y)];
    }
    
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

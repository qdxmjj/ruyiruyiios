//
//  SmoothJourneyViewController.m
//  ruyiruyiios
//
//  Created by 姚永敏 on 2018/9/20.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "SmoothJourneyViewController.h"
#import "CxwyFreeReplaceViewController.h"
#import "PassImpededTableViewCell.h"
#import "DelegateConfiguration.h"
#import <Masonry.h>
@interface SmoothJourneyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UIButton *buyPassImpededBtn;
@property (strong, nonatomic)NSMutableArray *couponArr;

@property(nonatomic, strong)NSMutableArray *carCXWYMutableA;
@property(nonatomic, strong)NSDictionary   *tireInfo;

@property(nonatomic, assign)BOOL tireStatus; //有无可使用优惠券的轮胎
@property(nonatomic, assign)BOOL couponStatus; //优惠券状态

@end

@implementation SmoothJourneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"畅行无忧";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.buyPassImpededBtn];
    
    [self.buyPassImpededBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.and.right.mas_equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.view.mas_bottom);
        }
        make.height.mas_equalTo(@40);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.view.mas_top);
        make.left.and.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.buyPassImpededBtn.mas_top);
    }];
    
    [self queryCarCxwyInfo];
    [self getFreeChangeTireInfo];
}

- (void)queryCarCxwyInfo{
    
    if ([UserConfig userCarId] == NULL) {
        
        [PublicClass showHUD:@"请添加默认车辆" view:self.view];
    }else{
        
        NSDictionary *queryPostDic = @{@"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]], @"userCarId": [NSString stringWithFormat:@"%@", [UserConfig userCarId]]};
        NSLog(@"%@", queryPostDic);
        NSString *reqJson = [PublicClass convertToJsonData:queryPostDic];
        [JJRequest postRequest:@"userCarInfo/queryCarCxwyInfo" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
            
            NSString *statusStr = [NSString stringWithFormat:@"%@", code];
            NSString *messageStr = [NSString stringWithFormat:@"%@", message];
            if ([statusStr isEqualToString:@"1"]) {
                
                self.couponStatus = YES;
                [self ananysize:data];
            }else if ([statusStr isEqualToString:@"-999"]){
                
                [self alertIsequallyTokenView];
            }else{
                
                [PublicClass showHUD:messageStr view:self.view];
            }
        } failure:^(NSError * _Nullable error) {
            
            NSLog(@"查询用户车辆畅行无忧信息:%@", error);
        }];
    }
}
- (void)ananysize:(NSArray *)dataArray{
    
    for (int i = 0; i<dataArray.count; i++) {
        
        NSDictionary *dataDic = [dataArray objectAtIndex:i];
        CarCXWYInfo *carCXWYInfo = [[CarCXWYInfo alloc] init];
        [carCXWYInfo setValuesForKeysWithDictionary:dataDic];
        [self.carCXWYMutableA addObject:carCXWYInfo];
    }
    [self.tableView reloadData];
    
    if (self.tireStatus && self.couponStatus) {
        
        self.buyPassImpededBtn.enabled = YES;
    }
    
}

//获取前后轮状态
-(void)getFreeChangeTireInfo{
    
    NSDictionary *getCarDic = @{@"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]], @"userCarId":[NSString stringWithFormat:@"%@", [UserConfig userCarId]]};
    NSString *reqJson = [PublicClass convertToJsonData:getCarDic];
    
    [JJRequest postRequest:@"getUserChangedShoeNumAnd5Year" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        
        if ([statusStr isEqualToString:@"1"]) {
            
            if (data == NULL || data == nil || [data isEqual:[NSNull null]]) {
//                [PublicClass showHUD:@"无可更换轮胎！" view:self.view];
                return ;
            }
            
            self.tireInfo = data;
            
            self.tireStatus = YES;
            
            if (self.tireStatus && self.couponStatus) {
                
                self.buyPassImpededBtn.enabled = YES;
            }
            
        }else if ([statusStr isEqualToString:@"-999"]){
            
            [self alertIsequallyTokenView];
            
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"免费再换轮胎获取信息错误:%@", error);
    }];
}


-(NSMutableArray *)couponArr{
    
    if (!_couponArr) {
        
        _couponArr = [NSMutableArray array];
    }
    return _couponArr;
}

- (NSMutableArray *)carCXWYMutableA{
    
    if (_carCXWYMutableA == nil) {
        
        _carCXWYMutableA = [[NSMutableArray alloc] init];
    }
    return _carCXWYMutableA;
}

-(NSDictionary *)tireInfo{
    
    if (!_tireInfo) {
        
        _tireInfo = [NSDictionary dictionary];
    }
    
    return _tireInfo;
}

- (UIButton *)buyPassImpededBtn{
    
    if (_buyPassImpededBtn == nil) {
        
        _buyPassImpededBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _buyPassImpededBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _buyPassImpededBtn.layer.cornerRadius = 6.0;
        _buyPassImpededBtn.layer.masksToBounds = YES;
        _buyPassImpededBtn.enabled = NO;
        [_buyPassImpededBtn setTitle:@"使用畅行无忧" forState:UIControlStateNormal];
        [_buyPassImpededBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_buyPassImpededBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [_buyPassImpededBtn addTarget:self action:@selector(chickBuypassImpededBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyPassImpededBtn;
}

-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
       _tableView.editing = YES;
        [_tableView registerClass:[PassImpededTableViewCell class] forCellReuseIdentifier:@"newCXWYCellID"];
    }
    
    return _tableView;
}

- (void)chickBuypassImpededBtn:(UIButton *)button{
    
    if (self.couponArr.count<=0) {
        
        [PublicClass showHUD:@"请选择畅行无忧!" view:self.view];
        return;
    }
    
    NSInteger cxwyTotalNumber = [self.tireInfo[@"fontAmount"] integerValue] + [self.tireInfo[@"rearAmount"] integerValue];
    
    if (self.couponArr.count > cxwyTotalNumber) {
        
        [PublicClass showHUD:[NSString stringWithFormat:@"畅行无忧数量不可超过轮胎数量(%ld个)",(long)cxwyTotalNumber] view:self.view];
        return;
    }
    
    CxwyFreeReplaceViewController *freeReplaceVC = [[CxwyFreeReplaceViewController alloc] init];
    
    freeReplaceVC.tireInfoDic = self.tireInfo;
    freeReplaceVC.cxwyList = self.couponArr;
    [self.navigationController pushViewController:freeReplaceVC animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    PassImpededTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newCXWYCellID" forIndexPath:indexPath];
    
    [cell setdatatoCellViews:[self.carCXWYMutableA objectAtIndex:indexPath.row]];

    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    if (self.carCXWYMutableA.count>0) {
        
        return self.carCXWYMutableA.count;
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.couponArr addObject:self.carCXWYMutableA[indexPath.row]];
    NSLog(@"选中%ld",indexPath.row);
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.couponArr removeObject:self.carCXWYMutableA[indexPath.row]];
    NSLog(@"取消选中%ld",indexPath.row);
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 120.0;
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

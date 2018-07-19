//
//  PassImpededViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/12.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "PassImpededViewController.h"
#import "PassImpededTableViewCell.h"
#import "BuyPassViewController.h"
#import "CarCXWYInfo.h"
#import "DelegateConfiguration.h"

@interface PassImpededViewController ()<UITableViewDelegate, UITableViewDataSource, LoginStatusDelegate>

@property(nonatomic, strong)UITableView *passTableView;
@property(nonatomic, strong)UIImageView *backImageV;
@property(nonatomic, strong)UIButton *buyPassImpededBtn;
@property(nonatomic, strong)NSMutableArray *carCXWYMutableA;

@end

@implementation PassImpededViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (UITableView *)passTableView{
    
    if (_passTableView == nil) {
        
        _passTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height - SafeDistance - 40) style:UITableViewStylePlain];
        _passTableView.delegate = self;
        _passTableView.dataSource = self;
        _passTableView.bounces = NO;
        _passTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _passTableView;
}

- (UIImageView *)backImageV{
    
    if (_backImageV == nil) {
        
        _backImageV = [[UIImageView alloc] initWithFrame:CGRectMake((MAINSCREEN.width - 227)/2, (MAINSCREEN.height - SafeAreaTopHeight - 144)/2, 227, 144)];
        _backImageV.image = [UIImage imageNamed:@"ic_dakongbai"];
    }
    return _backImageV;
}

- (UIButton *)buyPassImpededBtn{
    
    if (_buyPassImpededBtn == nil) {
        
        _buyPassImpededBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _buyPassImpededBtn.frame = CGRectMake(10, MAINSCREEN.height - SafeDistance - 40, MAINSCREEN.width - 20, 34);
        _buyPassImpededBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _buyPassImpededBtn.layer.cornerRadius = 6.0;
        _buyPassImpededBtn.layer.masksToBounds = YES;
        [_buyPassImpededBtn setTitle:@"购买畅行无忧" forState:UIControlStateNormal];
        [_buyPassImpededBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_buyPassImpededBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [_buyPassImpededBtn addTarget:self action:@selector(chickBuypassImpededBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyPassImpededBtn;
}

- (NSMutableArray *)carCXWYMutableA{
    
    if (_carCXWYMutableA == nil) {
        
        _carCXWYMutableA = [[NSMutableArray alloc] init];
    }
    return _carCXWYMutableA;
}

- (void)chickBuypassImpededBtn:(UIButton *)button{
    
    BuyPassViewController *buypassVC = [[BuyPassViewController alloc] init];
    [self.navigationController pushViewController:buypassVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DelegateConfiguration *delegateConfiguration = [DelegateConfiguration sharedConfiguration];
    [delegateConfiguration registerLoginStatusChangedListener:self];
    
    self.title = @"畅行无忧";
    [self addViews];
    [self queryCarCxwyInfo];
    // Do any additional setup after loading the view.
}

- (IBAction)backButtonAction:(id)sender{
    
    DelegateConfiguration *delegateConfiguration = [DelegateConfiguration sharedConfiguration];
    [delegateConfiguration unregisterLoginStatusChangedListener:self];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addViews{
    
    [self.view addSubview:self.passTableView];
    [self.view addSubview:self.backImageV];
    self.backImageV.hidden = YES;
    [self.view addSubview:self.buyPassImpededBtn];
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
                
//                NSLog(@"%@", data);
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
    [_passTableView reloadData];
}

//UITableViewDelegate and UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([self.carCXWYMutableA count] == 0) {
        
        self.backImageV.hidden = NO;
    }else{
        
        self.backImageV.hidden = YES;
    }
    return [self.carCXWYMutableA count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIndentifier = @"reuseIndentifier";
    PassImpededTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIndentifier];
    if (cell == nil) {
        
        cell = [[PassImpededTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIndentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    [cell setdatatoCellViews:[self.carCXWYMutableA objectAtIndex:indexPath.row]];
    return cell;
}

//LoginStatusDelegate
- (void)updateLoginStatus{
    
    [self queryCarCxwyInfo];
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

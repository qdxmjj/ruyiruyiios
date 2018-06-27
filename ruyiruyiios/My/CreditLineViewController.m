//
//  CreditLineViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/21.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "CreditLineViewController.h"
#import "CreditLineCarInfo.h"
#import "CreditLineTableViewCell.h"
#import "DelegateConfiguration.h"

@interface CreditLineViewController ()<UITableViewDelegate, UITableViewDataSource, LoginStatusDelegate>

@property(nonatomic, strong)UITableView *creditTableV;
@property(nonatomic, strong)NSMutableArray *creditCarMutableA;

@end

@implementation CreditLineViewController

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
}

- (UITableView *)creditTableV{
    
    if (_creditTableV == nil) {
        
        _creditTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height - SafeDistance) style:UITableViewStylePlain];
        _creditTableV.backgroundColor = [UIColor clearColor];
        _creditTableV.delegate = self;
        _creditTableV.dataSource = self;
        _creditTableV.bounces = NO;
        _creditTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _creditTableV;
}

- (NSMutableArray *)creditCarMutableA{
    
    if (_creditCarMutableA == nil) {
        
        _creditCarMutableA = [[NSMutableArray alloc] init];
    }
    return _creditCarMutableA;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DelegateConfiguration *delegateConfiguration = [DelegateConfiguration sharedConfiguration];
    [delegateConfiguration registerLoginStatusChangedListener:self];
    
    self.title = @"信用额度";
    [self addViews];
    [self queryCarCreditInfoFromInternet];
    // Do any additional setup after loading the view.
}

- (IBAction)backButtonAction:(id)sender{
    
    DelegateConfiguration *delegateConfiguration = [DelegateConfiguration sharedConfiguration];
    [delegateConfiguration unregisterLoginStatusChangedListener:self];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addViews{
    
    [self.view addSubview:self.creditTableV];
}

- (void)queryCarCreditInfoFromInternet{
    
    NSDictionary *queryPostDic = @{@"userId":[UserConfig user_id]};
    NSString *reqJson = [PublicClass convertToJsonData:queryPostDic];
    [JJRequest postRequest:@"userCarInfo/queryCarCreditInfo" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
//            NSLog(@"%@", data);
            [self analysizeArray:data];
        }else if ([statusStr isEqualToString:@"-999"]){
            
            [self alertIsequallyTokenView];
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"查询用户车辆信用额度:%@", error);
    }];
}

- (void)analysizeArray:(NSArray *)dataArray{
    
    for (int i = 0; i<dataArray.count; i++) {
        
        NSDictionary *dataDic = [dataArray objectAtIndex:i];
        CreditLineCarInfo *creditCarInfo = [[CreditLineCarInfo alloc] init];
        [creditCarInfo setValuesForKeysWithDictionary:dataDic];
        [self.creditCarMutableA addObject:creditCarInfo];
    }
    [self.creditTableV reloadData];
}

//UITableViewDelegate and UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.creditCarMutableA.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIndentifier = @"cell";
    CreditLineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIndentifier];
    if (cell == nil) {
        
        cell = [[CreditLineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIndentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    CreditLineCarInfo *creditCarInfo = self.creditCarMutableA[indexPath.row];
    [cell setdatatoViews:creditCarInfo];
    return cell;
}

//LoginStatusDelegate
- (void)updateLoginStatus{
    
    [self queryCarCreditInfoFromInternet];
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

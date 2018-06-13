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

@interface PassImpededViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *passTableView;
@property(nonatomic, strong)UIButton *buyPassImpededBtn;

@end

@implementation PassImpededViewController

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
}

- (UITableView *)passTableView{
    
    if (_passTableView == nil) {
        
        _passTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height - 104) style:UITableViewStylePlain];
        _passTableView.delegate = self;
        _passTableView.dataSource = self;
        _passTableView.bounces = NO;
        _passTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _passTableView;
}

- (UIButton *)buyPassImpededBtn{
    
    if (_buyPassImpededBtn == nil) {
        
        _buyPassImpededBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _buyPassImpededBtn.frame = CGRectMake(10, MAINSCREEN.height - 104, MAINSCREEN.width - 20, 34);
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

- (void)chickBuypassImpededBtn:(UIButton *)button{
    
    BuyPassViewController *buypassVC = [[BuyPassViewController alloc] init];
    [self.navigationController pushViewController:buypassVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"畅行无忧";
    [self addViews];
//    [self queryCarCxwyInfo];
    // Do any additional setup after loading the view.
}

- (void)addViews{
    
    [self.view addSubview:self.passTableView];
    [self.view addSubview:self.buyPassImpededBtn];
}

- (void)queryCarCxwyInfo{
    
    NSDictionary *queryPostDic = @{@"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]], @"userCarId": [NSString stringWithFormat:@"%@", [UserConfig userCarId]]};
    NSString *reqJson = [PublicClass convertToJsonData:queryPostDic];
    [JJRequest postRequest:@"userCarInfo/queryCarCxwyInfo" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
            NSLog(@"%@", data);
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"查询用户车辆畅行无忧信息:%@", error);
    }];
}

//UITableViewDelegate and UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
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
    [cell setdatatoCellViews];
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

//
//  MyOrderViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/8.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "MyOrderViewController.h"
#import "MyOrderTableViewCell.h"
#import "OrderInfo.h"

@interface MyOrderViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UIView *underBtnView;
@property(nonatomic, strong)NSArray *btnNameArray;
@property(nonatomic, strong)UIButton *tmpBtn;
@property(nonatomic, strong)UITableView *myorderTableV;
@property(nonatomic, strong)NSMutableArray *allMutableA;
@property(nonatomic, strong)NSMutableArray *topayMutableA;
@property(nonatomic, strong)NSMutableArray *todeliverMutableA;
@property(nonatomic, strong)NSMutableArray *toserviceMutableA;
@property(nonatomic, strong)NSMutableArray *completedMutableA;

@end

@implementation MyOrderViewController
@synthesize statusStr;

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
}

- (UIView *)underBtnView{
    
    if (_underBtnView == nil) {
        
        _underBtnView = [[UIView alloc] initWithFrame:CGRectMake(([statusStr integerValue]*MAINSCREEN.width/(_btnNameArray.count)), 40, MAINSCREEN.width/(_btnNameArray.count), 2)];
        _underBtnView.backgroundColor = LOGINBACKCOLOR;
    }
    return _underBtnView;
}

- (UITableView *)myorderTableV{
    
    if (_myorderTableV == nil) {
        
        _myorderTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, MAINSCREEN.width, MAINSCREEN.height - 45 - 64) style:UITableViewStylePlain];
        _myorderTableV.delegate = self;
        _myorderTableV.dataSource = self;
        _myorderTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _myorderTableV;
}

- (NSMutableArray *)allMutableA{
    
    if (_allMutableA == nil) {
        
        _allMutableA = [[NSMutableArray alloc] init];
    }
    return _allMutableA;
}

- (NSMutableArray *)topayMutableA{
    
    if (_topayMutableA == nil) {
        
        _topayMutableA = [[NSMutableArray alloc] init];
    }
    return _topayMutableA;
}

- (NSMutableArray *)todeliverMutableA{
    
    if (_todeliverMutableA == nil) {
        
        _todeliverMutableA = [[NSMutableArray alloc] init];
    }
    return _todeliverMutableA;
}

- (NSMutableArray *)toserviceMutableA{
    
    if (_toserviceMutableA == nil) {
        
        _toserviceMutableA = [[NSMutableArray alloc] init];
    }
    return _toserviceMutableA;
}

- (NSMutableArray *)completedMutableA{
    
    if (_completedMutableA == nil) {
        
        _completedMutableA = [[NSMutableArray alloc] init];
    }
    return _completedMutableA;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    
    _btnNameArray = @[@"全部", @"待支付", @"待发货", @"待服务", @"已完成"];
    [self addStatusBtn:_btnNameArray];
    [self addViews];
    [self getUserGeneralOrderByStateFromInternet:statusStr];
    // Do any additional setup after loading the view.
}

- (void)getUserGeneralOrderByStateFromInternet:(NSString *)status{
    
    NSDictionary *orderPostDic = @{@"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]], @"state":status};
    NSString *reqJsonStr = [PublicClass convertToJsonData:orderPostDic];
    [JJRequest postRequest:@"getUserGeneralOrderByState" params:@{@"reqJson":reqJsonStr, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *codeStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([codeStr isEqualToString:@"1"]) {
            
            YLog(@"%@", data);
            [self analysizeData:data];
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"根据订单状态查询所有订单(轮胎订单)的错误:%@", error);
    }];
}

- (void)analysizeData:(NSArray *)dataArray{
    
    for (int d = 0; d<dataArray.count; d++) {
        
        NSDictionary *dataDic = [dataArray objectAtIndex:d];
        OrderInfo *orderInfo = [[OrderInfo alloc] init];
        [orderInfo setValuesForKeysWithDictionary:dataDic];
        [self.allMutableA addObject:orderInfo];
        if ([orderInfo.orderType isEqualToString:@"0"]) {
            
            if ([orderInfo.orderState isEqualToString:@"5"]) {
                
                [self.topayMutableA addObject:orderInfo];
            }else if ([orderInfo.orderState isEqualToString:@"3"] || [orderInfo.orderState isEqualToString:@"6"]){
                
                [self.completedMutableA addObject:orderInfo];
            }
        }else{
            
            if ([orderInfo.orderState isEqualToString:@"5"]) {
                
                [self.todeliverMutableA addObject:orderInfo];
            }else if ([orderInfo.orderState isEqualToString:@"4"] || [orderInfo.orderState isEqualToString:@"1"] || [orderInfo.orderState isEqualToString:@"7"]){
                
                [self.completedMutableA addObject:orderInfo];
            }else if ([orderInfo.orderState isEqualToString:@"8"]){
                
                [self.topayMutableA addObject:orderInfo];
            }else if ([orderInfo.orderState isEqualToString:@"2"] || [orderInfo.orderState isEqualToString:@"3"] || [orderInfo.orderState isEqualToString:@"6"]){
                
                [self.toserviceMutableA addObject:orderInfo];
            }
        }
    }
    [self.myorderTableV reloadData];
}

- (void)addStatusBtn:(NSArray *)array{
    
    for (int i = 0; i<array.count; i++) {
        
        CGFloat x = (MAINSCREEN.width/array.count)*i;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i == [statusStr intValue]) {
            
            button.selected = YES;
        }
        button.tag = 1000+i;
        button.frame = CGRectMake(x, 0, MAINSCREEN.width/(array.count), 40);
        button.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:TEXTCOLOR64 forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(chickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    UIView *underLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 41, MAINSCREEN.width, 1)];
    underLineView.backgroundColor = [PublicClass colorWithHexString:@"#ececec"];
    [self.view addSubview:underLineView];
}

- (void)chickButton:(UIButton *)button{
 
    //1000--all  1001--topay  1002--todeliver  1003--toservice  1004--completed
    if (_tmpBtn == nil) {
        
        button.selected = YES;
        _tmpBtn = button;
    }else if (_tmpBtn != nil && _tmpBtn == button){
        
        button.selected = YES;
    }else if (_tmpBtn != button && _tmpBtn != nil){
        
        _tmpBtn.selected = NO;
        button.selected = YES;
        _tmpBtn = button;
    }
    statusStr = [NSString stringWithFormat:@"%ld", (button.tag - 1000)];
    self.underBtnView.frame = CGRectMake((button.tag - 1000)*(MAINSCREEN.width/_btnNameArray.count), 40, MAINSCREEN.width/_btnNameArray.count, 2);
    [self.myorderTableV scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [self.myorderTableV reloadData];
//    [self.myorderTableV setContentOffset:CGPointMake(0, 0) animated:NO];
}

- (void)addViews{
    
    [self.view addSubview:self.underBtnView];
    [self.view addSubview:self.myorderTableV];
}

//UITableViewDelegate and UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([statusStr intValue] == 0) {
        
        return self.allMutableA.count;
    }else if ([statusStr intValue] == 1){
        
        return self.topayMutableA.count;
    }else if ([statusStr intValue] == 2){
        
        return self.todeliverMutableA.count;
    }else if ([statusStr intValue] == 3){
        
        return self.toserviceMutableA.count;
    }else{
        
        return self.completedMutableA.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 160.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *myorderCell = @"myorderCell";
    MyOrderTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        
        cell = [[MyOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myorderCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    OrderInfo *orderInfo = [[OrderInfo alloc] init];
    if ([statusStr intValue] == 0) {
        
        orderInfo = [self.allMutableA objectAtIndex:indexPath.row];
    }else if ([statusStr intValue] == 1){
        
        orderInfo = [self.topayMutableA objectAtIndex:indexPath.row];
    }else if ([statusStr intValue] == 2){
        
        orderInfo = [self.todeliverMutableA objectAtIndex:indexPath.row];
    }else if ([statusStr intValue] == 3){
        
        orderInfo = [self.toserviceMutableA objectAtIndex:indexPath.row];
    }else{
        
        orderInfo = [self.completedMutableA objectAtIndex:indexPath.row];
    }
    [cell setCellviewData:orderInfo];
    cell.orderBlock = ^(NSString *buttonName) {
        
        [self jumpControllerView:buttonName];
    };
    return cell;
}

- (void)jumpControllerView:(NSString *)name{
    
    NSLog(@"点击订单:%@", name);
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

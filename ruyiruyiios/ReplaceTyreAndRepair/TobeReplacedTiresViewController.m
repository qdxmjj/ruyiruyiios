//
//  TobeReplacedTiresViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/11.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "TobeReplacedTiresViewController.h"
#import "TobeReplacedTableViewCell.h"
#import "TobeReplaceTireInfo.h"
#import "FirstUpdateViewController.h"
#import "DelegateConfiguration.h"

@interface TobeReplacedTiresViewController ()<UITableViewDelegate, UITableViewDataSource, LoginStatusDelegate>

@property(nonatomic, strong)UITableView *replacedTableV;
@property(nonatomic, strong)UIButton *replaceBtn;
@property(nonatomic, strong)NSMutableArray *replaceTireNumberMutableA;

@end

@implementation TobeReplacedTiresViewController

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
}

- (UITableView *)replacedTableV{
    
    if (_replacedTableV == nil) {
        
        _replacedTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height - SafeDistance - 40) style:UITableViewStylePlain];
        _replacedTableV.bounces = NO;
        _replacedTableV.backgroundColor = [UIColor clearColor];
        _replacedTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _replacedTableV.delegate = self;
        _replacedTableV.dataSource = self;
    }
    return _replacedTableV;
}

- (UIButton *)replaceBtn{
    
    if (_replaceBtn == nil) {
        
        _replaceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _replaceBtn.frame = CGRectMake(10, MAINSCREEN.height - SafeDistance - 40, MAINSCREEN.width - 20, 34);
        _replaceBtn.layer.cornerRadius = 6.0;
        _replaceBtn.layer.masksToBounds = YES;
        _replaceBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        [_replaceBtn setTitle:@"更换轮胎" forState:UIControlStateNormal];
        [_replaceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_replaceBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [_replaceBtn addTarget:self action:@selector(chickReplaceBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _replaceBtn;
}

- (NSMutableArray *)replaceTireNumberMutableA{
    
    if (_replaceTireNumberMutableA == nil) {
        
        _replaceTireNumberMutableA = [[NSMutableArray alloc] init];
    }
    return _replaceTireNumberMutableA;
}

- (void)chickReplaceBtn:(UIButton *)button{
    
    FirstUpdateViewController *firstUpdateVC = [[FirstUpdateViewController alloc] init];
    [self.navigationController pushViewController:firstUpdateVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"待更换轮胎";
    
    DelegateConfiguration *delegateConfiguration = [DelegateConfiguration sharedConfiguration];
    [delegateConfiguration registerLoginStatusChangedListener:self];
    
    [self addViews];
    [self getUnusedShoeOrder];
    // Do any additional setup after loading the view.
}

- (IBAction)backButtonAction:(id)sender{
    
    DelegateConfiguration *delegateConfiguration = [DelegateConfiguration sharedConfiguration];
    [delegateConfiguration unregisterLoginStatusChangedListener:self];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addViews{
    
    [self.view addSubview:self.replacedTableV];
    [self.view addSubview:self.replaceBtn];
}

- (void)getUnusedShoeOrder{
    
    NSDictionary *unUseedPostDic = @{@"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]]};
    NSString *reqJson = [PublicClass convertToJsonData:unUseedPostDic];
    [JJRequest postRequest:@"getUnusedShoeOrder" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
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
        
        NSLog(@"获取该用户未更换的轮胎的错误:%@", error);
    }];
}

- (void)analysizeArray:(NSArray *)dataArray{
    
    for (int i = 0; i<dataArray.count; i++) {
        
        NSDictionary *dataDic = [dataArray objectAtIndex:i];
        TobeReplaceTireInfo *replaceInfo = [[TobeReplaceTireInfo alloc] init];
        [replaceInfo setValuesForKeysWithDictionary:dataDic];
        [self.replaceTireNumberMutableA addObject:replaceInfo];
    }
    [self.replacedTableV reloadData];
}

//UITableViewDelegate and UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.replaceTireNumberMutableA count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 235.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIndentifier = @"cell";
    TobeReplacedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        
        cell = [[TobeReplacedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    TobeReplaceTireInfo *tireInfo = [self.replaceTireNumberMutableA objectAtIndex:indexPath.row];
    [cell setDatatoSubviews:tireInfo];
    return cell;
}

//LoginStatusDelegate
- (void)updateLoginStatus{
    
    [self getUnusedShoeOrder];
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

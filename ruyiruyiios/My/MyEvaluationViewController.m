//
//  MyEvaluationViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/21.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "MyEvaluationViewController.h"
#import "MyEvaluationTableViewCell.h"
#import "MyEvaluationInfo.h"

@interface MyEvaluationViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *myevaluationTableV;
@property(nonatomic, strong)UIImageView *backImageV;
@property(nonatomic, strong)NSMutableArray *evaluationMutableA;

@end

@implementation MyEvaluationViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (UITableView *)myevaluationTableV{
    
    if (_myevaluationTableV == nil) {
        
        _myevaluationTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height - SafeDistance) style:UITableViewStylePlain];
        _myevaluationTableV.bounces = NO;
        _myevaluationTableV.showsVerticalScrollIndicator = NO;
        _myevaluationTableV.showsHorizontalScrollIndicator = NO;
        _myevaluationTableV.delegate = self;
        _myevaluationTableV.dataSource = self;
        _myevaluationTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _myevaluationTableV;
}

- (UIImageView *)backImageV{
    
    if (_backImageV == nil) {
        
        _backImageV = [[UIImageView alloc] initWithFrame:CGRectMake((MAINSCREEN.width - 227)/2, (MAINSCREEN.height - SafeAreaTopHeight - 144)/2, 227, 144)];
        _backImageV.image = [UIImage imageNamed:@"ic_dakongbai"];
    }
    return _backImageV;
}

- (NSMutableArray *)evaluationMutableA{
    
    if (_evaluationMutableA == nil) {
        
        _evaluationMutableA = [[NSMutableArray alloc] init];
    }
    return _evaluationMutableA;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的评价";
    
    [self.view addSubview:self.myevaluationTableV];
    [self.view addSubview:self.backImageV];
    self.backImageV.hidden = YES;
    [self getCommitByConditionFromInternet];
    // Do any additional setup after loading the view.
}

- (void)getCommitByConditionFromInternet{
    
    NSDictionary *getCommitPostDic = @{@"page":@"1", @"rows":@"5", @"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]]};
    NSString *reqJson = [PublicClass convertToJsonData:getCommitPostDic];
    [JJRequest postRequest:@"getCommitByCondition" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
//            NSLog(@"%@", data);
            [self analySize:[data objectForKey:@"rows"]];
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"获取评论错误:%@", error);
    }];
}

- (void)analySize:(NSArray *)dataArray{
    
    for (int i = 0; i<dataArray.count; i++) {
        
        NSDictionary *dic = [dataArray objectAtIndex:i];
        MyEvaluationInfo *evaluation = [[MyEvaluationInfo alloc] init];
        [evaluation setValuesForKeysWithDictionary:dic];
        [self.evaluationMutableA addObject:evaluation];
    }
    [self.myevaluationTableV reloadData];
}

//UITableViewDelegate and UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.evaluationMutableA.count == 0) {
        
        self.backImageV.hidden = NO;
    }else{
        
        self.backImageV.hidden = YES;
    }
    return self.evaluationMutableA.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIndentifier = @"cell";
    MyEvaluationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIndentifier];
    MyEvaluationInfo *info = [self.evaluationMutableA objectAtIndex:indexPath.row];
    if (cell == nil) {
        
        cell = [[MyEvaluationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIndentifier content:info.content imgUrl:@[info.img1Url, info.img2Url, info.img3Url, info.img4Url, info.img5Url]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell setdatatoEvaluationCell:info];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyEvaluationTableViewCell *cell = (MyEvaluationTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.cellHeight;
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

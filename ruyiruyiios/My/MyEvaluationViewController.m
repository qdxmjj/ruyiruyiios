//
//  MyEvaluationViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/21.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "MyEvaluationViewController.h"
#import "MyEvaluationTableViewCell.h"

@interface MyEvaluationViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *myevaluationTableV;

@end

@implementation MyEvaluationViewController

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的评价";
    
    [self.view addSubview:self.myevaluationTableV];
//    [self getCommitByConditionFromInternet];
    // Do any additional setup after loading the view.
}

- (void)getCommitByConditionFromInternet{
    
    NSDictionary *getCommitPostDic = @{@"page":@"1", @"rows":@"5", @"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]]};
    NSString *reqJson = [PublicClass convertToJsonData:getCommitPostDic];
    [JJRequest postRequest:@"getCommitByCondition" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
            NSLog(@"%@", data);
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"获取评论错误:%@", error);
    }];
}

//UITableViewDelegate and UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIndentifier = @"cell";
    MyEvaluationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIndentifier];
    if (cell == nil) {
        
        cell = [[MyEvaluationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIndentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setdatatoEvaluationCell];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 270;
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

//
//  RoadConditionViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/21.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "RoadConditionViewController.h"
#import "RoadConditionTableViewCell.h"
#import "RoadInfo.h"
#import <UIImageView+WebCache.h>
#import "NotofenRoadViewController.h"

@interface RoadConditionViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UILabel *pointLabel;
@property(nonatomic, strong)UITableView *roadTableV;
@property(nonatomic, strong)UIButton *nextBtn;
@property(nonatomic, strong)NSMutableArray *roadMutableArray;
@property(nonatomic, strong)NSMutableArray *selectMutableArray;
@property(nonatomic, strong)NSMutableArray *unselectMutableArray;

@end

@implementation RoadConditionViewController

- (UILabel *)pointLabel{
    
    if (_pointLabel == nil) {
        
        _pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, MAINSCREEN.width - 20, 20)];
        _pointLabel.text = @"您经常行驶的路况";
        _pointLabel.textColor = [UIColor blackColor];
        _pointLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
    }
    return _pointLabel;
}

- (UITableView *)roadTableV{
    
    if (_roadTableV == nil) {
        
        _roadTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, MAINSCREEN.width, MAINSCREEN.height - SafeDistance - 85) style:UITableViewStylePlain];
        _roadTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _roadTableV.bounces = NO;
        _roadTableV.delegate = self;
        _roadTableV.dataSource = self;
    }
    return _roadTableV;
}

- (UIButton *)nextBtn{
    
    if (_nextBtn == nil) {
        
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.frame = CGRectMake(10, MAINSCREEN.height - 35 - SafeDistance, MAINSCREEN.width- 20, 30);
        _nextBtn.layer.cornerRadius = 6.0;
        _nextBtn.layer.masksToBounds = YES;
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(chickNextBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}

- (NSMutableArray *)roadMutableArray{
    
    if (_roadMutableArray == nil) {
        
        _roadMutableArray = [[NSMutableArray alloc] init];
    }
    return _roadMutableArray;
}

- (NSMutableArray *)selectMutableArray{
    
    if (_selectMutableArray == nil) {
        
        _selectMutableArray = [[NSMutableArray alloc] init];
    }
    return _selectMutableArray;
}

- (NSMutableArray *)unselectMutableArray{
    
    if (_unselectMutableArray == nil) {
        
        _unselectMutableArray = [[NSMutableArray alloc] init];
    }
    return _unselectMutableArray;
}

- (void)chickNextBtn{
    
    NSLog(@"被选中的数组:%@", self.selectMutableArray);
    NSLog(@"未选中的数组:%@", self.unselectMutableArray);
    NotofenRoadViewController *notOfenVC = [[NotofenRoadViewController alloc] init];
    notOfenVC.selectMutableA = self.selectMutableArray;
    notOfenVC.unselectMutableA = self.unselectMutableArray;
    notOfenVC.roadMutableArray = self.roadMutableArray;
    [self.navigationController pushViewController:notOfenVC animated:YES];
}

- (void)analysisData:(NSArray *)dataArray{
    
    for (NSDictionary *dataDic in dataArray) {
        
        RoadInfo *roadInfo = [[RoadInfo alloc] init];
        [roadInfo setValuesForKeysWithDictionary:dataDic];
        [self.roadMutableArray addObject:roadInfo];
        [self.unselectMutableArray addObject:roadInfo];
    }
    NSLog(@"拷贝后的数组:%@", self.selectMutableArray);
    [_roadTableV reloadData];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)getNetworkData{
    
    NSDictionary *roadpostDic = @{};
    NSString *roadreqJson = [PublicClass convertToJsonData:roadpostDic];
    [JJRequest postRequest:@"getAllRoad" params:@{@"reqJson":roadreqJson} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"-1"]) {
            
            [PublicClass showHUD:messStr view:self.view];
        }else{
            
            NSLog(@"%@", data);
            [self analysisData:data];
        }
    } failure:^(NSError * _Nullable error) {
        NSLog(@"获取道路信息错误:%@", error);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getNetworkData];
    self.title = @"路况选择";
    [self addViews];
    // Do any additional setup after loading the view.
}

- (void)addViews{
    
    [self.view addSubview:self.pointLabel];
    [self.view addSubview:self.roadTableV];
    [self.view addSubview:self.nextBtn];
}

//tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.roadMutableArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIndentifier = @"cell";
    RoadConditionTableViewCell *roadCell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (roadCell == nil) {
        
        roadCell = [[RoadConditionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        roadCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    RoadInfo *roadInfo = [_roadMutableArray objectAtIndex:indexPath.row];
    [roadCell.pictureImageV sd_setImageWithURL:[NSURL URLWithString:roadInfo.img]];
    roadCell.titleLabel.text = roadInfo.name;
    roadCell.detailLabel.text = roadInfo.road_description;
    return roadCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RoadConditionTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.selectImageV.image isEqual:[UIImage imageNamed:@"未选中"]]) {
        
        cell.selectImageV.image = [UIImage imageNamed:@"对号"];
        [self.selectMutableArray addObject:[self.roadMutableArray objectAtIndex:indexPath.row]];
        [self.unselectMutableArray removeObject:[self.roadMutableArray objectAtIndex:indexPath.row]];
    }else{
        
        cell.selectImageV.image = [UIImage imageNamed:@"未选中"];
        [self.selectMutableArray removeObject:[self.roadMutableArray objectAtIndex:indexPath.row]];
        [self.unselectMutableArray addObject:[self.roadMutableArray objectAtIndex:indexPath.row]];
    }
//    NSLog(@"被选中的数组:%@", self.selectMutableArray);
//    NSLog(@"未选中的数组:%@", self.unselectMutableArray);
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

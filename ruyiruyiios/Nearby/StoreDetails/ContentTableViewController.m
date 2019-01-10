//
//  ContentTableViewController.m
//  TestCommodityInfo
//
//  Created by 小马驾驾 on 2018/5/30.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "ContentTableViewController.h"
#import "ContentTableViewCell.h"
#import "CommodityModel.h"
@interface ContentTableViewController ()

@property(nonatomic,strong)UIImageView *backgroundImgView;

@end

@implementation ContentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.backgroundImgView];
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ContentTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"contentCellID"];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.backgroundImgView.frame = self.tableView.bounds;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.dataArr.count>0) {
        
        self.backgroundImgView.hidden = YES;
        return self.dataArr.count;
    }
    
    self.backgroundImgView.hidden = NO;
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contentCellID" forIndexPath:indexPath];
    
    CommodityModel *model = [[CommodityModel alloc] init];
    
    [model setValuesForKeysWithDictionary:self.dataArr[indexPath.row]];
    
    cell.number = [[self.dataArr[indexPath.row] objectForKey:@"commodityNumber"] integerValue];
    
    [cell setModel:model];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 90.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    
    NSLog(@"点击商品");
}
-(UIImageView *)backgroundImgView{
    
    if (!_backgroundImgView) {
        
        _backgroundImgView = [[UIImageView alloc] init];
        _backgroundImgView.backgroundColor = [UIColor whiteColor];
        [_backgroundImgView setImage:[UIImage imageNamed:@"ic_dakongbai"]];
        _backgroundImgView.contentMode = UIViewContentModeCenter;
    }
    
    return _backgroundImgView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

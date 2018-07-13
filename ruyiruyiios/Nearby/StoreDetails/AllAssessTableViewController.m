//
//  AllAssessTableViewController.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/7.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "AllAssessTableViewController.h"
#import "StoreDetailsCell.h"
#import "StoreDetailsRequest.h"
#import <MJRefresh.h>
#define JJWeakSelf __weak typeof(self) weakSelf = self;

@interface AllAssessTableViewController ()
{
    NSInteger pageNumber;
}

@property(nonatomic,strong)NSMutableArray *dataArr;//数据源

@end

@implementation AllAssessTableViewController

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    pageNumber = 1;

    self.title = @"评价";
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([StoreDetailsCell class]) bundle:nil] forCellReuseIdentifier:@"allAssessCellID"];
    
    //上拉更多
    self.tableView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self loadMoreData];
        
    }];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self loadNewData];
    }];
    
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    bar.width = -20;
    
    self.navigationItem.leftBarButtonItems = @[bar,[self barButtonItemWithRect:CGRectMake(0, 0, 60, 30) image:[UIImage imageNamed:@"返回"] highlighted:nil target:self action:@selector(backButtonAction:)]];

}

- (void)backButtonAction:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)loadNewData{
    
    pageNumber=1;
    self.tableView.mj_footer.hidden = NO;
    [self getAssessWithAll:[NSString stringWithFormat:@"%ld",(long)pageNumber] storeId:self.storeId];
    [self.tableView.mj_header endRefreshing];
    
}

-(void)loadMoreData{
    
    JJWeakSelf
    
    pageNumber +=1;
    [self getAssessWithAll:[NSString stringWithFormat:@"%ld",(long)pageNumber] storeId:self.storeId];
    [weakSelf.tableView.mj_footer endRefreshing];
    
}

-(void)setStoreId:(NSString *)storeId{
    
    _storeId = storeId;
    if (storeId.length>0) {
        
        [self.tableView.mj_header beginRefreshing];
    }
    
}

-(void)getAssessWithAll:(NSString *)number storeId:(NSString *)storeId{
    
    JJWeakSelf
    
    [StoreDetailsRequest getCommitByConditionWithInfo:@{@"page":number,@"rows":@"10",@"storeId":storeId,@"userId":@""} succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
       
        if ( self->pageNumber==1) {
            [self.dataArr removeAllObjects];
        }
        
        [weakSelf.dataArr addObjectsFromArray:[data objectForKey:@"rows"]];
        
        if ([[data objectForKey:@"rows"] count]<10 ||data == nil) {
            
            [weakSelf.tableView.mj_footer setHidden:YES];
        }
        
        [weakSelf.tableView reloadData];
        
    } failure:^(NSError * _Nullable error) {
        
        
    }];
    
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.dataArr.count>0) {
        
        return self.dataArr.count;
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    StoreDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"allAssessCellID" forIndexPath:indexPath];
    StoreAssessModel *model = [[StoreAssessModel alloc] init];
    
    [model setValuesForKeysWithDictionary:self.dataArr[indexPath.row]];
    
    [cell setAssessContentModel:model];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return 195;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return UITableViewAutomaticDimension;
}

-(NSMutableArray *)dataArr{
    
    if (!_dataArr) {
        
        _dataArr = [NSMutableArray array];
    }
    
    
    return _dataArr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIBarButtonItem *)barButtonItemWithRect:(CGRect)frame image:(UIImage *)image highlighted:(UIImage *)imagehigh target:(id)target action:(SEL)action{
    
    CGFloat offset = 0.0f;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:imagehigh forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, button.frame.size.width, button.frame.size.height + offset)];
    [buttonView addSubview:button];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:buttonView];
    return barButton;
}
@end

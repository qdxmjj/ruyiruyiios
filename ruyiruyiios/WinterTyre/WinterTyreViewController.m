//
//  WinterTyreViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/8.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "WinterTyreViewController.h"
#import "YMDetailedServiceViewController.h"

#import "WinterTyreServiceCell.h"
#import "WinterTyreServiceTypeCell.h"
#import "WinterTyreRequeset.h"
#import "WinterTyreModel.h"
#import "DelegateConfiguration.h"

@interface WinterTyreViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, LoginStatusDelegate,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionVIew;

@property(nonatomic,strong)UISearchBar *searchBar;

@property(strong,nonatomic)NSArray *tableViewData;

@property(strong,nonatomic)NSArray *serviceListData;
@end

@implementation WinterTyreViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DelegateConfiguration *delegateConfiguration = [DelegateConfiguration sharedConfiguration];
    [delegateConfiguration registerLoginStatusChangedListener:self];
    self.navigationItem.leftBarButtonItem = nil;
    
    UIView*titleView = [[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width-40,44)];
    
    [titleView addSubview:self.searchBar];
    self.navigationItem.titleView = titleView;
    
    self.tableView.scrollEnabled = NO;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WinterTyreServiceTypeCell class]) bundle:nil] forCellReuseIdentifier:@"WinterTyreServiceTypeCellID"];
    
    [self.collectionVIew registerNib:[UINib nibWithNibName:NSStringFromClass([WinterTyreServiceCell class]) bundle:nil] forCellWithReuseIdentifier:@"WinterTyreServiceCellID"];
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    
    [self tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    WinterTyreServiceTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WinterTyreServiceTypeCellID" forIndexPath:indexPath];
    
    cell.serviceTypeLab.text = self.tableViewData[indexPath.row];

    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WinterTyreServiceTypeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.logoView.backgroundColor = [UIColor colorWithRed:255.f/255.f green:102.f/255.f blue:35.f/255.f alpha:1.f];
    cell.contentView.backgroundColor = [UIColor colorWithRed:235.f/255.f green:235.f/255.f blue:235.f/255.f alpha:1.f];
    cell.logoView.hidden = NO;
    
    [self getServiceListInfo:[NSString stringWithFormat:@"%ld",indexPath.row+2]];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WinterTyreServiceTypeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.logoView.hidden = YES;
}

-(void)getServiceListInfo:(NSString *)serviceTypeID{
    
    NSNumber *serviceID = @([serviceTypeID integerValue]);

    if ([UserConfig user_id] == NULL) {
        
        [self alertIsloginView];
        return;
    }
    
    [WinterTyreRequeset getServrceListWithInfo:@{@"userId":[UserConfig user_id],@"serviceTypeId":serviceID} succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {

        self.serviceListData = data;

        [self.collectionVIew reloadData];
        
    } failure:^(NSError * _Nullable error) {
    }];
    
}


#pragma mark collectionViewDelegate
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    WinterTyreServiceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WinterTyreServiceCellID" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    WinterTyreModel *model = [[WinterTyreModel alloc] init];
    
    [model setValuesForKeysWithDictionary:self.serviceListData[indexPath.row]];
    
    [cell setModel:model];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (self.serviceListData.count>0) {
        
        return self.serviceListData.count;
    }
    
    return 0;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return CGSizeMake((self.collectionVIew.frame.size.width-12)/3, 85);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YMDetailedServiceViewController *detailedServiceVC = [[YMDetailedServiceViewController alloc] init];
    
    NSDictionary *dic = self.serviceListData[indexPath.item];
    
    detailedServiceVC.title = [dic objectForKey:@"name"];
    detailedServiceVC.serviceID = [dic objectForKey:@"id"];
    detailedServiceVC.serviceName = [dic objectForKey:@"name"];
    
    [self.navigationController pushViewController:detailedServiceVC animated:YES];
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if ([searchText length] > 20) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"字数不能超过20" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:alertAction];
        [self presentViewController:alertController animated:nil completion:nil];
        [_searchBar setText:[searchText substringToIndex:20]];
        
        return;
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar resignFirstResponder];
    
    YMDetailedServiceViewController *detailedServiceVC = [[YMDetailedServiceViewController alloc] init];
    
    detailedServiceVC.title = @"搜索商品";
    detailedServiceVC.serviceID = @"";
    detailedServiceVC.serviceName = searchBar.text;
    
    [self.navigationController pushViewController:detailedServiceVC animated:YES];
    
}
-(UISearchBar *)searchBar{
    
    if (!_searchBar) {
        
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-40, 44)];
        _searchBar.placeholder = @"请输入您想搜索的关键字";
        _searchBar.layer.cornerRadius = 15;
        _searchBar.layer.masksToBounds = YES;
        _searchBar.delegate = self;
    }
    return _searchBar;
}

-(NSArray *)tableViewData{
    
    if (!_tableViewData) {
        _tableViewData = @[@"汽车保养",@"美容清洗",@"安装改装",@"轮胎服务"];
    }
    return _tableViewData;
}

-(NSArray *)serviceListData{
    
    if (!_serviceListData) {
        _serviceListData = [NSArray array];
    }
    return _serviceListData;
}


//LoginStatusDelegate
- (void)updateLoginStatus{
    
    [self tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

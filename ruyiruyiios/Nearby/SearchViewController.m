//
//  SearchViewController.m
//  TestOrdersType
//
//  Created by 小马驾驾 on 2018/5/29.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchCollectionViewCell.h"
#import "FJStoreReqeust.h"
#import "SearchRecord.h"
#import "MBProgressHUD+YYM_category.h"
@interface SearchViewController ()<UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UISearchBar *searchBar;

@property(nonatomic,strong)NSMutableArray *dataArr;

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)SearchRecord *record;

@end

@implementation SearchViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView*titleView = [[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width-80,44)];

    [titleView addSubview:self.searchBar];
    self.navigationItem.titleView = titleView;
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 30)];
    
    lab.text = @"历史记录";
    
    [self.view addSubview:lab];
    
    UIButton *delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [delBtn setImage:[UIImage imageNamed:@"ic_delete1"] forState:UIControlStateNormal];
    [delBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [delBtn setFrame:CGRectMake(self.view.frame.size.width-60, 20, 40, 30)];
    [delBtn addTarget:self action:@selector(deleteAllDataArr) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:delBtn];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.minimumLineSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;

    UICollectionView *contentView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-40-64) collectionViewLayout:flowLayout];
    
    [contentView registerNib:[UINib nibWithNibName:NSStringFromClass([SearchCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"searcCollectionCellID"];
    contentView.delegate = self;
    contentView.dataSource = self;
    contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentView];
    self.collectionView = contentView;
    
    
    if (self.dataArr.count>0) {
        
        [self.dataArr removeAllObjects];
    }
    [self.dataArr addObjectsFromArray:[self.record getSearchReacord]];
    
    NSLog(@"%@",self.dataArr);
}

-(void)deleteAllDataArr{
    
    [self.record emptySearchRecord];
    [self.dataArr removeAllObjects];
    [self.collectionView reloadData];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (self.dataArr.count>0) {
        
        return self.dataArr.count;
    }
    
    return 0;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    SearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"searcCollectionCellID" forIndexPath:indexPath];
    cell.contentLab.text = self.dataArr[indexPath.row];
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSLog(@"%@",self.dataArr[indexPath.row]);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return CGSizeMake((self.view.frame.size.width-20-20)/3, 40);
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
    
    [self.record addSearchReacord:searchBar.text];
    
    [self.dataArr addObject:searchBar.text];
    [self.collectionView reloadData];
    
    if ([UserConfig user_id] == NULL) {
        
        [MBProgressHUD showTextMessage:@"请先登录！"];
        return;
    }
    
    NSString *cityName = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentCity"];
    NSString *longitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"longitude"];
    NSString *latitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"latitude"];
    
    [FJStoreReqeust getFJStoreByConditionWithInfo:@{@"page":@"1",@"rows":@"100",@"cityName":cityName,@"storeName":searchBar.text,@"storeType":@"",@"serviceType":@"",@"longitude":longitude,@"latitude":latitude,@"rankType":@"0"} succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if (data !=nil) {
            
            self.searchBlock([data objectForKey:@"storeQuaryResVos"]);
        }
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

-(NSMutableArray *)dataArr{
    
    if (!_dataArr) {
        
        _dataArr = [NSMutableArray array];
    }
    
    return _dataArr;
}

-(UISearchBar *)searchBar{
    
    if (!_searchBar) {
        
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 80, 44)];
        _searchBar.placeholder = @"请输入您想搜索的关键字";
        _searchBar.layer.cornerRadius = 15;
        _searchBar.layer.masksToBounds = YES;
        _searchBar.delegate = self;
    }

    
    return _searchBar;
}

-(SearchRecord *)record{
    
    if (!_record) {
        
        _record = [[SearchRecord alloc] init];
    }
    
    return _record;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

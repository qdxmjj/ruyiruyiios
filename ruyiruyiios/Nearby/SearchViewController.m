//
//  SearchViewController.m
//  TestOrdersType
//
//  Created by 小马驾驾 on 2018/5/29.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()<UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UISearchBar *searchBar;

@property(nonatomic,strong)NSMutableArray *dataArr;

@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.navigationItem.leftBarButtonItem = nil;
//    self.navigationItem.hidesBackButton = YES;
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(popViewController)];
    UIView*titleView = [[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width-80,44)];

    [titleView addSubview:self.searchBar];
    self.navigationItem.titleView = titleView;
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 30)];
    
    lab.text = @"历史记录";
    
    [self.view addSubview:lab];
    
    UIButton *delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [delBtn setTitle:@"删除" forState:UIControlStateNormal];
    [delBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [delBtn setFrame:CGRectMake(self.view.frame.size.width-60, 20, 40, 30)];
    [delBtn addTarget:self action:@selector(deleteAllDataArr) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:delBtn];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.minimumLineSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;

    UICollectionView *contentView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-40-64) collectionViewLayout:flowLayout];
    
    [contentView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"searcCollectionCellID"];
    contentView.delegate = self;
    contentView.dataSource = self;
    contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentView];
    self.collectionView = contentView;
}

-(void)deleteAllDataArr{
    
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
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"searcCollectionCellID" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor redColor];
    
    return cell;
    
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
    }
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self.dataArr addObject:searchBar.text];
    [self.collectionView reloadData];
    NSLog(@"搜索");
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


\

@end

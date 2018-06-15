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
@interface WinterTyreViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionVIew;

@property(strong,nonatomic)NSArray *tableViewData;

@property(strong,nonatomic)NSArray *serviceListData;
@end

@implementation WinterTyreViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = nil;
    
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

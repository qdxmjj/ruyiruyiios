//
//  WinterTyreViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/8.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "WinterTyreViewController.h"
#import "WinterTyreServiceCell.h"
#import "WinterTyreServiceTypeCell.h"
@interface WinterTyreViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionVIew;

@property(strong,nonatomic)NSArray *tableViewData;
@end

@implementation WinterTyreViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = nil;
        
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WinterTyreServiceTypeCell class]) bundle:nil] forCellReuseIdentifier:@"WinterTyreServiceTypeCellID"];
    
    [self.collectionVIew registerNib:[UINib nibWithNibName:NSStringFromClass([WinterTyreServiceCell class]) bundle:nil] forCellWithReuseIdentifier:@"WinterTyreServiceCellID"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    WinterTyreServiceTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WinterTyreServiceTypeCellID" forIndexPath:indexPath];
    
    cell.serviceTypeLab.text = self.tableViewData[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

#pragma mark collectionViewDelegate
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    WinterTyreServiceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WinterTyreServiceCellID" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 20;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return CGSizeMake((self.collectionVIew.frame.size.width-12)/3, 85);
}


-(NSArray *)tableViewData{
    
    if (!_tableViewData) {
        
        _tableViewData = @[@"汽车保养",@"美容清洗",@"安装改装",@"轮胎服务"];
    }
    
    
    return _tableViewData;
}

@end

//
//  StoreDetailsViewController.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/4.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "StoreDetailsViewController.h"
#import "AllAssessTableViewController.h"
#import "StoreDetailsRequest.h"

#import <SDCycleScrollView.h>
#import <Masonry.h>
#import "StoreAssessModel.h"
#import "StoreDetailsModel.h"

#import "StoreDetailsOneCell.h"
#import "StoreDetailsOvervieCell.h"
#import "StoreDetailsPhoneCell.h"
#import "StoreDetailsCell.h"

#import "YMTools.h"
@interface StoreDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray *assessContentArr;

@property(nonatomic,strong)SDCycleScrollView *CycleView;

@property(nonatomic,strong)UITableView *assessTableView;

@property(nonatomic,strong)StoreDetailsModel *storeDetailsModel;

@property(nonatomic,assign)CGFloat tableViewH;

@end

@implementation StoreDetailsViewController

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"门店首页";

    [self.view addSubview:self.assessTableView];
    
    
    [self.assessTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.view.mas_top);
        make.left.and.right.mas_equalTo(self.view);
        
        make.bottom.mas_equalTo(self.view.mas_bottom);
        
    }];
}

-(void)byJumpMapNavigation{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择地图" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *baiduMap = [UIAlertAction actionWithTitle:@"百度地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [YMTools openBaiDuMapWithAddress:self.storeDetailsModel.storeAddress latitude:self.storeDetailsModel.latitude longitude:self.storeDetailsModel.longitude];
        
    }];
    
    UIAlertAction *gaodeuMap = [UIAlertAction actionWithTitle:@"高德地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [YMTools openGaoDeMapWithAddress:self.storeDetailsModel.storeAddress latitude:self.storeDetailsModel.latitude longitude:self.storeDetailsModel.longitude];
        
    }];
    
    UIAlertAction *pingguoMap = [UIAlertAction actionWithTitle:@"苹果自带地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [YMTools openAppleMapWithAddress:self.storeDetailsModel.storeAddress latitude:self.storeDetailsModel.latitude longitude:self.storeDetailsModel.longitude];
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:baiduMap];
    [alert addAction:gaodeuMap];
    [alert addAction:pingguoMap];
    [alert addAction:cancel];

    
    [self presentViewController:alert animated:YES completion:nil];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 3) {
        
        if (self.assessContentArr.count>0) {
            
            return self.assessContentArr.count+1;
        }
        return 1;
    }

    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:{
            
            StoreDetailsOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoreDetailsOneCellID" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setModel:self.storeDetailsModel];
            [cell.pushNavBtn addTarget:self action:@selector(byJumpMapNavigation) forControlEvents:UIControlEventTouchUpInside];
            return cell;
            
        }
            break;
        case 1:{
            
            StoreDetailsPhoneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoreDetailsPhoneCellID" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setModel:self.storeDetailsModel];
            [cell.phoneBtn addTarget:self action:@selector(chickPhoneBtn:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
            break;
        case 2:{
            
            StoreDetailsOvervieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoreDetailsOvervieCellID" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell setModel:self.storeDetailsModel];


            return cell;
        }
       
        default:
            break;
    }
    
    if (indexPath.row == 0) {
        
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"storeDetailsAllAssessCellID" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 100, 40)];
        lab.text = @"门店评价";
        [cell.contentView addSubview:lab];
        
        UIButton *allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [allBtn setFrame:CGRectMake(cell.contentView.frame.size.width-80-16, 0, 80, 40)];
        [allBtn setTitle:@"查看全部" forState:UIControlStateNormal];
        [allBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        [allBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -25, 0, 0)];
        [allBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 75, 0, 0)];
        
        [allBtn setImage:[UIImage imageNamed:@"ic_right"] forState:UIControlStateNormal];
        [allBtn addTarget:self action:@selector(pushAssessViewController) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:allBtn];
        
        return cell;
        
        
    }else{
    
    StoreDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"assessCellID" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    StoreAssessModel *model = [[StoreAssessModel alloc] init];
    
    [model setValuesForKeysWithDictionary:self.assessContentArr[0]];
    
    [cell setAssessContentModel:model];
    
    return cell;
    
    }
}

- (void)chickPhoneBtn:(UIButton *)button{
    
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@", self.storeDetailsModel.storePhone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
            
            return UITableViewAutomaticDimension;
            break;
        case 1:
            
            return 44;
            break;
        case 2:
            
            return 65;

            break;
            
        default:
            break;
    }
    
    if (indexPath.row == 0) {
        
        
        return 40;
    }else{
    
    return UITableViewAutomaticDimension;
    }
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //return的是预估高度
    switch (indexPath.section) {
        case 0:
            
            return 115;
            break;
        case 3:
            
            if (indexPath.row==1) {
                
                return 195;
            }
            break;
        default:
            break;
    }

    return 60;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    

    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    

    
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
}

-(void)pushAssessViewController{
    
    AllAssessTableViewController *allAssessVC = [[AllAssessTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    allAssessVC.storeId = self.storeDetailsModel.storeId;
    
    [self.navigationController pushViewController:allAssessVC animated:YES];
    
}


-(SDCycleScrollView*)CycleView{
    if (_CycleView==nil) {
        
        _CycleView= [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200) imageURLStringsGroup:@[]];
        _CycleView.backgroundColor = [UIColor blackColor];
        _CycleView.infiniteLoop=YES;
        _CycleView.autoScroll=YES;
        _CycleView.showPageControl=YES;
        _CycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _CycleView.pageControlStyle=SDCycleScrollViewPageContolStyleAnimated;
    }

    return _CycleView;
}


-(UITableView *)assessTableView{
    
    if (!_assessTableView) {
        
        _assessTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
        _assessTableView.delegate = self;
        _assessTableView.dataSource = self;
        _assessTableView.tableHeaderView = self.CycleView;
        
        _assessTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        [_assessTableView registerNib:[UINib nibWithNibName:NSStringFromClass([StoreDetailsCell class]) bundle:nil] forCellReuseIdentifier:@"assessCellID"];
        [_assessTableView registerNib:[UINib nibWithNibName:NSStringFromClass([StoreDetailsOneCell class]) bundle:nil] forCellReuseIdentifier:@"StoreDetailsOneCellID"];
        [_assessTableView registerNib:[UINib nibWithNibName:NSStringFromClass([StoreDetailsPhoneCell class]) bundle:nil] forCellReuseIdentifier:@"StoreDetailsPhoneCellID"];
        [_assessTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"storeDetailsAllAssessCellID"];
        [_assessTableView registerNib:[UINib nibWithNibName:NSStringFromClass([StoreDetailsOvervieCell class]) bundle:nil] forCellReuseIdentifier:@"StoreDetailsOvervieCellID"];

    }
    return _assessTableView;
}

-(NSArray *)assessContentArr{
    
    if (!_assessContentArr) {
        
        _assessContentArr = [NSArray array];
    }
    
    return _assessContentArr;
}

-(StoreDetailsModel *)storeDetailsModel{
    
    if (!_storeDetailsModel) {
        
        _storeDetailsModel= [[StoreDetailsModel alloc] init];
    }
    
    
    return _storeDetailsModel;
}

-(void)setStoreID:(NSString *)storeID{
    
    if (storeID == nil ||storeID.length<=0) {
        return;
    }
    NSString *longitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"longitude"];
    NSString *latitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"latitude"];
    
    [StoreDetailsRequest getStoreInfoByStoreIdWithInfo:@{@"storeId":storeID,@"longitude":longitude,@"latitude":latitude} succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {

        if ([data objectForKey:@"store_first_commit"] !=[NSNull null]) {
            
            self.assessContentArr = @[[data objectForKey:@"store_first_commit"]];
            
        }

        [self.CycleView setImageURLStringsGroup:@[[data objectForKey:@"factoryImgUrl"],[data objectForKey:@"indoorImgUrl"],[data objectForKey:@"locationImgUrl"]]];
        
        [self.storeDetailsModel setValuesForKeysWithDictionary:data];
        
        [self.assessTableView reloadData];

        
    } failure:^(NSError * _Nullable error) {
                                                                                                                                                  
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

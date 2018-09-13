//
//  LocationViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/29.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "LocationViewController.h"
#import "LocationTableViewCell.h"
#import "DBRecorder.h"
#import "DelegateConfiguration.h"

@interface LocationViewController ()<UITableViewDelegate, UITableViewDataSource>{
    
    CGFloat headH;
}

@property(nonatomic, strong)NSArray *numberArray;
@property(nonatomic, strong)NSMutableDictionary *cityMutableDic;
@property(nonatomic, strong)UIView *headView;
@property(nonatomic, strong)UIButton *locationBtn;
@property(nonatomic, strong)UITableView *locationTableV;

@end

@implementation LocationViewController
@synthesize current_cityName;

- (NSArray *)numberArray{
    
    if (_numberArray == nil) {
        
        _numberArray = [[NSArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"W", @"S", @"Y", @"Z", nil];
    }
    return _numberArray;
}

- (NSMutableDictionary *)cityMutableDic{
    
    if (_cityMutableDic == nil) {
        
        _cityMutableDic = [[NSMutableDictionary alloc] init];
    }
    return _cityMutableDic;
}

- (UIView *)headView{
    
    if (_headView == nil) {
        
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, headH)];
        UILabel *locationCityName = [[UILabel alloc] initWithFrame:CGRectMake(20, 8, MAINSCREEN.width - 20, 20)];
        locationCityName.text = @"定位城市";
        locationCityName.font = [UIFont fontWithName:TEXTFONT size:20.0];
        locationCityName.textColor = [UIColor blackColor];
        [_headView addSubview:locationCityName];
        [_headView addSubview:self.locationBtn];
        for (int i = 0; i<2; i++) {
            
            CGFloat y = i*70 + 68;
            UIView *underLineView = [[UIView alloc] initWithFrame:CGRectMake(20, y, MAINSCREEN.width - 20, 0.5)];
            underLineView.backgroundColor = [UIColor lightGrayColor];
            [_headView addSubview:underLineView];
        }
        
        UILabel *allCityName = [[UILabel alloc] initWithFrame:CGRectMake(20, 95, MAINSCREEN.width - 20, 20)];
        allCityName.text = @"所有城市";
        allCityName.textColor = [UIColor blackColor];
        allCityName.font = [UIFont fontWithName:TEXTFONT size:20.0];
        allCityName.textAlignment = NSTextAlignmentLeft;
        [_headView addSubview:allCityName];
    }
    return _headView;
}

- (UIButton *)locationBtn{
    
    if (_locationBtn == nil) {
        
        _locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_locationBtn setTitle:current_cityName forState:UIControlStateNormal];
        CGSize btnSize = [PublicClass getLabelSize:_locationBtn.titleLabel fontsize:16.0];
        _locationBtn.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor blackColor]);
        _locationBtn.layer.borderWidth = 1.0;
        _locationBtn.layer.cornerRadius = 2.0;
        _locationBtn.layer.masksToBounds = YES;
        [_locationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_locationBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        _locationBtn.frame = CGRectMake(20, 36, btnSize.width, 20);
        [_locationBtn addTarget:self action:@selector(chickLocationBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _locationBtn;
}

- (void)chickLocationBtn{
    
    DelegateConfiguration *delegateCF = [DelegateConfiguration sharedConfiguration];
    [delegateCF changecityNameNumber:self.locationBtn.titleLabel.text];
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableView *)locationTableV{
    
    if (_locationTableV == nil) {
        
        _locationTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, headH, MAINSCREEN.width, MAINSCREEN.height - SafeDistance - headH) style:UITableViewStylePlain];
        _locationTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _locationTableV.backgroundColor = [UIColor clearColor];
        _locationTableV.delegate = self;
        _locationTableV.dataSource = self;
    }
    return _locationTableV;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    headH = 140.0;
    self.title = @"城市选择";
    [self addView];
    [self getDataFromDB];
    // Do any additional setup after loading the view.
}

- (void)getDataFromDB{
    
    if (self.cityMutableDic.count != 0) {
        
        [self.cityMutableDic removeAllObjects];
    }
    dispatch_queue_t locationQueue = dispatch_queue_create("locationQueue", NULL);
    dispatch_async(locationQueue, ^{
       
        NSArray *l_cityArray = [DBRecorder getProvinceArray:[NSNumber numberWithInt:2]];
        
        if (l_cityArray.count<=0) {
            
            return ;
        }
        
        NSMutableArray *iconMutable = [[NSMutableArray alloc] init];
        NSMutableArray *city_positionMutableA = [[NSMutableArray alloc] init];
        for (int i = 0; i<l_cityArray.count; i++) {
            
            FMDBPosition *p_position = [l_cityArray objectAtIndex:i];
            [city_positionMutableA addObject:p_position];
            if (![iconMutable containsObject:p_position.icon]) {
                
                if (![p_position.icon isEqualToString:@""]) {
                    
                    [iconMutable addObject:p_position.icon];
                }
            }
        }
//        NSLog(@"保存城市icon的数组:%@", iconMutable);
        for (int c = 0; c<iconMutable.count; c++) {
            
            NSString *icon = [iconMutable objectAtIndex:c];
            NSMutableArray *city_nameMutableA = [[NSMutableArray alloc] init];
            for (int p = 0; p<city_positionMutableA.count; p++) {
                
                FMDBPosition *position = [city_positionMutableA objectAtIndex:p];
                if ([icon isEqualToString:position.icon]) {
                    
                    [city_nameMutableA addObject:position.name];
                }
            }
            [self.cityMutableDic setValue:city_nameMutableA forKey:icon];
        }
//        NSLog(@"获取到的第一个字母与城市名对应的字典:%@", self.cityMutableDic);
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self.locationTableV reloadData];
        });
    });
}

- (void)addView{
    
    [self.view addSubview:self.headView];
    [self.view addSubview:self.locationTableV];
}

//UITableViewDelegate and UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    
    return index;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    tableView.sectionIndexColor = LOGINBACKCOLOR;
    tableView.sectionIndexBackgroundColor = [UIColor whiteColor];
    return self.numberArray;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [self.numberArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSString *iconKey = [self.numberArray objectAtIndex:section];
    return [[self.cityMutableDic objectForKey:iconKey] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    NSString *iconKey = [self.numberArray objectAtIndex:section];
    
    if ([self.cityMutableDic.allKeys containsObject:iconKey]) {
        
        if ([[self.cityMutableDic objectForKey:iconKey] count] == 0) {
            
            return 0.0;
        }
    }
        return 30.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, 20)];
    headerView.backgroundColor = [UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:0.1];
    
    UILabel *letterLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, MAINSCREEN.width - 20, 20)];
    letterLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
    letterLabel.textColor = [UIColor blackColor];
    letterLabel.text = [self.numberArray objectAtIndex:section];
    [headerView addSubview:letterLabel];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIndentifier = @"cell";
    LocationTableViewCell *locationCell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (locationCell == nil) {
        
        locationCell = [[LocationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        locationCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSString *iconKey = [self.numberArray objectAtIndex:indexPath.section];
    locationCell.nameLabel.text = [[self.cityMutableDic objectForKey:iconKey] objectAtIndex:indexPath.row];
    return locationCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DelegateConfiguration *delegateCF = [DelegateConfiguration sharedConfiguration];
    NSString *iconKey = [self.numberArray objectAtIndex:indexPath.section];
    NSString *city_nameStr = [[self.cityMutableDic objectForKey:iconKey] objectAtIndex:indexPath.row];
    [delegateCF changecityNameNumber:city_nameStr];
    [self.navigationController popViewControllerAnimated:YES];
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

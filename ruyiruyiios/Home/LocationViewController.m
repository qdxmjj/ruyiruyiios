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
#import <Masonry.h>
#import "PopularCityCell.h"
#import "CurrentCityView.h"

static CGFloat const collectionViewHeight = 50.0; //collectionview的默认高度 一行高度
static CGFloat const headViewAllSubViewsHeight = 25+30+25+25; //headView 所有不可变子视图高度和
static CGFloat const headViewAllSubViewsSpacing = 5+5+5+5+5; //headView 所有子视图间距和

@interface LocationViewController ()<UITableViewDelegate, UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,FoldCountyListDelegate>{
    
    CGFloat headH;
}

@property(nonatomic, strong)NSArray *numberArray;
@property(nonatomic, strong)NSMutableDictionary *cityMutableDic;
@property(nonatomic, strong)UIView *headView;
@property(nonatomic, strong)UIButton *locationBtn;
@property(nonatomic, strong)UITableView *locationTableV;

@property(nonatomic, strong)UILabel *locationCityName;//定位城市
@property(nonatomic, strong)UILabel *popularCityLab;//热门城市
@property(nonatomic, strong)UILabel *allCityNameLab;//热门城市
@property(nonatomic, strong)UICollectionView *popularCollectionView;//热门城市列表
@property(nonatomic, strong)CurrentCityView *currentCityView;//当前选择城市县 视图 最上部视图

@property(nonatomic, strong)NSArray *popularCithArr;//热门成功数组
@property(nonatomic, assign)NSInteger selectCityFID;//当前选择的城市名称

@end

@implementation LocationViewController
@synthesize current_cityName;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    headH = 140.0;
    self.title = @"城市选择";
    
    [self.view addSubview:self.currentCityView];
    [self.view addSubview:self.headView];
    [self.headView addSubview:self.locationCityName];
    [self.headView addSubview:self.locationBtn];
    [self.headView addSubview:self.popularCityLab];
    [self.headView addSubview:self.popularCollectionView];
    [self.headView addSubview:self.allCityNameLab];
    
    [self.view addSubview:self.locationTableV];
    
    [self setSubViewsFrame];
    
    [self getDataFromDB];
}

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

-(NSArray *)popularCithArr{
    
    if (!_popularCithArr) {
        
        _popularCithArr = [NSArray array];
    }
    
    return _popularCithArr;
}

-(UILabel *)locationCityName{
    
    if (!_locationCityName) {
        
        _locationCityName = [[UILabel alloc] init];
        _locationCityName.text = @"定位位置";
    }
    return _locationCityName;
}

-(UILabel *)popularCityLab{
    
    if (!_popularCityLab) {
        
        _popularCityLab = [[UILabel alloc] init];
        _popularCityLab.text = @"热门城市";
    }
    return _popularCityLab;
}

-(UILabel *)allCityNameLab{
    
    if (!_allCityNameLab) {
        
        _allCityNameLab = [[UILabel alloc] init];
        _allCityNameLab.text = @"所有城市";
    }
    return _allCityNameLab;
}

-(CurrentCityView *)currentCityView{
    
    if (!_currentCityView) {
        
        _currentCityView = [[CurrentCityView alloc] init];
        _currentCityView.backgroundColor = [UIColor whiteColor];
        _currentCityView.delegate = self;
    }
    
    return _currentCityView;
}

-(UICollectionView *)popularCollectionView{
    
    if (!_popularCollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _popularCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _popularCollectionView.delegate = self;
        _popularCollectionView.dataSource = self;
        _popularCollectionView.backgroundColor = [UIColor whiteColor];
        [_popularCollectionView registerClass:[PopularCityCell class] forCellWithReuseIdentifier:@"loactionCollectionCellID"];
    }
    
    return _popularCollectionView;
}

-(UIView *)headView{
    
    if (!_headView) {
        
        _headView = [[UIView alloc] init];
        _headView.backgroundColor = [UIColor whiteColor];
    }
    return _headView;
}
- (UIButton *)locationBtn{
    
    if (_locationBtn == nil) {
        
        _locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_locationBtn setTitle:[[NSUserDefaults standardUserDefaults] objectForKey:@"positionCounty"] forState:UIControlStateNormal];
        [_locationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_locationBtn setBackgroundColor:[UIColor colorWithRed:240.f/255.f green:240.f/255.f blue:240.f/255.f alpha:1.f] forState:UIControlStateNormal];
        [_locationBtn addTarget:self action:@selector(chickLocationBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        CAShapeLayer *dottedLineBorder  = [[CAShapeLayer alloc] init];
        dottedLineBorder.frame = CGRectMake(0, 0, (MAINSCREEN.width-32-30)/3, 40);
        [dottedLineBorder setLineWidth:1];
        [dottedLineBorder setStrokeColor:[UIColor colorWithRed:220.f/255.f green:220.f/255.f blue:220.f/255.f alpha:1.f].CGColor];
        [dottedLineBorder setFillColor:[UIColor clearColor].CGColor];
        //        dottedLineBorder.lineDashPattern = @[@10,@20];//10 - 线段长度 ，20 － 线段与线段间距
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:dottedLineBorder.frame];
        dottedLineBorder.path = path.CGPath;
        [_locationBtn.layer addSublayer:dottedLineBorder];
    }
    return _locationBtn;
}
- (UITableView *)locationTableV{
    
    if (_locationTableV == nil) {
        
        _locationTableV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _locationTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _locationTableV.backgroundColor = [UIColor clearColor];
        _locationTableV.delegate = self;
        _locationTableV.dataSource = self;
    }
    return _locationTableV;
}

-(void)setSubViewsFrame{
    
    [self.currentCityView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.view.mas_top);
        make.left.and.right.mas_equalTo(self.view);
        make.height.mas_equalTo(35);
    }];
    
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.currentCityView.mas_bottom).inset(5);
        make.height.mas_equalTo(headH);
    }];
    
    [self.locationCityName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.headView.mas_top).inset(5);
        make.height.mas_equalTo(25);
        make.left.mas_equalTo(self.headView.mas_left).inset(16);
    }];
    
    [self.locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.locationCityName.mas_bottom).inset(5);
        make.left.mas_equalTo(self.headView.mas_left).inset(21);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo((MAINSCREEN.width-32-30)/3);
    }];
    
    [self.popularCityLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.locationBtn.mas_bottom).inset(5);
        make.left.mas_equalTo(self.headView.mas_left).inset(16);
        make.height.mas_equalTo(@25);
    }];
    
    [self.popularCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.popularCityLab.mas_bottom).inset(5);
        make.left.mas_equalTo(self.headView.mas_left).inset(16);
        make.right.mas_equalTo(self.headView.mas_right).inset(16);
        make.height.mas_equalTo(collectionViewHeight);
    }];
    
    [self.allCityNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.popularCollectionView.mas_bottom).inset(5);
        make.left.mas_equalTo(self.headView.mas_left).inset(16);
        make.height.mas_equalTo(@25);
    }];
    
    //更新父视图高度
    [self.headView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(headViewAllSubViewsHeight+collectionViewHeight+headViewAllSubViewsSpacing);//初始高度 各控件高度 + 间距
    }];
    
    [self.locationTableV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.headView.mas_bottom).inset(15);
        make.left.and.right.mas_equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.view.mas_bottom);
        }
    }];
}

- (void)chickLocationBtn:(UIButton *)sender{
    
    [[NSUserDefaults standardUserDefaults] setObject:sender.titleLabel.text forKey:@"currentCity"];//更新当前位置信息 县

    DelegateConfiguration *delegateCF = [DelegateConfiguration sharedConfiguration];
    [delegateCF changecityNameNumber:self.locationBtn.titleLabel.text];
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)getDataFromDB{
    
    if (self.cityMutableDic.count != 0) {
        
        [self.cityMutableDic removeAllObjects];
    }
    dispatch_queue_t locationQueue = dispatch_queue_create("locationQueue", NULL);
    dispatch_async(locationQueue, ^{
        
        NSArray *l_cityArray = [DBRecorder getProvinceArray:[NSNumber numberWithInt:2]];
        
        if (l_cityArray.count<=0) {  return ;}
        
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
    
    
    [JJRequest postRequest:@"getHotPosition" params:nil success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        self.popularCithArr = (NSArray *)data;
        
        [self.popularCollectionView reloadData];
        
        NSInteger cellCount = self.popularCithArr.count;
        
        //根据个数 更新collectionview的高度
        [self.popularCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo((cellCount/3 + (cellCount % 3 == 0? 0 :1))*collectionViewHeight);
        }];
        
        //更新 headView高度
        [self.headView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(headViewAllSubViewsHeight+((cellCount/3 + (cellCount % 3 == 0? 0:1)) * collectionViewHeight)+headViewAllSubViewsSpacing);
        }];
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

#pragma mark FoldCountyListDelegate 切换县区
-(void)refreshSuperViewFrameWithStatus:(BOOL)status{
    //根据数据 来刷新 视图高度
    NSArray *newCountyArr = [self inquireCountyListWithCityID:[UserConfig selectCityName]];
    
    if (status) {
        
        self.currentCityView.dataList = newCountyArr;
        [self.currentCityView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(35+collectionViewHeight*(newCountyArr.count/3 + (newCountyArr.count % 3 == 0? 0:1)));
        }];
    }else{
        
        self.currentCityView.dataList = @[];
        [self.currentCityView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(35);
        }];
    }
}
#pragma mark FoldCountyListDelegate 选择区的回调
-(void)selectCurrentWithName:(NSString *)currentName{
    
    [[NSUserDefaults standardUserDefaults] setObject:currentName forKey:@"currentCity"];//更新 当前县 手动选择
    DelegateConfiguration *delegateCF = [DelegateConfiguration sharedConfiguration];
    [delegateCF changecityNameNumber:currentName];
    [self.navigationController popViewControllerAnimated:YES];
}

//通过城市筛选符合条件的区
-(NSMutableArray *)inquireCountyListWithCityID:(NSString *)selectCity{
    
    NSArray *cityArr = [DBRecorder getProvinceArray:[NSNumber numberWithInt:2]];
    NSArray *countyArr = [DBRecorder getProvinceArray:[NSNumber numberWithInt:3]];
    NSMutableArray *newCountyArr = [NSMutableArray array];
    __block NSInteger positionID;
    
    [cityArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        FMDBPosition *position = obj;
        
        if ([position.name isEqualToString:selectCity]) {
            
            positionID = [position.positionId integerValue];
            *stop = YES;
        }
    }];
    
    for (FMDBPosition *countyPosition in countyArr) {

        if ([countyPosition.fid integerValue] == positionID) {
            
            [newCountyArr addObject:countyPosition];
        }
    }
    return newCountyArr;
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
    
    NSString *iconKey = [self.numberArray objectAtIndex:indexPath.section];
    
    NSString *city_nameStr = [[self.cityMutableDic objectForKey:iconKey] objectAtIndex:indexPath.row];
    
    [UserConfig userDefaultsSetObject:city_nameStr key:@"selectCityName"];//修改当前选择城市名 只做显示用
    
    NSArray *countyArr = [self inquireCountyListWithCityID:city_nameStr];
    
    self.currentCityView.selectCityStr = city_nameStr;
    
    self.currentCityView.viewStatus = YES;
    
    self.currentCityView.dataList = countyArr;
    
    [self.currentCityView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(35+collectionViewHeight*(countyArr.count/3 + (countyArr.count % 3 == 0? 0:1)));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    PopularCityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"loactionCollectionCellID" forIndexPath:indexPath];
    cell.cityNameLab.text = [self.popularCithArr[indexPath.row] objectForKey:@"name"];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (self.popularCithArr.count>0) {
        
        return self.popularCithArr.count;
    }
    return 0;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(collectionView.frame.size.width/3 - 10, 40);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    //间距5 collectionView高度50 cell 高度40
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *popularName = [self.popularCithArr[indexPath.item] objectForKey:@"name"];
    [UserConfig userDefaultsSetObject:popularName key:@"selectCityName"];//修改当前选择的城市名
    NSArray *countyArr = [self inquireCountyListWithCityID:popularName];
    
    self.currentCityView.selectCityStr = popularName;
    self.currentCityView.dataList = countyArr;
    self.currentCityView.viewStatus = YES;
    [self.currentCityView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(35+collectionViewHeight*(countyArr.count/3 + (countyArr.count % 3 == 0? 0:1)));
    }];
    
}

@end

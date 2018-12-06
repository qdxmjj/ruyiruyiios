//
//  SelectBrandViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/19.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "SelectBrandViewController.h"
#import "SelectBrandTableViewCell.h"
#import "SelectSystemViewController.h"
#import "FMDBCarBrand.h"
#import "DBRecorder.h"
#import <UIImageView+WebCache.h>

@interface SelectBrandViewController ()<UITableViewDelegate, UITableViewDataSource>{
    
    CGFloat headH;
}

@property(nonatomic, strong)NSArray *numberArray;
@property(nonatomic, strong)NSMutableDictionary *dataDic;
@property(nonatomic, strong)NSArray *carBrandArray;
@property(nonatomic, strong)UIView *headView;
@property(nonatomic, strong)UITableView *brandNameTableV;

@end

@implementation SelectBrandViewController

- (UIView *)headView{
    
    if (_headView  == nil) {
        
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, headH)];
        _headView.backgroundColor = LOGINBACKCOLOR;
        UIImageView *headImageV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 25, MAINSCREEN.width-40, 70)];
        headImageV.image = [UIImage imageNamed:@"ic_jincheng"];
        [_headView addSubview:headImageV];
    }
    return _headView;
}

- (NSMutableDictionary *)dataDic{
    
    if (_dataDic == nil) {
        
        _dataDic = [[NSMutableDictionary alloc] init];
    }
    return _dataDic;
}

- (NSArray *)numberArray{

    if (_numberArray == nil) {

        _numberArray = [[NSArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T",@"U",@"V",@"W", @"X", @"Y", @"Z", nil];
    }
    return _numberArray;
}

- (UITableView *)brandNameTableV{
    
    if (_brandNameTableV == nil) {
        
        _brandNameTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, headH, MAINSCREEN.width, MAINSCREEN.height - headH - SafeDistance) style:UITableViewStylePlain];
        _brandNameTableV.backgroundColor = [UIColor clearColor];
        _brandNameTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _brandNameTableV.delegate = self;
        _brandNameTableV.dataSource = self;
    }
    return _brandNameTableV;
}

- (void)getDataFromDB{
    
    dispatch_queue_t getAllBrandQueue = dispatch_queue_create("getAllBrandQueue", NULL);
    dispatch_async(getAllBrandQueue, ^{
        
        self.carBrandArray = [DBRecorder getAllBrandData];

        dispatch_async(dispatch_get_main_queue(), ^{
            
            for (int i = 0; i<self.numberArray.count; i++) {
                
                NSString *icon = [self.numberArray objectAtIndex:i];
                NSMutableArray *nameA = [[NSMutableArray alloc] init];
                for (int j = 0; j<self.carBrandArray.count; j++) {
                    
                    FMDBCarBrand *carBrand = [self.carBrandArray objectAtIndex:j];
                    if ([carBrand.icon isEqualToString:icon]) {
                        
                        [nameA addObject:carBrand];
                    }
                }
                [self.dataDic setValue:nameA forKey:icon];
            }
            
            [self.brandNameTableV reloadData];
        });
    });
//    YLog(@"%@",self.carBrandArray);
//    YLog(@"结束生成字典%@", self.dataDic);
//    [_brandNameTableV reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"车型选择";
    headH = 120.0;
    
    [self.view addSubview:self.headView];
    [self.view addSubview:self.brandNameTableV];
    [self getDataFromDB];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    
    return index;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    tableView.sectionIndexColor = LOGINBACKCOLOR;
    tableView.sectionIndexBackgroundColor = [UIColor whiteColor];
    return self.numberArray;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [self.numberArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSString *iconkey = [self.numberArray objectAtIndex:section];
    return [[self.dataDic objectForKey:iconkey] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    NSString *iconKey = [self.numberArray objectAtIndex:section];
    if ([[self.dataDic objectForKey:iconKey] count] == 0) {
        
        return 0.0;
    }else{
        
        return 30.0;
    }
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
    SelectBrandTableViewCell *brandCell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (brandCell == nil) {
        
        brandCell = [[SelectBrandTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        brandCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSString *iconKey = [self.numberArray objectAtIndex:indexPath.section];
    FMDBCarBrand *carBrand = [[self.dataDic objectForKey:iconKey] objectAtIndex:indexPath.row];
//    [brandCell.iconImageV sd_setImageWithURL:[NSURL URLWithString:carBrand.imgUrl]];
    [brandCell.iconImageV sd_setImageWithURL:[NSURL URLWithString:carBrand.imgUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        if (error) {
            
            NSLog(@"加载失败");
            return;
        }
    }];
    brandCell.nameLabel.text = carBrand.name;
    return brandCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *iconKey = [self.numberArray objectAtIndex:indexPath.section];
    FMDBCarBrand *carBrand = [[self.dataDic objectForKey:iconKey] objectAtIndex:indexPath.row];
    SelectSystemViewController *selectSystemVC = [[SelectSystemViewController alloc] init];
    selectSystemVC.btosId = carBrand.brandId;
    [self.navigationController pushViewController:selectSystemVC animated:YES];
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

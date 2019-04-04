//
//  SelectTypeViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/21.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "SelectTypeViewController.h"
#import "SelectSystemTableViewCell.h"
#import "DBRecorder.h"
#import "DelegateConfiguration.h"
#import "MyCarInfoViewController.h"
@interface SelectTypeViewController ()<UITableViewDataSource, UITableViewDelegate>{
    
    CGFloat headH, engineW, engineX, yearW;
}

@property(nonatomic, strong)NSMutableArray *typeVerhicleArray;
@property(nonatomic, strong)UIView *typeheadView;
@property(nonatomic, strong)UILabel *engineLabel;
@property(nonatomic, strong)UILabel *yearLabel;
@property(nonatomic, strong)UILabel *functionLabel;
@property(nonatomic, strong)UITableView *typeTableV;

@end

@implementation SelectTypeViewController
@synthesize typeVerhicleId;
@synthesize typepailiangStr;
@synthesize typeyear;

- (NSMutableArray *)typeVerhicleArray{
    
    if (_typeVerhicleArray == nil) {
        
        _typeVerhicleArray = [[NSMutableArray alloc] init];
    }
    return _typeVerhicleArray;
}

- (UIView *)typeheadView{
    
    if (_typeheadView == nil) {
        
        _typeheadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, headH)];
        _typeheadView.backgroundColor = LOGINBACKCOLOR;
        UIImageView *headImageV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 25, MAINSCREEN.width-40, 70)];
        headImageV.image = [UIImage imageNamed:@"ic_jincheng3"];
        [_typeheadView addSubview:headImageV];
    }
    return _typeheadView;
}

- (UILabel *)engineLabel{
    
    if (_engineLabel == nil) {
        
        _engineLabel = [[UILabel alloc] init];
        _engineLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _engineLabel.textColor = [UIColor redColor];
        _engineLabel.text = typepailiangStr;
        CGSize engineSize = [PublicClass getLabelSize:_engineLabel fontsize:14.0];
        engineW = engineSize.width;
        _engineLabel.frame = CGRectMake(engineX, 5, engineSize.width, 20);
    }
    return _engineLabel;
}

- (UILabel *)yearLabel{
    
    if (_yearLabel == nil) {
        
        _yearLabel = [[UILabel alloc] init];
        _yearLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _yearLabel.textColor = [UIColor redColor];
        _yearLabel.text = [NSString stringWithFormat:@"%@", typeyear];
        CGSize yearSize = [PublicClass getLabelSize:_yearLabel fontsize:14.0];
        yearW = yearSize.width;
        _yearLabel.frame = CGRectMake(engineX+engineW+15+20, 5, yearSize.width, 20);
    }
    return _yearLabel;
}

- (UILabel *)functionLabel{
    
    if (_functionLabel == nil) {
        
        _functionLabel = [[UILabel alloc] initWithFrame:CGRectMake(engineX+engineW+15+20+yearW+15+20, 5, MAINSCREEN.width - (engineX+engineW+15+20+yearW+15), 20)];
        _functionLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _functionLabel.textColor = [UIColor blackColor];
        _functionLabel.text = @"选择车型";
    }
    return _functionLabel;
}

- (UITableView *)typeTableV{
    
    if (_typeTableV == nil) {
        
        _typeTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, headH, MAINSCREEN.width, MAINSCREEN.height - headH - SafeDistance) style:UITableViewStylePlain];
        _typeTableV.backgroundColor = [UIColor clearColor];
        _typeTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _typeTableV.delegate = self;
        _typeTableV.dataSource = self;
    }
    return _typeTableV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getDataFromIntegerNet];
    self.title = @"车型选择";
    headH = 120.0;
    engineX = 20.0;
    [self.view addSubview:self.typeheadView];
    [self.view addSubview:self.typeTableV];
    // Do any additional setup after loading the view.
}

- (void)getDataFromIntegerNet{
    
    NSDictionary *postDic = @{@"verhicleId":[NSString stringWithFormat:@"%@", typeVerhicleId], @"pailiang":typepailiangStr, @"year":[NSString stringWithFormat:@"%@", typeyear]};
    NSString *reqJson = [PublicClass convertToJsonData:postDic];
    [JJRequest postRequest:@"getCarTireInfoByCondition" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
            [self analySize:data];
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"根据verhicleId,排量,年份条件筛选车辆:%@", error);
    }];
}

- (void)analySize:(NSArray *)dataArray{
    
    for (int i = 0; i<dataArray.count; i++) {
        
        NSDictionary *dic = [dataArray objectAtIndex:i];
        FMDBCarTireInfo *carTireInfo = [[FMDBCarTireInfo alloc] init];
        [carTireInfo setValuesForKeysWithDictionary:dic];
        [self.typeVerhicleArray addObject:carTireInfo];
    }
    [self.typeTableV reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.typeVerhicleArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 37.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *yeartableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, 30)];
    yeartableHeaderView.backgroundColor = [UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:0.1];
    [yeartableHeaderView addSubview:self.engineLabel];
    UIImageView *jiantouImageV = [[UIImageView alloc] initWithFrame:CGRectMake(engineX+engineW+15, 10, 6, 10)];
    jiantouImageV.image = [UIImage imageNamed:@"下一步"];
    [yeartableHeaderView addSubview:jiantouImageV];
    [yeartableHeaderView addSubview:self.yearLabel];
    UIImageView *jiantouImageV1 = [[UIImageView alloc] initWithFrame:CGRectMake(engineX+engineW+15+20+yearW+15, 10, 6, 10)];
    jiantouImageV1.image = [UIImage imageNamed:@"下一步"];
    [yeartableHeaderView addSubview:jiantouImageV1];
    [yeartableHeaderView addSubview:self.functionLabel];
    
    return yeartableHeaderView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIndentifier = @"cell";
    SelectSystemTableViewCell *systemCell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (systemCell == nil) {
        
        systemCell = [[SelectSystemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        systemCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    FMDBCarTireInfo *carTireInfo = [self.typeVerhicleArray objectAtIndex:indexPath.row];
    systemCell.nameLabel.text = carTireInfo.name;
    return systemCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DelegateConfiguration *delegateConfiguration = [DelegateConfiguration sharedConfiguration];
    FMDBCarTireInfo *carInfo = [self.typeVerhicleArray objectAtIndex:indexPath.row];
    [delegateConfiguration changeCartypeStatusNumber:carInfo];
    
    for (int i = 0; i<self.navigationController.viewControllers.count; i++) {
        
        if ([[[self.navigationController.viewControllers objectAtIndex:i] class] isEqual:[MyCarInfoViewController class]]) {
            
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:i] animated:YES];
        }
    }
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

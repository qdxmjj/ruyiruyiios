//
//  TireSpecificationViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/24.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "TireSpecificationViewController.h"
#import "DBRecorder.h"

@interface TireSpecificationViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>{
    
    NSString *flatWidth, *wtorStr;
}

@property(nonatomic, strong)UIView *iconView;
@property(nonatomic, strong)UIView *midView;
@property(nonatomic, strong)UIView *bottomView;
@property(nonatomic, strong)UIButton *saveBtn;
@property(nonatomic, strong)UIPickerView *sizePickerV;
@property(nonatomic, strong)NSMutableArray *tireFlatWidthArray;
@property(nonatomic, strong)NSMutableDictionary *tireFlatnessRatioDic;
@property(nonatomic, strong)NSMutableDictionary *tireDiameterDic;
@property(nonatomic, strong)NSMutableArray *tireDiameterArray;

@end

@implementation TireSpecificationViewController

- (UIView *)iconView{
    
    if (_iconView == nil) {
        
        _iconView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, 150)];
        _iconView.backgroundColor = [UIColor whiteColor];
        UIImageView *iconImageV = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, MAINSCREEN.width-30, 130)];
        iconImageV.image = [UIImage imageNamed:@"ic_guige"];
        [_iconView addSubview:iconImageV];
    }
    return _iconView;
}

- (UIView *)midView{
    
    if (_midView == nil) {
        
        _midView = [[UIView alloc] initWithFrame:CGRectMake(0, 150, MAINSCREEN.width, 155)];
        _midView.backgroundColor = [UIColor whiteColor];
        UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, 5)];
        backGroundView.backgroundColor = [UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:0.1];
        [_midView addSubview:backGroundView];
        UILabel *sizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, MAINSCREEN.width - 20, 20)];
        sizeLabel.text = @"轮胎尺寸";
        sizeLabel.textColor = [UIColor blackColor];
        sizeLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        [_midView addSubview:sizeLabel];
    }
    return _midView;
}

- (UIPickerView *)sizePickerV{
    
    if (_sizePickerV == nil) {
        
        _sizePickerV = [[UIPickerView alloc] initWithFrame:CGRectMake(40, 35, MAINSCREEN.width-80, 120)];
        _sizePickerV.showsSelectionIndicator = YES;
        _sizePickerV.dataSource = self;
        _sizePickerV.delegate = self;
    }
    return _sizePickerV;
}

- (NSMutableArray *)tireFlatWidthArray{
    
    if (_tireFlatWidthArray == nil) {
        
        _tireFlatWidthArray = [[NSMutableArray alloc] init];
    }
    return _tireFlatWidthArray;
}

- (NSMutableDictionary *)tireFlatnessRatioDic{
    
    if (_tireFlatnessRatioDic == nil) {
        
        _tireFlatnessRatioDic = [[NSMutableDictionary alloc] init];
    }
    return _tireFlatnessRatioDic;
}

- (NSMutableDictionary *)tireDiameterDic{
    
    if (_tireDiameterDic == nil) {
        
        _tireDiameterDic = [[NSMutableDictionary alloc] init];
    }
    return _tireDiameterDic;
}

- (NSMutableArray *)tireDiameterArray{
    
    if (_tireDiameterArray == nil) {
        
        _tireDiameterArray = [[NSMutableArray alloc] init];
    }
    return _tireDiameterArray;
}

- (UIView *)bottomView{
    
    if (_bottomView == nil) {
        
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 305, MAINSCREEN.width, MAINSCREEN.height - SafeDistance - 305)];
        _bottomView.backgroundColor = [UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:0.1];
    }
    return _bottomView;
}

- (UIButton *)saveBtn{
    
    if (_saveBtn == nil) {
        
        _saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, _bottomView.frame.size.height - 39, MAINSCREEN.width-20, 34)];
        _saveBtn.layer.cornerRadius = 6.0;
        _saveBtn.layer.masksToBounds = YES;
        _saveBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_saveBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(chickSaveBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}

- (void)chickSaveBtn:(UIButton *)button{
    
    NSInteger firstrow = [self.sizePickerV selectedRowInComponent:0];
    NSInteger secondrow = [self.sizePickerV selectedRowInComponent:1];
    NSInteger threerow = [self.sizePickerV selectedRowInComponent:2];
    NSString *resultWidth = [self.tireFlatWidthArray objectAtIndex:firstrow];
    NSString *resultratio = [[self.tireFlatnessRatioDic objectForKey:resultWidth] objectAtIndex:secondrow];
    NSString *resultdiameter = [[self.tireDiameterDic objectForKey:[NSString stringWithFormat:@"%@-%@", resultWidth, resultratio]] objectAtIndex:threerow];
    NSString *resultStr = [NSString stringWithFormat:@"%@/%@R%@", resultWidth, resultratio, resultdiameter];
//    NSLog(@"%@", resultStr);
    self.specificationBlock(resultStr);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDataFromDatabase];
    self.title = @"自选规格";
    [self addView];
    // Do any additional setup after loading the view.
}

- (void)getDataFromDatabase{
    
    NSArray *tiretypeArray = [DBRecorder getAllTiretypeData];
    if (self.tireFlatWidthArray.count != 0) {
        
        [self.tireFlatWidthArray removeAllObjects];
    }
    for (int i = 0; i<tiretypeArray.count; i++) {
        
        FMDBCarTireType *tiretype = [tiretypeArray objectAtIndex:i];
//        NSLog(@"轮胎的胎面宽:%@", tiretype.tireFlatWidth);
        if (![self.tireFlatWidthArray containsObject:tiretype.tireFlatWidth]) {
            
            [self.tireFlatWidthArray addObject:tiretype.tireFlatWidth];
        }
    }
    flatWidth = self.tireFlatWidthArray[0];
//    NSLog(@"%@", flatWidth);
//    NSLog(@"%@",self.tireFlatWidthArray);
    FMDBCarTireType *firstTtype = [[DBRecorder getTiretypeDataByflatWidth:flatWidth] objectAtIndex:0];
    NSString *firstFlatratio = firstTtype.tireFlatnessRatio;
    for (int y = 0; y<self.tireFlatWidthArray.count; y++) {
        
        NSString *t_flatWidth = [self.tireFlatWidthArray objectAtIndex:y];
        NSArray *tiretypeFlatRatioArray = [DBRecorder getTiretypeDataByflatWidth:t_flatWidth];
        NSMutableArray *flatRatioMutableA = [[NSMutableArray alloc] init];
        for (int j = 0; j<tiretypeFlatRatioArray.count; j++) {
            
            FMDBCarTireType *flat_tireType = [tiretypeFlatRatioArray objectAtIndex:j];
            if (![flatRatioMutableA containsObject:flat_tireType.tireFlatnessRatio]) {
                
                [flatRatioMutableA addObject:flat_tireType.tireFlatnessRatio];
            }
        }
        for (int k = 0; k<flatRatioMutableA.count; k++) {
            
            NSString *flatratio = [flatRatioMutableA objectAtIndex:k];
            NSArray *tireDiameterArray = [DBRecorder getTiretypeDataByflatRatio:flatratio];
            NSMutableArray *diameterMutableA = [[NSMutableArray alloc] init];
            NSString *t_wtorStr = [NSString stringWithFormat:@"%@-%@", t_flatWidth, flatratio];
            for (int l = 0; l<tireDiameterArray.count; l++) {
                
                FMDBCarTireType *diameter_tireType = [tireDiameterArray objectAtIndex:l];
                if (![diameterMutableA containsObject:diameter_tireType.tireDiameter]) {
                    
                    [diameterMutableA addObject:diameter_tireType.tireDiameter];
                }
            }
            [self.tireDiameterDic setValue:diameterMutableA forKey:t_wtorStr];
        }
        [self.tireFlatnessRatioDic setValue:flatRatioMutableA forKey:t_flatWidth];
    }
    wtorStr = [NSString stringWithFormat:@"%@-%@", flatWidth, firstFlatratio];
//    NSLog(@"%@", wtorStr);
//    NSLog(@"返回的偏平比字典:%@", self.tireFlatnessRatioDic);
//    NSLog(@"返回的轮胎直径:%@", self.tireDiameterDic);
}

- (void)addView{
    
    [self.view addSubview:self.iconView];
    [self.view addSubview:self.midView];
    [_midView addSubview:self.sizePickerV];
    [self.view addSubview:self.bottomView];
    [_bottomView addSubview:self.saveBtn];
}

//UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component == 0) {
        
        return [self.tireFlatWidthArray count];
    }else if (component == 1){
        
        return [[self.tireFlatnessRatioDic objectForKey:flatWidth] count];
    }else{
        
        return [[self.tireDiameterDic objectForKey:wtorStr] count];
    }
}

//UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    return (MAINSCREEN.width - 80)/3;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component == 0) {
        
        flatWidth = [self.tireFlatWidthArray objectAtIndex:row];
        [self.sizePickerV reloadComponent:1];
//        NSLog(@"胎面宽:%@",flatWidth);
    }else if (component == 1){
        
        wtorStr = [NSString stringWithFormat:@"%@-%@", flatWidth, [[self.tireFlatnessRatioDic objectForKey:flatWidth] objectAtIndex:row]];
//        NSLog(@"第二个字典的键值:%@", wtorStr);
        [self.sizePickerV reloadComponent:2];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component == 0) {
        
        return [self.tireFlatWidthArray objectAtIndex:row];
    }else if (component == 1){
        
        return [[self.tireFlatnessRatioDic objectForKey:flatWidth] objectAtIndex:row];
    }else{
        
        return [[self.tireDiameterDic objectForKey:wtorStr] objectAtIndex:row];
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

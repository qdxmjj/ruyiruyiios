//
//  ChoicePatternViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/30.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "ChoicePatternViewController.h"
#import "DBRecorder.h"
#import "TirePattern.h"
#import "ShoeSpeedLoadResult.h"
#import "ChoicePatternTableViewCell.h"
#import "BuyTireViewController.h"
#import "CodeLoginViewController.h"
#import "DelegateConfiguration.h"
#import "ChoiceTableHeadView.h"

@interface ChoicePatternViewController ()<UITableViewDelegate, UITableViewDataSource, LoginStatusDelegate>

@property(nonatomic, strong)UIView *headView;
@property(nonatomic, strong)UILabel *category_seleLabel;
@property(nonatomic, strong)UITableView *choicePatternTableV;
@property(nonatomic, strong)UIButton *nextBtn;
@property(nonatomic, strong)NSMutableArray *shoeMutableA;
@property(nonatomic, strong)NSMutableDictionary *shoeFlgureNameDic;
@property(nonatomic, strong)ShoeSpeedLoadResult *shoeSpeedLoadResult;
@property(nonatomic, strong)UIButton *choiceTmpBtn;

@end

@implementation ChoicePatternViewController
@synthesize tireSize;
@synthesize fontRearFlag;

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
}

- (UIView *)headView{
    
    if (_headView == nil) {
        
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, 40)];
        _headView.backgroundColor = [PublicClass colorWithHexString:@"#ececec"];
        [_headView addSubview:self.category_seleLabel];
    }
    return _headView;
}

- (UILabel *)category_seleLabel{
    
    if (_category_seleLabel == nil) {
        
        _category_seleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, MAINSCREEN.width - 20, 20)];
        _category_seleLabel.text = @"轮胎花纹类别选择";
        _category_seleLabel.font = [UIFont fontWithName:TEXTFONT size:18.0];
        _category_seleLabel.textColor = TEXTCOLOR64;
    }
    return _category_seleLabel;
}

- (UITableView *)choicePatternTableV{
    
    if (_choicePatternTableV == nil) {
        
        _choicePatternTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, MAINSCREEN.width, MAINSCREEN.height - SafeAreaTopHeight - 40 - 40 - (Height_TabBar - 49)) style:UITableViewStylePlain];
        _choicePatternTableV.delegate = self;
        _choicePatternTableV.dataSource = self;
        _choicePatternTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _choicePatternTableV.bounces = NO;
    }
    return _choicePatternTableV;
}

- (UIButton *)nextBtn{
    
    if (_nextBtn == nil) {
        
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.frame = CGRectMake(10, MAINSCREEN.height - 40 - SafeAreaTopHeight - (Height_TabBar - 49), MAINSCREEN.width - 20, 34);
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _nextBtn.layer.cornerRadius = 4.0;
        _nextBtn.layer.masksToBounds = YES;
        [_nextBtn addTarget:self action:@selector(chickNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}

- (NSMutableArray *)shoeMutableA{
    
    if (_shoeMutableA == nil) {
        
        _shoeMutableA = [[NSMutableArray alloc] init];
    }
    return _shoeMutableA;
}

- (NSMutableDictionary *)shoeFlgureNameDic{
    
    if (_shoeFlgureNameDic == nil) {
        
        _shoeFlgureNameDic = [[NSMutableDictionary alloc] init];
    }
    return _shoeFlgureNameDic;
}

- (ShoeSpeedLoadResult *)shoeSpeedLoadResult{
    
    if (_shoeSpeedLoadResult == nil) {
        
        _shoeSpeedLoadResult = [[ShoeSpeedLoadResult alloc] init];
    }
    return _shoeSpeedLoadResult;
}

- (void)chickNextBtn:(UIButton *)button{
    
//    NSLog(@"%@", self.shoeSpeedLoadResult.price);
    if (self.shoeSpeedLoadResult.price.length == 0) {
        
        [PublicClass showHUD:@"没有选择轮胎" view:self.view];
    }else{
        
        DelegateConfiguration *delegateConfiguration = [DelegateConfiguration sharedConfiguration];
        [delegateConfiguration unregisterLoginStatusChangedListener:self];
        BuyTireViewController *buyTireVC = [[BuyTireViewController alloc] init];
        buyTireVC.shoeSpeedLoadResult = self.shoeSpeedLoadResult;
        NSLog(@"%@", fontRearFlag);
        buyTireVC.fontRearFlag = fontRearFlag;
        [self.navigationController pushViewController:buyTireVC animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择花纹";
    
    DelegateConfiguration *delegateConfiguration = [DelegateConfiguration sharedConfiguration];
    [delegateConfiguration registerLoginStatusChangedListener:self];
    
    [self addView];
    [self getDataFromInternet:tireSize];
    // Do any additional setup after loading the view.
}

- (IBAction)backButtonAction:(id)sender{
    
    DelegateConfiguration *delegateConfiguration = [DelegateConfiguration sharedConfiguration];
    [delegateConfiguration unregisterLoginStatusChangedListener:self];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addView{
    
    [self.view addSubview:self.headView];
    [self.view addSubview:self.choicePatternTableV];
    [self.view addSubview:self.nextBtn];
}

- (void)getDataFromInternet:(NSString *)size{
    
    if ([UserConfig token].length == 0) {
        
        [PublicClass showHUD:@"请登录" view:self.view];
        return;
    }
    NSString *token = [UserConfig token];
    NSString *userID = [NSString stringWithFormat:@"%@", [UserConfig user_id]];
    NSDictionary *postDic = @{@"shoeSize":size, @"userId":userID};
    NSString *reqJson = [PublicClass convertToJsonData:postDic];
    [JJRequest postRequest:@"getShoeBySize" params:@{@"reqJson":reqJson, @"token":token} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
//            NSLog(@"getShoeBySize:%@", data);
            [self analySize:data];
            [self.choicePatternTableV reloadData];
        }else if ([statusStr isEqualToString:@"-999"]){
            
            [self alertIsequallyTokenView];
        }else{
            
            [PublicClass showHUD:messStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"获取各种轮胎信息错误:%@", error);
    }];
}

- (void)analySize:(NSArray *)array{
    
    for (int i = 0; i<array.count; i++) {
        
        NSDictionary *dic = [array objectAtIndex:i];
        TirePattern *tirePattern = [[TirePattern alloc] init];
        [tirePattern setValuesForKeysWithDictionary:dic];
        [self.shoeMutableA addObject:tirePattern];
        NSArray *shoeSpeedLoadResultList = [dic objectForKey:@"shoeSpeedLoadResultList"];
        NSMutableArray *resultListMutableA = [[NSMutableArray alloc] init];
        for (int j = 0; j<shoeSpeedLoadResultList.count; j++) {
            
            NSDictionary *speedLoadDic = [shoeSpeedLoadResultList objectAtIndex:j];
            ShoeSpeedLoadResult *shoeSpeedLoadResult = [[ShoeSpeedLoadResult alloc] init];
            [shoeSpeedLoadResult setValuesForKeysWithDictionary:speedLoadDic];
            [resultListMutableA addObject:shoeSpeedLoadResult];
        }
        [self.shoeFlgureNameDic setValue:resultListMutableA forKey:tirePattern.shoeFlgureName];
    }
}

#pragma mark - TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.shoeMutableA.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_choiceTmpBtn.tag == (1000+section)) {
        
        if (_choiceTmpBtn.selected == YES) {
            
            return 1;
        }else{
            
            return 0;
        }
    }else{
        
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TirePattern *tirePattern = [self.shoeMutableA objectAtIndex:indexPath.section];
    return 300 + [[self.shoeFlgureNameDic objectForKey:tirePattern.shoeFlgureName] count] * 40 + 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cellIdentifier";
    ChoicePatternTableViewCell *choiceCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    TirePattern *tirePattern = [self.shoeMutableA objectAtIndex:indexPath.section];
    if (choiceCell == nil) {
        
        choiceCell = [[ChoicePatternTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier shoeSpeedList:[self.shoeFlgureNameDic objectForKey:tirePattern.shoeFlgureName]];
        choiceCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [choiceCell setTirePattern:tirePattern];
    choiceCell.block = ^(NSInteger i) {

        self.shoeSpeedLoadResult = [[self.shoeFlgureNameDic objectForKey:tirePattern.shoeFlgureName] objectAtIndex:i];
    };
    
    return choiceCell;
}

#pragma mark - YUFoldingTableViewDelegate / optional
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    TirePattern *tirePattern = [self.shoeMutableA objectAtIndex:section];
    return tirePattern.shoeFlgureName;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    TirePattern *tirePattern = [self.shoeMutableA objectAtIndex:section];
    ChoiceTableHeadView *choiceHeadView = [[ChoiceTableHeadView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, 50)];
    choiceHeadView.backgroundColor = [UIColor whiteColor];
    choiceHeadView.tag = 1000 + section;
    choiceHeadView.statusBtn.tag = 1000 + section;
    [choiceHeadView.statusBtn addTarget:self action:@selector(chickStatusBtn:) forControlEvents:UIControlEventTouchUpInside];
    [choiceHeadView setdatatoViews:tirePattern.shoeFlgureName img:@"ic_right"];
    if (_choiceTmpBtn.tag == (1000 + section)) {
        
        if (_choiceTmpBtn.selected == YES) {
            
            [choiceHeadView setbackgroundAndTitleColorAndRightImg:@"1"];
        }else{
            
            [choiceHeadView setbackgroundAndTitleColorAndRightImg:@"0"];
        }
    }else{
        
        [choiceHeadView setbackgroundAndTitleColorAndRightImg:@"0"];
    }
    return choiceHeadView;
}

- (void)chickStatusBtn:(UIButton *)button{
    
    if (_choiceTmpBtn == nil) {

        button.selected = !button.selected;
        _choiceTmpBtn = button;
    }else if (_choiceTmpBtn != nil && _choiceTmpBtn.tag == button.tag){

        _choiceTmpBtn.selected = !_choiceTmpBtn.selected;
    }else if (_choiceTmpBtn.tag != button.tag && _choiceTmpBtn != nil){

        _choiceTmpBtn.selected = NO;
        button.selected = YES;
        _choiceTmpBtn = button;
    }
    [self.choicePatternTableV reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.choicePatternTableV deselectRowAtIndexPath:indexPath animated:YES];
}

//loginStatusDelegate
- (void)updateLoginStatus{
    
    [self getDataFromInternet:tireSize];
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

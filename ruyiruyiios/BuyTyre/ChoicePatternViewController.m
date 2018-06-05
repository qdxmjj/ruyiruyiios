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

@interface ChoicePatternViewController ()<YUFoldingTableViewDelegate, LoginStatusDelegate>

@property(nonatomic, strong)UIView *headView;
@property(nonatomic, strong)UILabel *category_seleLabel;
@property(nonatomic, weak)YUFoldingTableView *foldingTableView;
@property(nonatomic, strong)UIButton *nextBtn;
@property(nonatomic, strong)NSMutableArray *shoeMutableA;
@property(nonatomic, strong)NSMutableDictionary *shoeFlgureNameDic;
@property(nonatomic, strong)ShoeSpeedLoadResult *shoeSpeedLoadResult;

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

- (UIButton *)nextBtn{
    
    if (_nextBtn == nil) {
        
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.frame = CGRectMake(10, MAINSCREEN.height - 104, MAINSCREEN.width - 20, 34);
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
        
        BuyTireViewController *buyTireVC = [[BuyTireViewController alloc] init];
        buyTireVC.shoeSpeedLoadResult = self.shoeSpeedLoadResult;
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
    [self setupFoldingTableView];
    [self.view addSubview:self.nextBtn];
}

- (void)setupFoldingTableView{
    
    YUFoldingTableView *foldingTableView = [[YUFoldingTableView alloc] initWithFrame:CGRectMake(0, 40, MAINSCREEN.width, MAINSCREEN.height - 144)];
    _foldingTableView = foldingTableView;
//    _foldingTableView.bounces = NO;
    _foldingTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _foldingTableView.backgroundColor = [PublicClass colorWithHexString:@"#fafafa"];
    [self.view addSubview:foldingTableView];
    foldingTableView.foldingDelegate = self;
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
            
            NSLog(@"getShoeBySize:%@", data);
            [self analySize:data];
            [self.foldingTableView reloadData];
        }else if ([statusStr isEqualToString:@"-999"]){
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"此用户已在别的地方登录，请重新登录" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"重新登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                CodeLoginViewController *codeLoginVC = [[CodeLoginViewController alloc] init];
                [self.navigationController pushViewController:codeLoginVC animated:YES];
            }];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
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
//    NSLog(@"%@---%@", self.shoeMutableA, self.shoeFlgureNameDic);
}

#pragma mark - YUFoldingTableViewDelegate
- (NSInteger)numberOfSectionForYUFoldingTableView:(YUFoldingTableView *)yuTableView{
    
    return self.shoeMutableA.count;
}

- (NSInteger)yuFoldingTableView:(YUFoldingTableView *)yuTableView numberOfRowsInSection:(NSInteger)section{
    
    TirePattern *tirePattern = [self.shoeMutableA objectAtIndex:section];
    NSString *nameKey = tirePattern.shoeFlgureName;
    return [[self.shoeFlgureNameDic objectForKey:nameKey] count];
}

- (CGFloat)yuFoldingTableView:(YUFoldingTableView *)yuTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TirePattern *tirePattern = [self.shoeMutableA objectAtIndex:indexPath.section];
    return 300 + [[self.shoeFlgureNameDic objectForKey:tirePattern.shoeFlgureName] count] * 40 + 10;
}

- (CGFloat)yuFoldingTableView:(YUFoldingTableView *)yuTableView heightForHeaderInSection:(NSInteger)section{
    
    return 50.0;
}

- (UITableViewCell *)yuFoldingTableView:(YUFoldingTableView *)yuTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cellIdentifier";
    ChoicePatternTableViewCell *choiceCell = [yuTableView dequeueReusableCellWithIdentifier:cellIdentifier];
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
- (NSString *)yuFoldingTableView:(YUFoldingTableView *)yuTableView titleForHeaderInSection:(NSInteger)section{
    
    TirePattern *tirePattern = [self.shoeMutableA objectAtIndex:section];
    return tirePattern.shoeFlgureName;
}

- (void)yuFoldingTableView:(YUFoldingTableView *)yuTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [yuTableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (YUFoldingSectionHeaderArrowPosition)perferedArrowPositionForYUFoldingTableView:(YUFoldingTableView *)yuTableView{
    
    return YUFoldingSectionHeaderArrowPositionRight;
}

- (NSString *)yuFoldingTableView:(YUFoldingTableView *)yuTableView descriptionForHeaderInSection:(NSInteger)section{

    return @"";
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

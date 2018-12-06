//
//  ExtensionCodeViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/20.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "ExtensionCodeViewController.h"
#import "ExtensionHeadView.h"
#import "ExtensionMiddleView.h"
#import "ExtensionBottomView.h"
#import "ExtensionInfo.h"
#import "SharePersonInfo.h"
#import "MyCodeViewController.h"
#import "DelegateConfiguration.h"

#import "JJShare.h"
@interface ExtensionCodeViewController ()<UIScrollViewDelegate, LoginStatusDelegate>

@property(nonatomic, strong)ExtensionInfo *extensionInfo;
@property(nonatomic, strong)NSMutableArray *sharePersonMutableA;
@property(nonatomic, strong)NSString *flageStr;
@property(nonatomic, strong)UIScrollView *mainScrollV;
@property(nonatomic, strong)UIImageView *backImageV;
@property(nonatomic, strong)ExtensionHeadView *extensionHeadView;
@property(nonatomic, strong)ExtensionMiddleView *extensionMiddleView;
@property(nonatomic, strong)ExtensionBottomView *extensionBottomView;

@end

@implementation ExtensionCodeViewController

- (ExtensionInfo *)extensionInfo{
    
    if (_extensionInfo == nil) {
        
        _extensionInfo = [[ExtensionInfo alloc] init];
    }
    return _extensionInfo;
}

- (NSMutableArray *)sharePersonMutableA{
    
    if (_sharePersonMutableA == nil) {
        
        _sharePersonMutableA = [[NSMutableArray alloc] init];
    }
    return _sharePersonMutableA;
}

- (UIScrollView *)mainScrollV{
    
    if (_mainScrollV == nil) {
        
        _mainScrollV = [[UIScrollView alloc] init];
        _mainScrollV.frame = CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height - SafeDistance);
        _mainScrollV.showsVerticalScrollIndicator = NO;
        _mainScrollV.showsHorizontalScrollIndicator = NO;
        _mainScrollV.bounces = NO;
        _mainScrollV.delegate = self;
        _mainScrollV.tag = 2;
        _mainScrollV.scrollsToTop = NO;
    }
    return _mainScrollV;
}

- (UIImageView *)backImageV{
    
    if (_backImageV == nil) {
        
        _backImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, (MAINSCREEN.height - SafeDistance)*8/9)];
        _backImageV.image = [UIImage imageNamed:@"ic_background"];
    }
    return _backImageV;
}

- (ExtensionHeadView *)extensionHeadView{
    
    if (_extensionHeadView == nil) {
        
        _extensionHeadView = [[ExtensionHeadView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, 205)];
        [_extensionHeadView.shareBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [_extensionHeadView.shareBtn addTarget:self action:@selector(chickShareBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _extensionHeadView;
}

- (ExtensionMiddleView *)extensionMiddleView{
    
    if (_extensionMiddleView == nil) {
        
        if (MAINSCREEN.width == 320) {
            
            _extensionMiddleView = [[ExtensionMiddleView alloc] initWithFrame:CGRectMake(80, (MAINSCREEN.height - SafeDistance)*15/16 - 130, MAINSCREEN.width - 95, 95) award:self.extensionInfo.award mode:self.extensionInfo.rule];
        }else{
            
            _extensionMiddleView = [[ExtensionMiddleView alloc] initWithFrame:CGRectMake(80, (MAINSCREEN.height - SafeDistance)*8/9 - 130, MAINSCREEN.width - 95, 120) award:self.extensionInfo.award mode:self.extensionInfo.rule];
        }
//        NSLog(@"%@------%@", self.extensionInfo.award, self.extensionInfo.rule);
        _extensionMiddleView.backgroundColor = [UIColor clearColor];
    }
    return _extensionMiddleView;
}

- (ExtensionBottomView *)extensionBottomView{
    
    if (_extensionBottomView == nil) {
        
        if ([self.flageStr isEqualToString:@"1"]) {
            
            _extensionBottomView = [[ExtensionBottomView alloc] initWithFrame:CGRectMake(0, ((MAINSCREEN.height - SafeDistance)*8/9), MAINSCREEN.width, 90) sharePersons:self.sharePersonMutableA viewFlage:self.flageStr];
        }else{
            
            _extensionBottomView = [[ExtensionBottomView alloc] initWithFrame:CGRectMake(0, ((MAINSCREEN.height - SafeDistance)*8/9), MAINSCREEN.width, (self.sharePersonMutableA.count+1)*30+40) sharePersons:self.sharePersonMutableA viewFlage:self.flageStr];
        }
        _extensionBottomView.backgroundColor = [PublicClass colorWithHexString:@"#fece44"];
    }
    return _extensionBottomView;
}

- (void)chickShareBtn:(UIButton *)button{
    
    [JJShare ShareDescribe:@"分享下载app，注册并添加车辆即赠送二张精致洗车券，购买轮胎，更有精美大礼赠送！" images:@[[UIImage imageNamed:@"icon"]] url:self.extensionInfo.url title:@"如驿如意" type:SSDKContentTypeAuto];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推广有礼";
    DelegateConfiguration *delegateConfiguration = [DelegateConfiguration sharedConfiguration];
    [delegateConfiguration registerLoginStatusChangedListener:self];
    
    [self addRightBtn];
    [self queryShareInfoFromInternet];
    // Do any additional setup after loading the view.
}

- (IBAction)backButtonAction:(id)sender{
    
    DelegateConfiguration *delegateConfiguration = [DelegateConfiguration sharedConfiguration];
    [delegateConfiguration unregisterLoginStatusChangedListener:self];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addRightBtn{
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"ic_erweima"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(chickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIView *rightBtnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rightBtn.frame.size.width, rightBtn.frame.size.height)];
    [rightBtnView addSubview:rightBtn];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtnView];
    self.navigationItem.rightBarButtonItem = barButton;
}

- (void)chickRightBtn:(UIButton *)button{
    
    MyCodeViewController *mycodeVC = [[MyCodeViewController alloc] init];
    mycodeVC.extensionInfo = self.extensionInfo;
    [self.navigationController pushViewController:mycodeVC animated:YES];
}

- (void)queryShareInfoFromInternet{
    
    NSDictionary *shareDic = @{@"userId":[UserConfig user_id]};
    NSString *reqJson = [PublicClass convertToJsonData:shareDic];
    [JJRequest postRequest:@"preferentialInfo/queryShareInfo" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
//            NSLog(@"%@", data);
            [self analysizeData:data];
        }else if ([statusStr isEqualToString:@"-999"]){
            
            [self alertIsequallyTokenView];
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"查询推广信息错误:%@", error);
    }];
}

- (void)analysizeData:(NSDictionary *)dataDic{
    
    [self.extensionInfo setValuesForKeysWithDictionary:dataDic];
    NSArray *shareRelationList = [dataDic objectForKey:@"shareRelationList"];
    for (int i = 0; i<shareRelationList.count; i++) {

        NSDictionary *shareDic = [shareRelationList objectAtIndex:i];
        SharePersonInfo *sharePersionInfo = [[SharePersonInfo alloc] init];
        [sharePersionInfo setValuesForKeysWithDictionary:shareDic];
        [self.sharePersonMutableA addObject:sharePersionInfo];
    }
    if (self.sharePersonMutableA.count == 0) {
        
        self.flageStr = @"1";
    }else{
        
        self.flageStr = @"2";
    }
    [self addViews];
}

- (void)addViews{
    
    [self.view addSubview:self.mainScrollV];
    [_mainScrollV addSubview:self.backImageV];
    [_mainScrollV addSubview:self.extensionHeadView];
    [_mainScrollV addSubview:self.extensionMiddleView];
    [_mainScrollV addSubview:self.extensionBottomView];
    [_mainScrollV setContentSize:CGSizeMake(MAINSCREEN.width, self.extensionBottomView.frame.origin.y+self.extensionBottomView.frame.size.height)];
    [self setdatatoSubViews];
}

- (void)setdatatoSubViews{
    
    [self.extensionHeadView setdatatoViews:self.extensionInfo.invitationCode];
    [self.extensionBottomView setdatatoViews:self.sharePersonMutableA];
}

//LoginStatusDelegate
- (void)updateLoginStatus{
    
    [self queryShareInfoFromInternet];
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

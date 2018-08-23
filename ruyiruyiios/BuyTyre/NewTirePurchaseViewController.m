//
//  NewTirePurchaseViewController.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/8/7.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "NewTirePurchaseViewController.h"
#import "SelectBuyTireInfoViewController.h"
#import "ServiceDescriptionViewController.h"
#import "ReplacementProcessViewController.h"
#import "NewSureOrderViewController.h"

#import "NewTireDetailModel.h"
#import "BuyTireData.h"
#import "MBProgressHUD+YYM_category.h"
#import <SDCycleScrollView.h>

#import "DelegateConfiguration.h"
@interface NewTirePurchaseViewController ()<LoginStatusDelegate>

@property (weak, nonatomic) IBOutlet UILabel *tirePriceLab;
@property (weak, nonatomic) IBOutlet UILabel *tireDescriptionLab;

@property (weak, nonatomic) IBOutlet UILabel *standardLab;
@property (weak, nonatomic) IBOutlet UILabel *cxwyLab;

@property (weak, nonatomic) IBOutlet UIButton *selectTireInfoBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectServiceBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectProcessBtn;
@property (weak, nonatomic) IBOutlet SDCycleScrollView *scycleScrollView;

@property(nonatomic,strong)NSMutableArray *dataArr;

@property(nonatomic,assign)NSInteger tireNumber;//轮胎数量

@property(nonatomic,assign)NSInteger cxwyNumber;//畅行无忧数量

@property(nonatomic,assign)NSInteger cxwyPrice;//畅行无忧单价

@property(nonatomic,strong)BuyTireData *buyTireData;

@property(nonatomic,assign)NSInteger    shoeID;//轮胎iD

@property(nonatomic,copy)NSString *remainYear;//服务年限

@property(nonatomic,copy)  NSString     *speedLevelStr;//速度级别

@property(nonatomic,copy)  NSString     *imgURL;

@end

@implementation NewTirePurchaseViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.hidden = NO;
    
    DelegateConfiguration *delegateCF = [DelegateConfiguration sharedConfiguration];
    [delegateCF unregisterLoginStatusChangedListener:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"轮胎购买";
   
    DelegateConfiguration *delegateCF = [DelegateConfiguration sharedConfiguration];
    [delegateCF registerLoginStatusChangedListener:self];
}

#pragma mark loginStatus delegate
- (void)updateLoginStatus{

    
    [self getNewTireInfo:self.tireSize];
}


-(void)setTireSize:(NSString *)tireSize{
    
    _tireSize = tireSize;

    [self getNewTireInfo:tireSize];
}

-(void)getNewTireInfo:(NSString *)tireSize{
    
    
    if ([UserConfig token].length == 0) {
        
        [PublicClass showHUD:@"请登录" view:self.view];
        return;
    }
    
    NSDictionary *params = @{@"shoeSize":tireSize,@"userId":[UserConfig user_id],@"userCarId":[UserConfig userCarId]};
    
    [MBProgressHUD showWaitMessage:@"正在获取..." showView:self.view];
    
    [JJRequest postRequest:@"/order/getShoeBySize" params:@{@"reqJson":[PublicClass convertToJsonData:params],@"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        [MBProgressHUD hideWaitViewAnimated:self.view];
        
        //没有轮胎型号
        
        //
        if ([data isEqual:[NSNull null]] || [data isEqualToArray:@[]]) {
            
            [self.navigationController popViewControllerAnimated:YES];
            [MBProgressHUD showTextMessage:@"如驿如意：此轮胎暂未上线"];
            return ;
        }
        
        
        
        if ([code longLongValue] == -999) {
            
            [self alertIsequallyTokenView];
        }
        if ([code longLongValue] == 1){
            
            if (self.dataArr.count>0) {
                
                [self.dataArr removeAllObjects];
            }
            
            [self.dataArr addObjectsFromArray:data];
            
            //首次进入页面 默认显示内容
            
            BuyTireData *bTireData = [[BuyTireData alloc] init];
            [bTireData setValuesForKeysWithDictionary:[data[0] objectForKey:@"shoeDetailResult"]];
            
            self.tireDescriptionLab.text = bTireData.detailStr;
            
            self.scycleScrollView.imageURLStringsGroup = @[bTireData.shoeDownImg,bTireData.shoeLeftImg,bTireData.shoeMiddleImg,bTireData.shoeRightImg,bTireData.shoeUpImg];
            
            NSString *mini = [[[data[0] objectForKey:@"shoeSpeedLoadResultList"][0] objectForKey:@"priceMap"] objectForKey:@"1"];
            
            NSString *max = [[[data[0] objectForKey:@"shoeSpeedLoadResultList"][0] objectForKey:@"priceMap"] objectForKey:@"15"];
            
            self.tirePriceLab.text = [NSString stringWithFormat:@"¥%@ - %@",mini,max];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
    
    
}

-(NSMutableArray *)dataArr{
    
    if (!_dataArr) {
        
        
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

-(BuyTireData *)buyTireData{
    
    if (!_buyTireData) {
        _buyTireData = [[BuyTireData alloc] init];
    }
    return _buyTireData;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)BuyNow:(UIButton *)sender{
    
    if (self.tireNumber <=0) {
        
        [PublicClass showHUD:@"最少选择一条轮胎！" view:self.view];
        return;
    }
    
    if ([self.remainYear isEqualToString:@"0"]) {
        
        [PublicClass showHUD:@"年限最少为1年" view:self.view];
        return;
    }
    
    NewSureOrderViewController *newSureOrderVC = [[NewSureOrderViewController alloc] init];
    newSureOrderVC.buyTireData = self.buyTireData;
    newSureOrderVC.tireCount = [NSString stringWithFormat:@"%ld",self.tireNumber];
    newSureOrderVC.fontRearFlag = self.fontRearFlag;
    newSureOrderVC.tirePrice = [self.tirePriceLab.text  stringByReplacingOccurrencesOfString:@"¥" withString:@""];
    newSureOrderVC.cxwyCount = [NSString stringWithFormat:@"%ld",self.cxwyNumber];
    newSureOrderVC.cxwyPrice = [NSString stringWithFormat:@"%ld",self.cxwyPrice];
    newSureOrderVC.shoeID = [NSString stringWithFormat:@"%ld",self.shoeID];
    newSureOrderVC.serviceYear = self.remainYear;
    newSureOrderVC.speedLevelStr = self.speedLevelStr;
    newSureOrderVC.tireImgURL = self.imgURL;
    [self.navigationController pushViewController:newSureOrderVC animated:YES];
}
- (IBAction)selectBuyTireInfoEvent:(UIButton *)sender {
    
    if (self.dataArr.count<=0) {
        
        [PublicClass showHUD:@"车辆信息获取失败，请重试！" view:self.view];
        return;
    }
    
    SelectBuyTireInfoViewController *pView = [[SelectBuyTireInfoViewController alloc] init];
    
    pView.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    pView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    pView.patternArr = self.dataArr;
    
    pView.service_end_date = self.service_end_date;

    pView.service_year_length = self.service_year_length;
    
    pView.service_year = self.service_year;
    
    pView.tireNumber = @(self.tireNumber);
    
    pView.cxwuNumber = @(self.cxwyNumber);
    
    JJWeakSelf
    
    pView.selectTireInfoBlock = ^(NSString *tirePrice, NSString *tireInfo, NSString *tireNumber, NSString *cxwyNumber, NSString *cxwyPrice, BuyTireData *buyTireData, NSString *shoeID,NSString *remainYear,NSString *imgURL) {
      
        weakSelf.tirePriceLab.text = tirePrice;
        
        weakSelf.standardLab.text = [NSString stringWithFormat:@"规格: %@,%@条",tireInfo,tireNumber];
        
        weakSelf.cxwyLab.text = [NSString stringWithFormat:@"畅行无忧%@次 %@",cxwyNumber,cxwyPrice];
        
        weakSelf.buyTireData = buyTireData;
        
        weakSelf.shoeID = [shoeID integerValue];
        
        weakSelf.remainYear = remainYear;
        
        weakSelf.tireNumber = [tireNumber integerValue];//轮胎数量
        
        weakSelf.cxwyNumber = [cxwyNumber integerValue];//畅行无忧数量
        
        weakSelf.speedLevelStr = [tireInfo componentsSeparatedByString:@","][1];
        
        weakSelf.cxwyPrice = [[cxwyPrice stringByReplacingOccurrencesOfString:@"¥" withString:@""] integerValue];//畅行无忧价格
        
        weakSelf.tireDescriptionLab.text = weakSelf.buyTireData.detailStr;//轮胎名称
        
        weakSelf.imgURL = imgURL;
        
        weakSelf.scycleScrollView.imageURLStringsGroup = @[weakSelf.buyTireData.shoeDownImg,weakSelf.buyTireData.shoeLeftImg,weakSelf.buyTireData.shoeMiddleImg,weakSelf.buyTireData.shoeRightImg,weakSelf.buyTireData.shoeUpImg];
    };
    
    [self presentViewController:pView animated:YES completion:nil];
}
- (IBAction)clickServiceEvent:(UIButton *)sender {
    
    ServiceDescriptionViewController *sdVC = [[ServiceDescriptionViewController alloc] init];
    
    sdVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    sdVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:sdVC animated:YES completion:nil];
    
}
- (IBAction)ReplacementProcessEvent:(UIButton *)sender {
    
    ReplacementProcessViewController *rpVC = [[ReplacementProcessViewController alloc] init];
    
    rpVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    rpVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:rpVC animated:YES completion:nil];
}

@end

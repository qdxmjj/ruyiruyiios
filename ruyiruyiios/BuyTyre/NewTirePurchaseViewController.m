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
@interface NewTirePurchaseViewController ()<selectTireInfoDelegate>

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

@property(nonatomic,assign)NSInteger shoeID;//轮胎iD

@property(nonatomic,copy)NSString *remainYear;//服务年限

@property(nonatomic,copy)NSString *speedLevelStr;//速度级别

@property(nonatomic,copy)NSString *imgURL;

@end

@implementation NewTirePurchaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"轮胎购买";

    self.scycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;
    self.scycleScrollView.backgroundColor = [UIColor whiteColor];
    
}

#pragma mark loginStatus delegate
- (void)updateLoginStatus{

    //切换账号登录 建议返回到主页面重新进入
    //由于前后轮一致 跟前后轮不一致 进入的页面不一样  所以 不适合直接刷新当前页面数据
    //上次账号登录 前后轮不一致  本次登录前后轮一致  会造成 本次登录购买轮胎 是上次登录账号的规格
    
    [self.navigationController popToRootViewControllerAnimated:YES];
//    [self getNewTireInfo:self.tireSize];
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
    
    JJWeakSelf
    
    NSDictionary *params = @{@"shoeSize":tireSize,@"userId":[UserConfig user_id],@"userCarId":[UserConfig userCarId]};
    
    [MBProgressHUD showWaitMessage:@"正在获取..." showView:self.view];
    
    [JJRequest postRequest:@"/order/getShoeBySize" params:@{@"reqJson":[PublicClass convertToJsonData:params],@"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        [MBProgressHUD hideWaitViewAnimated:self.view];
        
        //没有轮胎型号
        
        if ([code longLongValue] == -999) {
            
            [weakSelf alertIsequallyTokenView];
            return ;
        }

        if ([data isEqual:[NSNull null]] || [data isEqualToArray:@[]]) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
            [MBProgressHUD showTextMessage:@"如驿如意：此轮胎暂未上线"];
            return ;
        }
    
        if ([code longLongValue] == 1){
            
            if (weakSelf.dataArr.count>0) {
                
                [weakSelf.dataArr removeAllObjects];
            }
            
            [weakSelf.dataArr addObjectsFromArray:data];
            
            //首次进入页面 默认显示内容
            
            BuyTireData *bTireData = [[BuyTireData alloc] init];
            [bTireData setValuesForKeysWithDictionary:[data[0] objectForKey:@"shoeDetailResult"]];
            
            weakSelf.tireDescriptionLab.text = bTireData.detailStr;
            
            weakSelf.scycleScrollView.imageURLStringsGroup = @[bTireData.shoeDownImg,bTireData.shoeLeftImg,bTireData.shoeMiddleImg,bTireData.shoeRightImg,bTireData.shoeUpImg];
            
            NSString *mini = [[[data[0] objectForKey:@"shoeSpeedLoadResultList"][0] objectForKey:@"priceMap"] objectForKey:@"1"];
            
            NSString *max = [[[data[0] objectForKey:@"shoeSpeedLoadResultList"][0] objectForKey:@"priceMap"] objectForKey:@"15"];
            
            weakSelf.tirePriceLab.text = [NSString stringWithFormat:@"¥%@ - %@",mini,max];
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

-(void)selectTireInfoWithPrice:(NSString *)price tireInfo:(NSString *)tireInfo tireNumber:(NSString *)tireNumber cxwyNumber:(NSString *)cxwyNumber cxwyPrice:(NSString *)cxwyPrice buyTireData:(BuyTireData *)buyTireData shoeID:(NSString *)shoeID remainYear:(NSString *)remainYear imgURL:(NSString *)imgURL{
    
    self.tirePriceLab.text = price;
    
    self.standardLab.text = [NSString stringWithFormat:@"规格: %@,%@条",tireInfo,tireNumber];
    
    self.cxwyLab.text = [NSString stringWithFormat:@"畅行无忧%@次 %@",cxwyNumber,cxwyPrice];
    
    self.buyTireData = buyTireData;
    
    self.shoeID = [shoeID integerValue];
    
    self.remainYear = remainYear;
    
    self.tireNumber = [tireNumber integerValue];//轮胎数量
    
    self.cxwyNumber = [cxwyNumber integerValue];//畅行无忧数量
    
    self.speedLevelStr = [tireInfo componentsSeparatedByString:@","][1];
    
    self.cxwyPrice = [[cxwyPrice stringByReplacingOccurrencesOfString:@"¥" withString:@""] integerValue];//畅行无忧价格
    
    self.tireDescriptionLab.text = self.buyTireData.detailStr;//轮胎名称
    
    self.imgURL = imgURL;
    
    self.scycleScrollView.imageURLStringsGroup = @[self.buyTireData.shoeDownImg,self.buyTireData.shoeLeftImg,self.buyTireData.shoeMiddleImg,self.buyTireData.shoeRightImg,self.buyTireData.shoeUpImg];
}

- (IBAction)BuyNow:(UIButton *)sender{
    
    if (self.tireNumber <=0) {
        
//        [PublicClass showHUD:@"最少选择一条轮胎！" view:self.view];
        
        [self selectBuyTireInfoEvent:sender];
        return;
    }
    
    if ([self.remainYear isEqualToString:@"0"]) {
        
        [PublicClass showHUD:@"年限最少为1年" view:self.view];
        return;
    }
    
    NewSureOrderViewController *newSureOrderVC = [[NewSureOrderViewController alloc] init];
    newSureOrderVC.buyTireData = self.buyTireData;
    newSureOrderVC.tireCount = [NSString stringWithFormat:@"%ld",(long)self.tireNumber];
    newSureOrderVC.fontRearFlag = self.fontRearFlag;
    newSureOrderVC.tirePrice = [self.tirePriceLab.text  stringByReplacingOccurrencesOfString:@"¥" withString:@""];
    newSureOrderVC.cxwyCount = [NSString stringWithFormat:@"%ld",(long)self.cxwyNumber];
    newSureOrderVC.cxwyPrice = [NSString stringWithFormat:@"%ld",(long)self.cxwyPrice];
    newSureOrderVC.shoeID = [NSString stringWithFormat:@"%ld",(long)self.shoeID];
    newSureOrderVC.serviceYear = self.remainYear;
    newSureOrderVC.speedLevelStr = self.speedLevelStr;
    newSureOrderVC.tireImgURL = self.imgURL;
    [self.navigationController pushViewController:newSureOrderVC animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}
- (IBAction)selectBuyTireInfoEvent:(UIButton *)sender {
    
    if (self.dataArr.count<=0) {
        
        [PublicClass showHUD:@"车辆信息获取失败，请重试！" view:self.view];
        return;
    }
    
    SelectBuyTireInfoViewController * pView = [[SelectBuyTireInfoViewController alloc] init];
    
    pView.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    pView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    pView.delegate = self;
    pView.patternArr = self.dataArr;
    
    pView.service_end_date = self.service_end_date;

    pView.service_year_length = self.service_year_length;
    
    pView.service_year = self.service_year;
    
    pView.tireNumber = @(self.tireNumber);
    
    pView.cxwuNumber = @(self.cxwyNumber);
    
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

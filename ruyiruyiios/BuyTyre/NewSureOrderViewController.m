//
//  NewSureOrderViewController.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/8/16.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "NewSureOrderViewController.h"
#import "CashierViewController.h"
#import <UIImageView+WebCache.h>
#import "MBProgressHUD+YYM_category.h"
@interface NewSureOrderViewController ()

@property (weak, nonatomic) IBOutlet UILabel *contactLab;//联系人
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UILabel *carNumberLab;

@property (weak, nonatomic) IBOutlet UIImageView *tireImg;
@property (weak, nonatomic) IBOutlet UILabel *tireInfoLab;

@property (weak, nonatomic) IBOutlet UILabel *tirePriceLab;
@property (weak, nonatomic) IBOutlet UILabel *tireCountLab;
@property (weak, nonatomic) IBOutlet UILabel *cxwyCountLab;
@property (weak, nonatomic) IBOutlet UILabel *tireTotalPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *cxwyTotalPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLab;
@property (weak, nonatomic) IBOutlet UIView *bottomVIew;

@property(nonatomic, strong)ShoeOrderInfo *shoeOrderInfo;

@end

@implementation NewSureOrderViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单确认";

    self.bottomVIew.layer.shadowOffset = CGSizeMake(0, 0);
    
    self.bottomVIew.layer.shadowColor = [UIColor blackColor].CGColor;
    
    self.bottomVIew.layer.shadowOpacity = 0.3;//阴影透明度，默认0
    
    self.bottomVIew.layer.shadowRadius = 5;//阴影半径，默认3
    
    self.bottomVIew.layer.masksToBounds = NO;
    
    self.contactLab.text = self.buyTireData.userName;
    self.phoneLab.text = self.buyTireData.userPhone;
    self.carNumberLab.text = self.buyTireData.platNumber;
    
    self.tireInfoLab.text = [NSString stringWithFormat:@"%@/%@",self.buyTireData.detailStr,self.speedLevelStr];
    self.tireCountLab.text = [NSString stringWithFormat:@"x%@",self.tireCount];
    self.cxwyCountLab.text = [NSString stringWithFormat:@"x%@",self.cxwyCount];
    self.tirePriceLab.text = [NSString stringWithFormat:@"¥%@",self.tirePrice];
    
    self.tireTotalPriceLab.text = [NSString stringWithFormat:@"¥%ld",[self.tireCount integerValue] * [self.tirePrice integerValue]];
    self.cxwyTotalPriceLab.text = [NSString stringWithFormat:@"¥%ld",(long)[self.cxwyPrice integerValue]];

    self.totalPriceLab.text = [NSString stringWithFormat:@"¥%ld",[self.tireCount integerValue] * [self.tirePrice integerValue] + [self.cxwyPrice integerValue]];
    
    [self.tireImg sd_setImageWithURL:[NSURL URLWithString:self.tireImgURL]];
}

- (IBAction)buyCommodityEvent:(UIButton *)sender {
    
    NSString *tireTotalPrice = [NSString stringWithFormat:@"%ld",[self.tireCount integerValue] * [self.tirePrice integerValue]];

    NSString *totalPrice = [NSString stringWithFormat:@"%ld",[self.tireCount integerValue] * [self.tirePrice integerValue] + [self.cxwyPrice integerValue]];

    
    NSDictionary *surePostDic = @{@"shoeId":self.shoeID, @"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]], @"fontRearFlag":self.fontRearFlag, @"amount":self.tireCount, @"shoeName":[NSString stringWithFormat:@"%@/%@",self.buyTireData.detailStr,self.speedLevelStr], @"shoeTotalPrice":tireTotalPrice, @"shoePrice":self.tirePrice, @"cxwyAmount":self.cxwyCount, @"cxwyPrice":self.cxwyPrice, @"cxwyTotalPrice":self.cxwyPrice, @"totalPrice":totalPrice, @"orderImg":self.tireImgURL,@"remainYear":@([self.serviceYear integerValue])};
    
        NSString *reqJsonStr = [PublicClass convertToJsonData:surePostDic];
    
    [MBProgressHUD showWaitMessage:@"正在生成订单..." showView:self.view];
    
    
        [JJRequest postRequest:@"addUserShoeOrder" params:@{@"reqJson":reqJsonStr, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
    
            [MBProgressHUD hideWaitViewAnimated:self.view];
            
            NSString *statusStr = [NSString stringWithFormat:@"%@", code];
            NSString *messageStr = [NSString stringWithFormat:@"%@", message];
            if ([statusStr isEqualToString:@"1"]) {
    
                //            NSLog(@"提交订单获取到的值:%@", data);
    
                [[NSNotificationCenter defaultCenter] postNotificationName:GenerateTireOrderNotice object:nil];
    
                [self.shoeOrderInfo setValuesForKeysWithDictionary:data];
                CashierViewController *cashierVC = [[CashierViewController alloc] init];
                cashierVC.totalPriceStr = [NSString stringWithFormat:@"%@", self.shoeOrderInfo.totalPrice];
                cashierVC.orderNoStr = [NSString stringWithFormat:@"%@", self.shoeOrderInfo.orderNo];
                cashierVC.orderTypeStr = @"0";
                [self.navigationController pushViewController:cashierVC animated:YES];
                self.hidesBottomBarWhenPushed = YES;

            }else{
    
                [PublicClass showHUD:messageStr view:self.view];
            }
    
        } failure:^(NSError * _Nullable error) {
    
            [MBProgressHUD hideWaitViewAnimated:self.view];
            NSLog(@"提交轮胎购买订单错误:%@", error);
        }];
    
}

- (ShoeOrderInfo *)shoeOrderInfo{
    
    if (_shoeOrderInfo == nil) {
        
        _shoeOrderInfo = [[ShoeOrderInfo alloc] init];
    }
    return _shoeOrderInfo;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

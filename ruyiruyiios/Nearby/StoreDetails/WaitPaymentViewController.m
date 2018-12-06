//
//  WaitPaymentViewController.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/28.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "WaitPaymentViewController.h"
#import "NearbyViewController.h"
#import "StoreDetailsRequest.h"
#import "CashierViewController.h"
#import "BuyCommdityCell.h"
#import "MBProgressHUD+YYM_category.h"
#import "StoreDetailsViewController.h"
@interface WaitPaymentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *storeUserNameLab;

@property (weak, nonatomic) IBOutlet UILabel *storePhotoLab;

@property (weak, nonatomic) IBOutlet UILabel *orderTotalPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLab;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *goOnPayingBtn;

@property(nonatomic,strong)NSArray *commodityList;

@property(nonatomic,copy)NSString *orderTotalPrice;

@property(nonatomic,copy)NSString *storeID;
@end

@implementation WaitPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"待支付";
    if ([self.backStatus isEqualToString:@"0"]) {
        
        self.navigationItem.leftBarButtonItem = [self barButtonItemWithRect:CGRectMake(0, 0, 60, 30) image:[UIImage imageNamed:@"返回"] highlighted:nil target:self action:@selector(popNearbyViewController)];
    }

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BuyCommdityCell class]) bundle:nil] forCellReuseIdentifier:@"WaitPaymentViewCellID"];

    [self addRightBtn];
    [self getUserOrderInfo];
}

-(void)popNearbyViewController{
    
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)addRightBtn{
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
    rightBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14];
    [rightBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(chickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIView *rightBtnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rightBtn.frame.size.width, rightBtn.frame.size.height)];
    [rightBtnView addSubview:rightBtn];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtnView];
    self.navigationItem.rightBarButtonItem = barButton;
}

- (void)chickRightBtn:(UIButton *)button{
    
    NSDictionary *cancelPostDic = @{@"orderNo":self.orderNo, @"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]]};
    NSString *reqJson = [PublicClass convertToJsonData:cancelPostDic];
    [JJRequest postRequest:@"cancelStockOrder" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
            if ([self.backStatus isEqualToString:@"0"]) {
                
                self.tabBarController.tabBar.hidden = NO;
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            }else{
                
                [self.navigationController popViewControllerAnimated:YES];
            }

        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"取消购买轮胎订单错误:%@", error);
    }];
}

-(void)getUserOrderInfo{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"正在获取订单信息...";
    hud.mode = MBProgressHUDModeText;
    [hud showAnimated:YES];
    
    [StoreDetailsRequest getUserOrderWithInfo:@{@"orderNo":self.orderNo,@"orderType":self.orderType,@"userId":[UserConfig user_id]} succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
       
        [hud hideAnimated:YES];
       
        if ([code longLongValue]==1) {

            NSLog(@"%@",data);
            self.storeUserNameLab.text = [UserConfig nick];
            self.storeNameLab.text = [data objectForKey:@"storeName"];
            self.storePhotoLab.text = [data objectForKey:@"userPhone"];
            self.orderTotalPriceLab.text = [NSString stringWithFormat:@"¥%@",[data objectForKey:@"orderTotalPrice"]];
            
            self.commodityList = [data objectForKey:@"stockOrderVoList"];
            self.orderTotalPrice = [data objectForKey:@"orderActuallyPrice"];
            self.storeID = [data objectForKey:@"storeId"];
            [self.tableView reloadData];
        }
          
    } failure:^(NSError * _Nullable error) {
        
        [hud hideAnimated:YES];

    }];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.commodityList.count>0) {
        
        return self.commodityList.count;
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BuyCommdityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WaitPaymentViewCellID" forIndexPath:indexPath];
    
    WaitPaymentModel *model = [[WaitPaymentModel alloc] init];
    
    [model setValuesForKeysWithDictionary:self.commodityList[indexPath.row]];
    
    [cell setWaitPaymentModel:model];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 100.5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    return 1.5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1.5;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    return [UIView new];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    return [UIView new];
}

- (IBAction)goOnPayingEvent:(UIButton *)sender {
    
    if (self.orderTotalPrice.length<=0) {
        
        [MBProgressHUD showTextMessage:@"订单异常（未获取到总价）！"];
        return;
    }
    
    CashierViewController *cashierVC = [[CashierViewController alloc] init];
    
    cashierVC.orderNoStr = self.orderNo;
    cashierVC.totalPriceStr = self.orderTotalPrice;
    cashierVC.orderTypeStr = @"1";
    
    [self.navigationController pushViewController:cashierVC animated:YES];
}

- (IBAction)pushStoreDetailsVC:(id)sender {
    
    if (self.storeID.length<=0) {
        
        [MBProgressHUD showTextMessage:@"订单异常（未获到取商店ID）！"];
        return;
    }
    
    StoreDetailsViewController *storeDetailsVC = [[StoreDetailsViewController alloc] init];
    storeDetailsVC.storeID = self.storeID;
    [self.navigationController pushViewController:storeDetailsVC animated:YES];
    self.hidesBottomBarWhenPushed = YES;
    
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

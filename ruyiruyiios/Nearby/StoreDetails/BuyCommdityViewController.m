//
//  BuyCommdityViewController.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/8.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "BuyCommdityViewController.h"
#import "StoreDetailsRequest.h"
#import "BuyCommdityCell.h"
#import "MBProgressHUD+YYM_category.h"
#import "UserConfig.h"
#import "YMTools.h"
#import "CashierViewController.h"
#import "NearbyViewController.h"
#import "UIView+extension.h"
@interface BuyCommdityViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *priceLabLab;
@property (weak, nonatomic) IBOutlet UITableView *tableVIew;
@property (weak, nonatomic) IBOutlet UILabel *sotreUserNameLab;
@property (weak, nonatomic) IBOutlet UILabel *storePhoneLab;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLab;
@property (weak, nonatomic) IBOutlet UIButton *defineBtn;

@end

@implementation BuyCommdityViewController

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{

    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单确认";
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.storeNameLab.text = self.storeName;
    self.sotreUserNameLab.text = self.userName;
    self.storePhoneLab.text = self.userPhone;
    
    self.priceLabLab.attributedText = [YMTools priceWithRedString:self.totalPrice];

    [self.tableVIew registerNib:[UINib nibWithNibName:NSStringFromClass([BuyCommdityCell class]) bundle:nil] forCellReuseIdentifier:@"buyCommodityListCellID"];
    
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
    
    BuyCommdityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"buyCommodityListCellID" forIndexPath:indexPath];
    
    CommodityModel *model = [[CommodityModel alloc] init];
    
    [model setValuesForKeysWithDictionary:self.commodityList[indexPath.row]];
    
    [cell setModel:model];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //cell 与其ContentView 高度相差0.5  原因貌似跟cell类型有关
    return 100.5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 2;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    return [UIView new];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    CGFloat h = [self tableView:tableView heightForFooterInSection:section];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, h)];
    footerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 60, footerView.height)];
    
    lab.text = @"优惠券";
    [footerView addSubview:lab];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [btn setFrame:CGRectMake(footerView.width-100-16, 0, 80, footerView.height)];
    
    [btn setTitle:@"选择优惠券" forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [btn setTintColor:[UIColor lightGrayColor]];
    [btn addTarget:self action:@selector(pushCouponVC:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:btn];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(footerView.width-20-16, 0, 20, footerView.height)];
    imgView.image = [UIImage imageNamed:@"ic_right"];
    imgView.contentMode = UIViewContentModeCenter;
    [footerView addSubview:imgView];
    return footerView;
}

-(void)setCommodityList:(NSArray *)commodityList{
    
    _commodityList = commodityList;
    
    [self.tableVIew reloadData];
}

-(void)pushCouponVC:(UIButton *)btn{
    
    NSInteger staus = 0 ;
    for (NSMutableDictionary *dic in self.commodityList) {
        
        if ([[dic objectForKey:@"name"] isEqualToString:@"精致洗车"]){
         
            staus ++;
        }
        if ([[dic objectForKey:@"name"] isEqualToString:@"四轮定位"]) {
            staus += 2;
        }
    }
    
    NSLog(@"%ld",staus);
    
}


- (IBAction)definiteBuyEvent:(UIButton *)sender {
    
    for (NSMutableDictionary *dic in self.commodityList) {
        
        if ([[dic objectForKey:@"name"] isEqualToString:@"精致洗车"]
            ||
            [[dic objectForKey:@"name"] isEqualToString:@"四轮定位"]
            ) {
            
            if ([UserConfig userCarId] == 0 ) {
                
                [MBProgressHUD showTextMessage:@"请先添加车辆！"];
                return;
            }
        }
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"正在生成订单...";
    hud.mode = MBProgressHUDModeText;
    [hud showAnimated:YES];
    
    NSMutableArray *commodityInfoArr = [NSMutableArray array];
    
    for (NSDictionary *commodityInfo in self.commodityList) {
        
        NSMutableDictionary *newCommodityInfo = [NSMutableDictionary dictionary];
        
        [newCommodityInfo setValue:[NSString stringWithFormat:@"%@",[commodityInfo objectForKey:@"commodityNumber"]] forKey:@"currentCount"];
        
        [newCommodityInfo setValue:[NSString stringWithFormat:@"%@",[commodityInfo objectForKey:@"serviceId"]] forKey:@"goodsClassId"];
        
        [newCommodityInfo setValue:[NSString stringWithFormat:@"%@",[commodityInfo objectForKey:@"amount"]] forKey:@"goodsCount"];
        
        [newCommodityInfo setValue:[NSString stringWithFormat:@"%@",[commodityInfo objectForKey:@"id"]] forKey:@"goodsId"];
        
        [newCommodityInfo setValue:[commodityInfo objectForKey:@"imgUrl"] forKey:@"goodsImage"];
        
        [newCommodityInfo setValue:[commodityInfo objectForKey:@"name"] forKey:@"goodsName"];
        
        [newCommodityInfo setValue:[NSString stringWithFormat:@"%@",[commodityInfo objectForKey:@"price"]] forKey:@"goodsPrice"];
        
        [newCommodityInfo setValue:@"0" forKey:@"goodsStock"];
        
        [newCommodityInfo setValue:[NSString stringWithFormat:@"%@",[commodityInfo objectForKey:@"serviceTypeId"]] forKey:@"serviceTypeId"];

        [commodityInfoArr addObject:newCommodityInfo];
        
    }
    
    [StoreDetailsRequest generateOrdersWithCommodityInfo:@{@"goodsInfoList":commodityInfoArr,@"userId":[NSString stringWithFormat:@"%@",[UserConfig user_id]],@"salesId":@"0",@"storeId":self.storeID,@"storeName":self.storeName,@"totalPrice":self.totalPrice}succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
       
        [hud hideAnimated:YES];

        if ([code longLongValue] ==1) {

            NSLog(@"订单信息：%@",data);
            CashierViewController *cashierVC = [[CashierViewController alloc] init];
            
            cashierVC.orderNoStr = data;
            cashierVC.totalPriceStr = self.totalPrice;
            cashierVC.orderTypeStr = @"1";
            [self.navigationController pushViewController:cashierVC animated:YES];
            
        }else if([code longLongValue] == -999){
        
            [self alertIsequallyTokenView];
            
        }else{
            
            [MBProgressHUD showTextMessage:message];

        }
        
    } failure:^(NSError * _Nullable error) {
        
        [hud hideAnimated:YES];

    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

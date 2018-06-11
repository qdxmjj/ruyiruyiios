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
@interface BuyCommdityViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *priceLabLab;
@property (weak, nonatomic) IBOutlet UITableView *tableVIew;
@property (weak, nonatomic) IBOutlet UILabel *sotreUserNameLab;
@property (weak, nonatomic) IBOutlet UILabel *storePhoneLab;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLab;
@property (weak, nonatomic) IBOutlet UIButton *defineBtn;

@property(strong,nonatomic)UIButton *goOnPayingBtn;

@property(copy,nonatomic)NSString *status;//pop回当前视图、状态
@property(copy,nonatomic)NSString *orderNo;//

@end

@implementation BuyCommdityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单确认";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.storeNameLab.text = self.storeName;
    self.sotreUserNameLab.text = self.userName;
    self.storePhoneLab.text = self.userPhone;
    
    self.priceLabLab.attributedText = [YMTools priceWithRedString:self.totalPrice];

    [self.tableVIew registerNib:[UINib nibWithNibName:NSStringFromClass([BuyCommdityCell class]) bundle:nil] forCellReuseIdentifier:@"buyCommodityListCellID"];
    
    JJWeakSelf
    self.popSelfBlock = ^(NSString *orderNo, NSString *status) {
      
        [weakSelf.defineBtn removeFromSuperview];
        [weakSelf.priceLabLab removeFromSuperview];
        
        [weakSelf.view addSubview:weakSelf.goOnPayingBtn];
        
        weakSelf.navigationItem.leftBarButtonItem = [weakSelf barButtonItemWithRect:CGRectMake(0, 0, 60, 30) image:[UIImage imageNamed:@"返回"] highlighted:nil target:weakSelf action:@selector(popNearbyViewController)];
    };
}


-(void)popNearbyViewController{
    
    for (UIViewController *nearbyVC in self.navigationController.viewControllers) {
            
        if ([nearbyVC isKindOfClass:[NearbyViewController class]]) {
                
            [self.navigationController popToViewController:nearbyVC animated:YES];
        }
    }
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

-(void)setCommodityList:(NSArray *)commodityList{
    
    _commodityList = commodityList;
    
    [self.tableVIew reloadData];
}

- (IBAction)definiteBuyEvent:(UIButton *)sender {
    

    
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
            cashierVC.userStatusStr = @"1";
            [self.navigationController pushViewController:cashierVC animated:YES];
            
        }else{
        
            [MBProgressHUD showTextMessage:message];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

-(void)goOnPayingEvent{
    
    CashierViewController *cashierVC = [[CashierViewController alloc] init];
    
    cashierVC.orderNoStr = self.orderNo;
    cashierVC.totalPriceStr = self.totalPrice;
    cashierVC.userStatusStr = @"1";
    [self.navigationController pushViewController:cashierVC animated:YES];
    
    
}

-(UIButton *)goOnPayingBtn{
    
    if (!_goOnPayingBtn) {
        
        _goOnPayingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_goOnPayingBtn setFrame:CGRectMake(0, self.view.frame.size.height-40, MAINSCREEN.width, 40)];
        [_goOnPayingBtn setTitle:@"继续支付" forState:UIControlStateNormal];
        [_goOnPayingBtn setBackgroundColor:[UIColor colorWithRed:255.f/255.f green:102.f/255.f blue:35.f/255.f alpha:1.f] forState:UIControlStateNormal];
        [_goOnPayingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_goOnPayingBtn addTarget:self action:@selector(goOnPayingEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    return _goOnPayingBtn;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

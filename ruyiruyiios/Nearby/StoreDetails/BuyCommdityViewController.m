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
#import "CouponViewController.h"

@interface BuyCommdityViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *priceLabLab;
@property (weak, nonatomic) IBOutlet UITableView *tableVIew;
@property (weak, nonatomic) IBOutlet UILabel *sotreUserNameLab;
@property (weak, nonatomic) IBOutlet UILabel *storePhoneLab;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLab;
@property (weak, nonatomic) IBOutlet UIButton *defineBtn;

@property(nonatomic,copy,nonnull)NSString *salesIdStr;

@property(nonatomic,assign)CGFloat n_TotalPrice;

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

    //使用优惠券后的价格，默认跟原价一致
    self.n_TotalPrice = [self.totalPrice floatValue];
    
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
    
    JJWeakSelf
    
    /**push CouponViewController 需要传入的状态
     *  0无可以使用优惠券的商品
     *  1 精致洗车
     *  2 四轮定位
     *  3 全都有
     *  逐级递增 所有只需要 增加相应值即可 默认为0
     */
    NSInteger staus = 0 ;
    
    //精致洗车价格
    __block NSString *xichePrice;
    
    //四轮定位价格
    __block NSString *dingweiPrice;
    
    for (NSMutableDictionary *dic in self.commodityList) {
        
        if ([[dic objectForKey:@"name"] isEqualToString:@"精致洗车"]){
         
            //赋值洗车单价
            xichePrice = [dic objectForKey:@"price"];
            
            //优惠券状态递增
            staus ++;
        }
        if ([[dic objectForKey:@"name"] isEqualToString:@"四轮定位"]) {
            
            //赋值定位单价
            dingweiPrice = [dic objectForKey:@"price"];
            
            //优惠券状态递增
            staus += 2;
        }
    }
    
    CouponViewController *couponVC = [[CouponViewController alloc] init];
    
    couponVC.couponTypeStr = [NSString stringWithFormat:@"%ld", staus];
    
    couponVC.callBuyStore = ^(NSString *couponIdStr, NSString *typeIdStr, NSString *couponNameStr) {
        
        //再次选择优惠券，重新赋值新价格为原价 减 新优惠券价格  只允许一张优惠券生效
        self.n_TotalPrice = [self.totalPrice floatValue];
        
        [btn setTitle:couponNameStr forState:UIControlStateNormal];
        
        if (couponIdStr) {
            //设置优惠券ID
            weakSelf.salesIdStr = couponIdStr;
        }
        
        //选择了优惠卷  修改总价
        if ([couponNameStr isEqualToString:@"精致洗车券"]) {
            
            weakSelf.n_TotalPrice =  weakSelf.n_TotalPrice - [xichePrice floatValue];
        }
        
        if ([couponNameStr isEqualToString:@"四轮定位券"]) {
            
            weakSelf.n_TotalPrice =  weakSelf.n_TotalPrice - [dingweiPrice floatValue];
        }
        if ([typeIdStr isEqualToString:@"2"]) {
            
            //元现金券
            if (![couponNameStr containsString:@"元现金券"]) {
                
                [MBProgressHUD showTextMessage:@"优惠券异常（格式错误）！"];
                return ;
            }
            NSArray *arr = [couponNameStr componentsSeparatedByString:@"元现金券"];
            
            weakSelf.n_TotalPrice =  weakSelf.n_TotalPrice - [arr[0] floatValue];
        }
        
        //赋值新的价格
        weakSelf.priceLabLab.attributedText = [YMTools priceWithRedString:[NSString stringWithFormat:@"%.2f",weakSelf.n_TotalPrice]];
    };
    
    [self.navigationController pushViewController:couponVC animated:YES];
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
    
    if (!self.salesIdStr) {
        
        self.salesIdStr = @"0";
    }
    
    [StoreDetailsRequest generateOrdersWithCommodityInfo:@{@"goodsInfoList":commodityInfoArr,@"userId":[NSString stringWithFormat:@"%@",[UserConfig user_id]],@"salesId":self.salesIdStr,@"storeId":self.storeID,@"storeName":self.storeName,@"totalPrice":self.totalPrice,@"actuallyPrice":[NSString stringWithFormat:@"%.2f",self.n_TotalPrice]}succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
       
        [hud hideAnimated:YES];

        if ([code longLongValue] ==1) {

            NSLog(@"订单信息：%@",data);
            CashierViewController *cashierVC = [[CashierViewController alloc] init];
            
            cashierVC.orderNoStr = data;
            cashierVC.totalPriceStr = [NSString stringWithFormat:@"%f",self.n_TotalPrice];
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

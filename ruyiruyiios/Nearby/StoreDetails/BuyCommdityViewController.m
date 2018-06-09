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
@interface BuyCommdityViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *priceLabLab;
@property (weak, nonatomic) IBOutlet UITableView *tableVIew;
@property (weak, nonatomic) IBOutlet UILabel *sotreUserNameLab;
@property (weak, nonatomic) IBOutlet UILabel *storePhoneLab;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLab;


@end

@implementation BuyCommdityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单确认";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.storeNameLab.text = self.storeName;
    self.sotreUserNameLab.text = self.userName;
    self.storePhoneLab.text = self.userPhone;
    
    NSString *redStr = [NSString stringWithFormat:@"合计： %@ 元",self.totalPrice];
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:redStr];
    
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[redStr rangeOfString:[NSString stringWithFormat:@"%@",self.totalPrice]]];
    
    self.priceLabLab.attributedText = attributedStr;

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
            //跳转页面--->页面的属性{订单号，订单类型，总价}
        }else{
        
            [MBProgressHUD showTextMessage:message];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
    
    
}

-(void)setStatus:(NSString *)status{
    
    if ([status isEqualToString:@"1"]) {
        
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

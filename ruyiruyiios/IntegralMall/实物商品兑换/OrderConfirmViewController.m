//
//  OrderConfirmViewController.m
//  ruyiruyiios
//
//  Created by 姚永敏 on 2019/1/4.
//  Copyright © 2019 ruyiruyi. All rights reserved.
//

#import "OrderConfirmViewController.h"
#import "ShippingAddressController.h"
#import "AddAddressView.h"
#import "AddressView.h"

#import "MBProgressHUD+YYM_category.h"

@interface OrderConfirmViewController ()<UITableViewDelegate,UITableViewDataSource,ShippingAddressDelegate>
@property (weak, nonatomic) IBOutlet UIView *addressView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)AddAddressView *addAddressView;
@property (strong, nonatomic)AddressView *myAddressView;
@property (weak, nonatomic) IBOutlet UILabel *availableIntegralLab;

@property (strong, nonatomic) ShippingAddressController *shippingAddressVC;
@property (strong, nonatomic) IntegralGoodsMode *integralGoodsModel;
@property (copy, nonatomic) NSString *addressID;
@end

@implementation OrderConfirmViewController
- (instancetype)initWithIntegralGoodsMode:(IntegralGoodsMode *)model{
    self = [super init];
    if (self) {
        
        self.integralGoodsModel = model;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单确认";
    ///默认无地址
    [self.addressView addSubview:self.addAddressView];
    
    self.availableIntegralLab.text = [UserConfig integral];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GoodsCell class]) bundle:nil] forCellReuseIdentifier:@"GoodsCellID"];
    
    [self getDefaultAddressInfo];
}

- (void)getDefaultAddressInfo{
    
    [JJRequest getRequest:[NSString stringWithFormat:@"%@/score/address",INTEGRAL_IP] params:@{@"userId": [UserConfig user_id]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if ([code integerValue] == 1) {
            
            [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([obj[@"isDefault"] integerValue] ==1) {
               
                    [self.addAddressView removeFromSuperview];
                    
                    [self.addressView addSubview:self.myAddressView];
                    
                    NSString *cityInfo = [NSString stringWithFormat:@"%@",obj[@"address"]];
                    
                    self.myAddressView.userNameLab.text = obj[@"name"];
                    self.myAddressView.phoneLab.text = [NSString stringWithFormat:@"%@",obj[@"phone"]];
                    self.myAddressView.addressLab.text = cityInfo;
                    
                    self.addressID = obj[@"id"];
                    *stop = YES;
                }
            }];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
    
}
- (IBAction)confirmBuyEvent:(id)sender{
    
    if (self.addressID.length<=0) {
        
        [MBProgressHUD showTextMessage:@"请选择收货地址！"];
        return;
    }
    
    [MBProgressHUD showWaitMessage:@"正在购买..." showView:self.view];
    
    NSString *skuId = [NSString stringWithFormat:@"%@",self.integralGoodsModel.skuId];
    NSString *skuImg = [NSString stringWithFormat:@"%@",self.integralGoodsModel.imgUrl];
    NSString *score = [NSString stringWithFormat:@"%@",self.integralGoodsModel.score];
    
    [JJRequest interchangeablePostRequestWithIP:INTEGRAL_IP path:@"/score/order" params:@{@"userId":[UserConfig user_id],@"orderType":@"1",@"skuId":skuId,@"skuImg":skuImg,@"score":score,@"addressId":self.addressID,@"token":[UserConfig token]} success:^(id  _Nullable data) {
        [MBProgressHUD hideWaitViewAnimated:self.view];
        
        if ([data[@"status"] integerValue] == 1) {
            
            [MBProgressHUD showTextMessage:@"兑换成功！"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    } failure:^(NSError * _Nullable error) {
        [MBProgressHUD hideWaitViewAnimated:self.view];
    }];
    
}

- (void)pushAddShippingAddressEvent:(UIButton *)sender{
    
    
    [self.navigationController pushViewController:self.shippingAddressVC animated:YES];
}

- (void)ShippingAddressController:(ShippingAddressController *)viewController selectAddress:(NSDictionary *)addressInfo{
    
    [self.addAddressView removeFromSuperview];
    
    [self.addressView addSubview:self.myAddressView];
    
    NSString *cityInfo = [NSString stringWithFormat:@"%@",addressInfo[@"address"]];
    
    self.myAddressView.userNameLab.text = addressInfo[@"name"];
    self.myAddressView.phoneLab.text = [NSString stringWithFormat:@"%@",addressInfo[@"phone"]];
    self.myAddressView.addressLab.text = cityInfo;
    
    self.addressID = addressInfo[@"id"];

//    NSLog(@"更换视图数据");
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    GoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsCellID" forIndexPath:indexPath];
    cell.model = self.integralGoodsModel;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    return [UIView new];
}
- (ShippingAddressController *)shippingAddressVC{
    
    if (!_shippingAddressVC) {
        _shippingAddressVC = [[ShippingAddressController alloc] init];
        _shippingAddressVC.delegate = self;
    }
    return _shippingAddressVC;
}
- (AddressView *)myAddressView{
    
    if (!_myAddressView) {
        
        _myAddressView = [[AddressView alloc] initWithFrame:self.addressView.frame];
        [_myAddressView.rightBtn addTarget:self action:@selector(pushAddShippingAddressEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _myAddressView;
}
- (AddAddressView *)addAddressView{
    if (!_addAddressView) {
        
        _addAddressView = [[AddAddressView alloc] initWithFrame:self.addressView.frame];
        [_addAddressView.rightBtn addTarget:self action:@selector(pushAddShippingAddressEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addAddressView;
}
- (IntegralGoodsMode *)integralGoodsModel{
    if (!_integralGoodsModel) {
        
        _integralGoodsModel = [[IntegralGoodsMode alloc] init];
    }
    return _integralGoodsModel;
}
@end

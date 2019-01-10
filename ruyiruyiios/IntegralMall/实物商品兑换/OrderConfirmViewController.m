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
#import "GoodsCell.h"
@interface OrderConfirmViewController ()<UITableViewDelegate,UITableViewDataSource,ShippingAddressDelegate>
@property (weak, nonatomic) IBOutlet UIView *addressView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)AddAddressView *addAddressView;
@property (strong, nonatomic)AddressView *myAddressView;

@property (strong, nonatomic) ShippingAddressController *shippingAddressVC;
@end

@implementation OrderConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单确认";
    
    AddAddressView *addView = [[AddAddressView alloc] initWithFrame:self.addressView.frame];
    
    [addView.rightBtn addTarget:self action:@selector(pushAddShippingAddressEvent:) forControlEvents:UIControlEventTouchUpInside];
    //if 有地址
    [self.addressView addSubview:addView];

    self.addAddressView = addView;
    //else 无地址
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GoodsCell class]) bundle:nil] forCellReuseIdentifier:@"GoodsCellID"];
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
//    NSLog(@"更换视图数据");
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    GoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsCellID" forIndexPath:indexPath];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
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
@end

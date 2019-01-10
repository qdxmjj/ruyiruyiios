//
//  ShippingAddressController.m
//  ruyiruyiios
//
//  Created by 姚永敏 on 2019/1/4.
//  Copyright © 2019 ruyiruyi. All rights reserved.
//

#import "ShippingAddressController.h"
#import "AddShippingAddressViewController.h"
#import "ShippingAddressCell.h"
#import "AddressInfoModel.h"
@interface ShippingAddressController ()<ShippingAddressCellDelegate>

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIButton *gotoAddBtn;

@property (nonatomic, strong) NSArray *addressList;

@property (nonatomic, strong) NSDictionary *defaultAddressInfo;

@end

@implementation ShippingAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的地址";
    
    UIImage *img = [UIImage imageNamed:@"ic_tianjia"];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStylePlain target:self action:@selector(gotoAddAddress)];
    
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ShippingAddressCell class]) bundle:nil] forCellReuseIdentifier:@"ShippingAddressCellID"];
    
    [self getShippingAddressInfo];
    
}

- (void)setUI{
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.view.mas_centerY);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.4);
        make.width.mas_equalTo(self.view.mas_width);
    }];
    
    [self.gotoAddBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.view.mas_centerY);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.height.mas_equalTo(CGSizeMake(100, 40));
    }];
    
}

- (void)getShippingAddressInfo{
    
    [JJRequest getRequest:[NSString stringWithFormat:@"%@/score/address",SERVERPREFIX] params:@{@"userId": [UserConfig user_id]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if ([code integerValue] == 1) {
            
            self.addressList = data;
            
            if (self.addressList.count<=0) {
                
                [self.view addSubview:self.imgView];
                [self.view addSubview:self.gotoAddBtn];
                [self setUI];
            }else{
                
                [self.tableView reloadData];
            }
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

- (void)gotoAddAddress{
    
    NSString *isDefault;
    if (self.addressList.count>0) {
        
        isDefault = @"0";
    }else{
        
        isDefault = @"1";
    }
    
    AddShippingAddressViewController *addshippingAddressVC = [[AddShippingAddressViewController alloc] initWithDefault:isDefault];
    
    if (self.defaultAddressInfo.count >0 ) {
        
        AddressInfoModel *model = [[AddressInfoModel alloc] init];
        [model setValuesForKeysWithDictionary:self.defaultAddressInfo];
        addshippingAddressVC.defaultInfo = model;
        self.defaultAddressInfo = nil;
    }
    
    addshippingAddressVC.refreshBlock = ^{
        
        [self getShippingAddressInfo];
    };
    [self.navigationController pushViewController:addshippingAddressVC animated:YES];
}

#pragma mark cellDelegate
- (void)ClickDeleteButtonWithShippingAddressCell:(ShippingAddressCell *)cell{
    //删除
    JJWeakSelf
    
    NSIndexPath *indexPath = [weakSelf.tableView indexPathForCell:cell];
    NSDictionary *dic = weakSelf.addressList[indexPath.row];
    
    [JJRequest deleteRequest:@"/score/address" params:@{@"id":dic[@"id"]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if ([code integerValue] == 1) {
            
            [weakSelf getShippingAddressInfo];
        }
    } failure:^(NSError * _Nullable error) {
    }];
}

- (void)ClickEditButtonWithShippingAddressCell:(ShippingAddressCell *)cell{
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    self.defaultAddressInfo = self.addressList[indexPath.row];
    [self gotoAddAddress];
    //    NSLog(@"编辑");
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    if (self.addressList.count>0) {
        
        return self.addressList.count;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ShippingAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShippingAddressCellID" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    AddressInfoModel *model = [[AddressInfoModel alloc] init];
    [model setValuesForKeysWithDictionary:self.addressList[indexPath.row]];

    cell.model = model;    
    cell.delegate = self;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ShippingAddressCell *shippingAddressCell = (ShippingAddressCell *)cell;
    
    shippingAddressCell.delegate = nil;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([self.delegate respondsToSelector:@selector(ShippingAddressController:selectAddress:)]) {
        
        [self.delegate ShippingAddressController:self selectAddress:self.addressList[indexPath.row]];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (UIImageView *)imgView{
    
    if (!_imgView) {
        
        _imgView = [[UIImageView alloc] init];
        _imgView.backgroundColor = [UIColor lightGrayColor];
    }
    return _imgView;
}

- (UIButton *)gotoAddBtn{
    
    if (!_gotoAddBtn) {
        
        _gotoAddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_gotoAddBtn setTitle:@"去添加" forState:UIControlStateNormal];
        [_gotoAddBtn setBackgroundColor:LOGINBACKCOLOR];
        [_gotoAddBtn addTarget:self action:@selector(gotoAddAddress) forControlEvents:UIControlEventTouchUpInside];
        //设置圆角
        _gotoAddBtn.layer.cornerRadius = 20;
        
        //将多余的部分切掉
        _gotoAddBtn.layer.masksToBounds = YES;
    }
    return _gotoAddBtn;
}

- (NSArray *)addressList{
    
    if (!_addressList) {
        
        _addressList = [NSArray array];
    }
    return _addressList;
}

- (NSDictionary *)defaultAddressInfo{
    
    if (!_defaultAddressInfo) {
        
        _defaultAddressInfo = [NSDictionary dictionary];
    }
    return _defaultAddressInfo;
}
@end

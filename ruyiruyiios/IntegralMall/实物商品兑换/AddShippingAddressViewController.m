//
//  AddShippingAddressViewController.m
//  ruyiruyiios
//
//  Created by 姚永敏 on 2019/1/7.
//  Copyright © 2019 ruyiruyi. All rights reserved.
//

#import "AddShippingAddressViewController.h"
#import "AddressPickerView.h"
#import "MBProgressHUD+YYM_category.h"
@interface AddShippingAddressViewController ()<AddressPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *telTextfield;
@property (weak, nonatomic) IBOutlet UIButton *cityBtn;
@property (weak, nonatomic) IBOutlet UITextField *addressTextfield;
@property (weak, nonatomic) IBOutlet UISwitch *defaultSwitch;
@property (strong, nonatomic)AddressPickerView *areaPickerView;

@property (copy, nonatomic) NSString *province;
@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *area;
@property (assign, nonatomic) BOOL isDefault;
@end

@implementation AddShippingAddressViewController

- (instancetype)initWithDefault:(NSString *)isDefault{
    self = [super init];
    if (self) {
        
        self.isDefault = [isDefault isEqualToString:@"1"] == YES ? YES:NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加地址";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(submitAddressEvent)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    [self.view addSubview:self.areaPickerView];
    
    self.defaultSwitch.on = self.isDefault;
    
    if (self.defaultInfo) {
        
        NSString *city = [NSString stringWithFormat:@"%@ %@ %@",self.defaultInfo.province,self.defaultInfo.city,self.defaultInfo.county];
        
        self.province = self.defaultInfo.province;
        self.city = self.defaultInfo.city;
        self.area = self.defaultInfo.county;
        
        self.nameTextfield.text = self.defaultInfo.name;
        self.telTextfield.text = [NSString stringWithFormat:@"%@",self.defaultInfo.phone];
        [self.cityBtn setTitle:city forState:UIControlStateNormal];
        self.addressTextfield.text = self.defaultInfo.address;
        self.defaultSwitch.on = [self.defaultInfo.isDefault integerValue] == 1 ? YES : NO;
    }
}

- (void)setDefaultInfo:(AddressInfoModel *)defaultInfo{
    _defaultInfo = defaultInfo;
}

- (IBAction)selectCityEvent:(UIButton *)sender {
    
    [self.areaPickerView show:YES];
}

- (void)sureBtnClickReturnProvince:(NSString *)province City:(NSString *)city Area:(NSString *)area{
    
    self.province = province;
    self.city = city;
    self.area = area;
    
    NSString *selectCity = [NSString stringWithFormat:@"%@ %@ %@",province,city,area];
    [self.cityBtn setTitle:selectCity forState:UIControlStateNormal];
    
    [self.areaPickerView hide:YES];
}

- (void)cancelBtnClick {
    
    [self.areaPickerView hide:YES];
}

- (void)submitAddressEvent{
    
    //是否默认地址[0:否,1:是]
    
    if (self.nameTextfield.text.length<=0) {
        
        [MBProgressHUD showTextMessage:@"请填写收货人!"];
        return;
    }
    if (self.telTextfield.text.length<=0) {
        
        [MBProgressHUD showTextMessage:@"请填写联系电话!"];
        return;
    }
    if ([self.cityBtn.titleLabel.text isEqualToString:@"请选择省、市、区"]) {
        
        [MBProgressHUD showTextMessage:@"请选择省市区!"];
        return;
    }
    if (self.addressTextfield.text.length<=0) {
        
        [MBProgressHUD showTextMessage:@"请填写详细收货地址!"];
        return;
    }
    
    NSString *isDefault;
    
    if (self.defaultSwitch.on) {
        
        isDefault = @"1";
    }else{
        
        isDefault = @"0";
    }
    
    NSDictionary *params = @{@"userId":[UserConfig user_id],@"province":self.province,@"city":self.city,@"county":self.area,@"phone":self.telTextfield.text,@"name":self.nameTextfield.text,@"address":self.addressTextfield.text,@"isDefault":isDefault};
    
    if (self.defaultInfo) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:params];
        
        [dic setObject:[NSString stringWithFormat:@"%@",self.defaultInfo.address_id] forKey:@"id"];
        [JJRequest putRequestWithIP:INTEGRAL_IP path:@"/score/address" params:dic success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
            
            if ([code integerValue] == 1) {
                
                [MBProgressHUD showTextMessage:@"修改成功！"];
                self.refreshBlock();
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                
                [MBProgressHUD showTextMessage:message];
            }
            
        } failure:^(NSError * _Nullable error) {
            
        }];
    }else{
        
        [JJRequest interchangeablePostRequestWithIP:INTEGRAL_IP path:@"/score/address" params:params success:^(id  _Nullable data) {
            
            if ([data[@"status"] integerValue] == 1) {
                
                [MBProgressHUD showTextMessage:@"添加成功！"];
                self.refreshBlock();
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                
                [MBProgressHUD showTextMessage:data[@"msg"]];
            }
//            NSLog(@"%@",data);
            
        } failure:^(NSError * _Nullable error) {
            
        }];
    }
}

- (AddressPickerView *)areaPickerView{
    if (!_areaPickerView) {
        _areaPickerView = [[AddressPickerView alloc]init];
        _areaPickerView.delegate = self;
        [_areaPickerView setTitleHeight:30 pickerViewHeight:215];
    }
    return _areaPickerView;
}

@end

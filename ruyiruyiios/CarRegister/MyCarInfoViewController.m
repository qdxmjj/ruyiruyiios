//
//  MyCarInfoViewController.m
//  ruyiruyiios
//
//  Created by 姚永敏 on 2019/3/15.
//  Copyright © 2019 ruyiruyi. All rights reserved.
//

#import "MyCarInfoViewController.h"
#import "SpacingLineScrollView.h"
#import "SelectBrandViewController.h"
#import "TireSpecificationViewController.h"
#import "RoadConditionViewController.h"
#import "BuyCommdityViewController.h"

#import "FMDBCarTireInfo.h"
#import "CarInfo.h"
#import "DelegateConfiguration.h"
#import "PlateLicenseView.h"
#import "JJCouponView.h"
#import <MOFSPickerManager.h>
#import "DBRecorder.h"
#import "MBProgressHUD+YYM_category.h"

#import "AipOcrSdk.h"

@interface MyCarInfoViewController ()<CartypeStatusDelegate,RoadStatusDelegate>
{
    BOOL isNew;
    
    NSString *carID; /// 车辆id
    NSString *carName; /// 车辆名
    NSString *xinnengyuan; /// 是否是新能源
    NSString *plat_number; /// 车牌号
    NSString *pro_city_id; /// 常驻地区 对应的id
    NSString *proCityName; /// 常驻地区
    NSString *front; /// 前轮型号
    NSString *rear; /// 后轮型号
    NSString *driving_license_date; /// 认证获取到的 行驶证日期 无认证 传空
    NSString *serviceYearLength; ///服务年限 传1即可
    NSString *road_text; /// 行驶路况 文本
    NSString *type_i_rate; /// 一级路况id
    NSString *type_ii_rate; /// 二级路况id
    NSString *type_iii_rate; /// 三级路况id  必须最少得有一个路况 id 不然不允许上传  全不选第三级默认传全部路况
    NSString *traveled; ///行驶里程
    NSString *invite_code; /// 邀请码
    
    NSString *authenticatedState; /// 是否认证 1 认证 2 未认证

}
@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) SpacingLineScrollView *mainView;
@property (nonatomic, strong) UILabel *carBrandLab;//车型
@property (nonatomic, strong) UIButton *carBrandbtn;//车型

@property (nonatomic, strong) UILabel *nEnergyCarLab;//新能源
@property (nonatomic, strong) UISwitch *nEnergySwitch;//是否为新能源

@property (nonatomic, strong) UILabel *carNumberLab;///车牌号码
@property (nonatomic, strong) UIButton *carNumberBtn;///车牌号按钮

@property (nonatomic, strong) UILabel *changZhuLab;///常驻地区
@property (nonatomic, strong) UIButton *changZhuBtn;///常驻地区选择器

@property (nonatomic, strong) UILabel *frontWheelLab;///前轮
@property (nonatomic, strong) UIButton *frontWheelBtn;///前轮选择

@property (nonatomic, strong) UILabel *rearWheelLab;///后轮
@property (nonatomic, strong) UIButton *rearWheelBtn;///后轮选择

@property (nonatomic, strong) UILabel *certificationLab;///认证
@property (nonatomic, strong) UIImageView *imgView;///认证图标
@property (nonatomic, strong) UIButton *certificationBtn;///认证按钮

@property (nonatomic, strong) UILabel *mileageLab;///里程
@property (nonatomic, strong) UITextField *mileageTextField;///里程输入框

@property (nonatomic, strong) UILabel *roadConditionLab;///路况
@property (nonatomic, strong) UIButton *roadConditionBtn;///路况选择

@property (nonatomic, strong) UILabel *InvitationCodeLab; //邀请码
@property (nonatomic, strong) UITextField *InvitationCodeTextField; //邀请码输入框

@property (nonatomic, strong) UIButton *saveBtn;

@property(nonatomic, strong)UIView *backView;

@property(nonatomic, strong)PlateLicenseView *plateLicenseView;///车牌选择器

@property(nonatomic, strong)FMDBCarTireInfo *car_carTireInfo;
@property(nonatomic, strong)CarInfo *carInfo;

@end

@implementation MyCarInfoViewController

- (IBAction)backButtonAction:(id)sender{
    
    DelegateConfiguration *delegateConfiguration = [DelegateConfiguration sharedConfiguration];
    [delegateConfiguration unregisterRoadStatusChangedListener:self];
    [delegateConfiguration unregisterCartypeStatusChangeListener:self];
    [self.navigationController popViewControllerAnimated:YES];
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
        carID = @"";
        carName = @"";
        xinnengyuan = @"";
        plat_number = @"";
        pro_city_id = @"";
        proCityName = @"";
        front = @"";
        rear = @"";
        driving_license_date = @"2000-01-01"; ///默认行驶证日期  未认证状态
        serviceYearLength = @"1";  ///默认服务年限1
        road_text = @"";
        type_i_rate = @"";
        type_ii_rate = @"";
        type_iii_rate = @"";
        traveled = @"";
        invite_code = @""; ///邀请码 默认空
        authenticatedState = @"2"; ///默认未认证
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"车辆信息";
    
    DelegateConfiguration *delegateConfiguration = [DelegateConfiguration sharedConfiguration];
    [delegateConfiguration registerRoadStatusChangedListener:self];
    [delegateConfiguration registerCartypeStatusChangeListener:self];
    
    ///是否是修改车辆信息
    if (self.user_car_idStr) {
        
        [self getCarInfoFromInternet];
    }
    
    self.nEnergySwitch.userInteractionEnabled = self.is_alter;
    self.carBrandbtn.userInteractionEnabled = self.is_alter;
    self.carNumberBtn.userInteractionEnabled = self.is_alter;
    self.certificationBtn.userInteractionEnabled = self.is_alter;
    self.changZhuBtn.userInteractionEnabled = self.is_alter;
    self.fronlWheelBtn.userInteractionEnabled = self.is_alter;
    self.rearWheelBtn.userInteractionEnabled = self.is_alter;
    self.roadConditionBtn.userInteractionEnabled = self.is_alter;
    self.mileageTextField.userInteractionEnabled = self.is_alter;

    [self.view addSubview:self.mainView];
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.plateLicenseView];
    
    [self.mainView addSubview:self.titleLab];
    
    [self.mainView addSubview:self.carBrandLab];
    [self.mainView addSubview:self.carBrandbtn];
    
    [self.mainView addSubview:self.nEnergyCarLab];
    [self.mainView addSubview:self.nEnergySwitch];

    [self.mainView addSubview:self.carNumberLab];
    [self.mainView addSubview:self.carNumberBtn];
    
    [self.mainView addSubview:self.changZhuLab];
    [self.mainView addSubview:self.changZhuBtn];
    
    [self.mainView addSubview:self.fronlWheelLab];
    [self.mainView addSubview:self.fronlWheelBtn];
    
    [self.mainView addSubview:self.rearWheelLab];
    [self.mainView addSubview:self.rearWheelBtn];
    
    [self.mainView addSubview:self.certificationLab];
    [self.mainView addSubview:self.imgView];
    [self.mainView addSubview:self.certificationBtn];
    
    [self.mainView addSubview:self.mileageLab];
    [self.mainView addSubview:self.mileageTextField];
    
    [self.mainView addSubview:self.roadConditionLab];
    [self.mainView addSubview:self.roadConditionBtn];
    
    
    if ([[UserConfig firstAddCar] integerValue] == 0) {
        
        ///邀请码
        [self.mainView addSubview:self.InvitationCodeLab];
        [self.mainView addSubview:self.InvitationCodeTextField];
    }
    
    [self.view addSubview:self.saveBtn];

    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.view.mas_top);
        make.bottom.mas_equalTo(self.saveBtn.mas_top);
        make.leading.trailing.mas_equalTo(self.view);
        if ([[UserConfig firstAddCar] integerValue] == 0) {
            
            make.bottom.mas_equalTo(self.InvitationCodeLab.mas_bottom);
        }else{
            make.bottom.mas_equalTo(self.roadConditionBtn.mas_bottom);
        }
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.mainView.mas_top).inset(5);
        make.leading.mas_equalTo(self.view.mas_leading).inset(10);
        make.trailing.mas_equalTo(self.view.mas_trailing).inset(10);
        make.height.mas_equalTo(40);
    }];
    
    [self.carBrandLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.mas_equalTo(self.view.mas_leading).inset(16);
        make.top.mas_equalTo(self.titleLab.mas_bottom);
        make.height.mas_equalTo(44);
    }];
    [self.carBrandbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.trailing.mas_equalTo(self.view.mas_trailing).inset(16);
        make.centerY.mas_equalTo(self.carBrandLab.mas_centerY);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(70);
    }];
    [self.nEnergyCarLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.carBrandLab.mas_bottom);
        make.leading.mas_equalTo(self.view.mas_leading).inset(16);
        make.height.mas_equalTo(44);
    }];
    [self.nEnergySwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.trailing.mas_equalTo(self.view.mas_trailing).inset(16);
        make.centerY.mas_equalTo(self.nEnergyCarLab.mas_centerY);
    }];
    
    [self.carNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.nEnergyCarLab.mas_bottom);
        make.leading.mas_equalTo(self.view.mas_leading).inset(16);
        make.height.mas_equalTo(44);
    }];
    
    [self.carNumberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.trailing.mas_equalTo(self.view.mas_trailing).inset(16);
        make.centerY.mas_equalTo(self.carNumberLab.mas_centerY);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(100);
    }];
    
    [self.changZhuLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.carNumberLab.mas_bottom);
        make.leading.mas_equalTo(self.view.mas_leading).inset(16);
        make.height.mas_equalTo(44);
    }];
    [self.changZhuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.trailing.mas_equalTo(self.view.mas_trailing).inset(16);
        make.centerY.mas_equalTo(self.changZhuLab.mas_centerY);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(180);
    }];
    
    [self.fronlWheelLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.changZhuLab.mas_bottom);
        make.leading.mas_equalTo(self.view.mas_leading).inset(16);
        make.height.mas_equalTo(44);
    }];
    [self.fronlWheelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.trailing.mas_equalTo(self.view.mas_trailing).inset(16);
        make.centerY.mas_equalTo(self.fronlWheelLab.mas_centerY);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(100);
    }];
    
    [self.rearWheelLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.fronlWheelLab.mas_bottom);
        make.leading.mas_equalTo(self.view.mas_leading).inset(16);
        make.height.mas_equalTo(44);
    }];
    [self.rearWheelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.trailing.mas_equalTo(self.view.mas_trailing).inset(16);
        make.centerY.mas_equalTo(self.rearWheelLab.mas_centerY);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(100);
    }];
    
    [self.certificationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.rearWheelLab.mas_bottom);
        make.leading.mas_equalTo(self.view.mas_leading).inset(16);
        make.height.mas_equalTo(44);
    }];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.leading.mas_equalTo(self.certificationLab.mas_trailing);
        make.centerY.mas_equalTo(self.certificationLab.mas_centerY);
        make.width.height.mas_equalTo(@15);
    }];
    [self.certificationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.trailing.mas_equalTo(self.view.mas_trailing).inset(16);
        make.centerY.mas_equalTo(self.certificationLab.mas_centerY);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(100);
    }];
    
    [self.mileageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.certificationLab.mas_bottom);
        make.leading.mas_equalTo(self.view.mas_leading).inset(16);
        make.height.mas_equalTo(44);
    }];
    [self.mileageTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.trailing.mas_equalTo(self.view.mas_trailing).inset(16);
        make.centerY.mas_equalTo(self.mileageLab.mas_centerY);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(100);
    }];
    
    [self.roadConditionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.mileageLab.mas_bottom);
        make.leading.mas_equalTo(self.view.mas_leading).inset(16);
        make.height.mas_equalTo(44);
    }];
    [self.roadConditionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.trailing.mas_equalTo(self.view.mas_trailing).inset(16);
        make.centerY.mas_equalTo(self.roadConditionLab.mas_centerY);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(180);
    }];
    
    if ([[UserConfig firstAddCar] integerValue] == 0) {

        [self.InvitationCodeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(self.roadConditionLab.mas_bottom);
            make.leading.mas_equalTo(self.view.mas_leading).inset(16);
            make.height.mas_equalTo(44);
        }];
        
        [self.InvitationCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.trailing.mas_equalTo(self.view.mas_trailing).inset(16);
            make.centerY.mas_equalTo(self.InvitationCodeLab.mas_centerY);
            make.height.mas_equalTo(44);
            make.width.mas_equalTo(180);
        }];
    }
    
    
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        if (@available(iOS 11.0, *)) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.view.mas_bottom);
        }
        make.leading.trailing.mas_equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
}

- (UILabel *)titleLab{
    if (!_titleLab) {
        
        _titleLab = [[UILabel alloc] init];
        _titleLab.backgroundColor = [UIColor colorWithRed:240.f/255.f green:240.f/255.f blue:240.f/255.f alpha:1.f];
        _titleLab.font = [UIFont systemFontOfSize:12.f];
        _titleLab.numberOfLines = 0;
        _titleLab.text = @"温馨提示：如驿如意为您的爱车提供个性化服务，需要了解车辆的详细信息，请如实填写";
    }
    return _titleLab;
}
- (SpacingLineScrollView *)mainView{
    if (!_mainView) {
        
        _mainView = [[SpacingLineScrollView alloc] init];
        _mainView.backgroundColor = [UIColor whiteColor];
        _mainView.showsVerticalScrollIndicator = NO;
        _mainView.showsHorizontalScrollIndicator = NO;
        _mainView.alwaysBounceVertical = YES;
    }
    return _mainView;
}
- (UILabel *)carBrandLab{
    if (!_carBrandLab) {
        
        _carBrandLab = [[UILabel alloc] init];
        _carBrandLab.font = [UIFont systemFontOfSize:14.f];
        _carBrandLab.text = @"车型";
    }
    return _carBrandLab;
}
- (UIButton *)carBrandbtn{
    if (!_carBrandbtn) {
        
        _carBrandbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_carBrandbtn setTitle:@"选择车型" forState:UIControlStateNormal];
        [_carBrandbtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [_carBrandbtn.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
        [_carBrandbtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_carBrandbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_carBrandbtn addTarget:self action:@selector(chickCarTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _carBrandbtn;
}
- (UILabel *)nEnergyCarLab{
    if (!_nEnergyCarLab) {
        _nEnergyCarLab = [[UILabel alloc] init];
        _nEnergyCarLab.text = @"是否为新能源车";
        _nEnergyCarLab.font = [UIFont systemFontOfSize:14.f];
    }
    return _nEnergyCarLab;
}
- (UISwitch *)nEnergySwitch{
    if (!_nEnergySwitch) {
        
        _nEnergySwitch = [[UISwitch alloc] init];
        [_nEnergySwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nEnergySwitch;
}
- (UILabel *)carNumberLab{
    if (!_carNumberLab) {
        
        _carNumberLab = [[UILabel alloc] init];
        _carNumberLab.font = [UIFont systemFontOfSize:14.f];
        _carNumberLab.text = @"车牌号码";
    }
    return _carNumberLab;
}
- (UIButton *)carNumberBtn{
    if (!_carNumberBtn) {
        
        _carNumberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_carNumberBtn setTitle:@"选择车牌" forState:UIControlStateNormal];
        [_carNumberBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [_carNumberBtn.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
        [_carNumberBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_carNumberBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_carNumberBtn addTarget:self action:@selector(showPlateLicenseView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _carNumberBtn;
}
- (UILabel *)changZhuLab{
    if (!_changZhuLab) {
        
        _changZhuLab = [[UILabel alloc] init];
        _changZhuLab.font = [UIFont systemFontOfSize:14.f];
        _changZhuLab.text = @"常驻地区";
    }
    return _changZhuLab;
}
- (UIButton *)changZhuBtn{
    if (!_changZhuBtn) {
        
        _changZhuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_changZhuBtn setTitle:@"选择常驻地区" forState:UIControlStateNormal];
        [_changZhuBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [_changZhuBtn.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
        [_changZhuBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_changZhuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_changZhuBtn addTarget:self action:@selector(selectAddressEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changZhuBtn;
}
- (UILabel *)fronlWheelLab{
    if (!_frontWheelLab) {
        
        _frontWheelLab = [[UILabel alloc] init];
        _frontWheelLab.font = [UIFont systemFontOfSize:14.f];
        _frontWheelLab.text = @"前轮型号";
    }
    return _frontWheelLab;
}
- (UIButton *)fronlWheelBtn{
    if (!_frontWheelBtn) {
        
        _frontWheelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_frontWheelBtn setTitle:@"选择前轮型号" forState:UIControlStateNormal];
        [_frontWheelBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [_frontWheelBtn.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
        [_frontWheelBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_frontWheelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_frontWheelBtn addTarget:self action:@selector(selectTireTypeEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _frontWheelBtn;
}
- (UILabel *)rearWheelLab{
    if (!_rearWheelLab) {
        
        _rearWheelLab = [[UILabel alloc] init];
        _rearWheelLab.font = [UIFont systemFontOfSize:14.f];
        _rearWheelLab.text = @"后轮型号";
    }
    return _rearWheelLab;
}
- (UIButton *)rearWheelBtn{
    if (!_rearWheelBtn) {
        
        _rearWheelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_rearWheelBtn setTitle:@"选择后轮型号" forState:UIControlStateNormal];
        [_rearWheelBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [_rearWheelBtn.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
        [_rearWheelBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rearWheelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_rearWheelBtn addTarget:self action:@selector(selectTireTypeEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rearWheelBtn;
}
- (UILabel *)certificationLab{
    if (!_certificationLab) {
        
        _certificationLab = [[UILabel alloc] init];
        _certificationLab.font = [UIFont systemFontOfSize:14.f];
        _certificationLab.text = @"行驶证认证（非必填选项）";
    }
    return _certificationLab;
}
- (UIImageView *)imgView{
    if (!_imgView) {
        
        _imgView = [[UIImageView alloc] init];
        _imgView.image = [UIImage imageNamed:@"ic_m_question"];
    }
    return _imgView;
}
- (UIButton *)certificationBtn{
    if (!_certificationBtn) {
        
        _certificationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_certificationBtn setTitle:@"未认证" forState:UIControlStateNormal];
        [_certificationBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [_certificationBtn.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
        [_certificationBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_certificationBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_certificationBtn addTarget:self action:@selector(certificationEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _certificationBtn;
}
- (UILabel *)mileageLab{
    if (!_mileageLab) {
        
        _mileageLab = [[UILabel alloc] init];
        _mileageLab.font = [UIFont systemFontOfSize:14.f];
        _mileageLab.text = @"行驶里程";
    }
    return _mileageLab;
}
- (UITextField *)mileageTextField{
    if (!_mileageTextField) {
        
        _mileageTextField = [[UITextField alloc] init];
        _mileageTextField.placeholder = @"请输入行驶里程";
        _mileageTextField.font = [UIFont systemFontOfSize:14.f];
        _mileageTextField.textAlignment = NSTextAlignmentRight;
        [_mileageTextField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _mileageTextField;
}
- (UILabel *)roadConditionLab{
    if (!_roadConditionLab) {
        
        _roadConditionLab = [[UILabel alloc] init];
        _roadConditionLab.font = [UIFont systemFontOfSize:14.f];
        _roadConditionLab.text = @"行驶路况";
    }
    return _roadConditionLab;
}
- (UIButton *)roadConditionBtn{
    if (!_roadConditionBtn) {
        
        _roadConditionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_roadConditionBtn setTitle:@"选择路况" forState:UIControlStateNormal];
        [_roadConditionBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [_roadConditionBtn.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
        [_roadConditionBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_roadConditionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_roadConditionBtn addTarget:self action:@selector(selectRoadEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _roadConditionBtn;
}
- (UILabel *)InvitationCodeLab{
    if (!_InvitationCodeLab) {
        
        _InvitationCodeLab = [[UILabel alloc] init];
        _InvitationCodeLab.font = [UIFont systemFontOfSize:14.f];
        _InvitationCodeLab.text = @"邀请码";
    }
    return _InvitationCodeLab;
}
- (UITextField *)InvitationCodeTextField{
    if (!_InvitationCodeTextField) {
        
        _InvitationCodeTextField = [[UITextField alloc] init];
        _InvitationCodeTextField.placeholder = @"请输入邀请码";
        _InvitationCodeTextField.font = [UIFont systemFontOfSize:14.f];
        _InvitationCodeTextField.textAlignment = NSTextAlignmentRight;
        [_InvitationCodeTextField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _InvitationCodeTextField;
}
- (UIView *)saveBtn{
    if (!_saveBtn) {
        
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _saveBtn.userInteractionEnabled = self.is_alter;
        if (self.is_alter) {
            [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
            [_saveBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        }
        [_saveBtn addTarget:self action:@selector(saveAndChangeCarInfoEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}
- (UIView *)backView{
    
    if (_backView == nil) {
        
        _backView = [[UIView alloc] initWithFrame:self.view.frame];
        _backView.backgroundColor = [UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:0.2];
        _backView.hidden = YES;
    }
    return _backView;
}
- (PlateLicenseView *)plateLicenseView{
    
    if (_plateLicenseView == nil) {
        
        _plateLicenseView = [[PlateLicenseView alloc] initWithFrame:CGRectMake(20, (MAINSCREEN.height - SafeDistance)/2-100, MAINSCREEN.width - 40, 200)];
        _plateLicenseView.backgroundColor = [UIColor whiteColor];
        _plateLicenseView.layer.cornerRadius = 4.0;
        _plateLicenseView.layer.masksToBounds = YES;
        [_plateLicenseView.sureBtn addTarget:self action:@selector(chickPlateSureBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _plateLicenseView;
}
- (FMDBCarTireInfo *)car_carTireInfo{
    
    if (_car_carTireInfo == nil) {
        
        _car_carTireInfo = [[FMDBCarTireInfo alloc] init];
    }
    return _car_carTireInfo;
}
- (CarInfo *)carInfo{
    
    if (_carInfo == nil) {
        
        _carInfo = [[CarInfo alloc] init];
    }
    return _carInfo;
}

///选择车牌
- (void)showPlateLicenseView{
    
    self.backView.hidden = NO;
}

///车牌确定操作
- (void)chickPlateSureBtn{
    self.backView.hidden = YES;
    NSInteger firstRow = [self.plateLicenseView.platePickview selectedRowInComponent:0];
    NSInteger secondRow = [self.plateLicenseView.platePickview selectedRowInComponent:1];
    NSString *regionStr = [self.plateLicenseView.regionArray objectAtIndex:firstRow];
    NSString *letterStr = [self.plateLicenseView.letterArray objectAtIndex:secondRow];
    
    NSString *carNumberString = [NSString stringWithFormat:@"%@%@%@", regionStr, letterStr, self.plateLicenseView.inputTF.text];

    NSLog(@"选择的车牌号为：%@",carNumberString);
    
    if (isNew) {
        
        if (self.plateLicenseView.inputTF.text.length == 6) {
            
            ///输入格式正确
            plat_number = carNumberString;

            [self.carNumberBtn setTitle:carNumberString forState:UIControlStateNormal];
            
        }else{
            
            [PublicClass showHUD:@"请输入正确新能源牌号" view:self.view];
        }
    }else{
        
        if (self.plateLicenseView.inputTF.text.length == 5) {
            
            ///输入格式正确
            plat_number = carNumberString;

            [self.carNumberBtn setTitle:carNumberString forState:UIControlStateNormal];
        }else{
            
            [PublicClass showHUD:@"请输入正确的车牌号" view:self.view];
        }
    }
}
///选择是否新能源
- (void)switchAction:(UISwitch *)is_switch{
    
    isNew = is_switch.isOn;
    
    [self.carNumberBtn setTitle:@"" forState:UIControlStateNormal];
}
///选择车辆类型
- (void)chickCarTypeBtn:(UIButton *)button{
    
    SelectBrandViewController *selectBrandVC = [[SelectBrandViewController alloc] init];
    [self.navigationController pushViewController:selectBrandVC animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}

///设置车辆类型
- (void)updateTypeStatus:(FMDBCarTireInfo *)carTireInfo{
    
    carID = [NSString stringWithFormat:@"%@",carTireInfo.tireInfoId];
    carName = carTireInfo.verhicle;
    
    self.car_carTireInfo = carTireInfo;
    
    [self.carBrandbtn setTitle:carTireInfo.verhicle forState:UIControlStateNormal];
    
    if ([[self.carInfo.carId stringValue] isEqualToString:@"0"]) {

        ///小程序添加的车辆 不做任何改变
    }else{
        
        ///选择完车辆信息 设置 前后轮信息
        [self.frontWheelBtn setTitle:carTireInfo.font forState:UIControlStateNormal];
        [self.rearWheelBtn setTitle:carTireInfo.rear forState:UIControlStateNormal];
        
        front = carTireInfo.font;
        rear = carTireInfo.rear;
    }
}

#pragma mark 选择常驻地区
- (void)selectAddressEvent:(UIButton *)sender{
    
    [[MOFSPickerManager shareManger] showMOFSAddressPickerWithTitle:nil cancelTitle:@"取消" commitTitle:@"完成" commitBlock:^(NSString *address, NSString *zipcode) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSArray *cityArr = [address componentsSeparatedByString:@"-"];
            
            NSString *province = cityArr[0] == NULL ? @"":cityArr[0];
            NSString *city = cityArr[1] == NULL ? @"":cityArr[1];
            NSString *area = cityArr[2] == NULL ? @"":cityArr[2];

            NSLog(@"省%@,市%@,区%@", province, city, area);
            
            if ([city isEqualToString:@""]) {
                
                NSArray *provinceDBArr = [DBRecorder getPro_City_id:province];
                
                if (provinceDBArr.count<=0) {
                    
                    [MBProgressHUD showTextMessage:@"当前省暂无对应ID！"];
                    return ;
                }
                FMDBPosition *position = [[DBRecorder getPro_City_id:province] objectAtIndex:0];
                pro_city_id = [NSString stringWithFormat:@"%@", position.positionId];
            }else{
                
                if ([area isEqualToString:@""]) {
                    
                    NSArray *cityDBArr = [DBRecorder getPro_City_id:city];
                    
                    if (cityDBArr.count<=0) {
                        
                        [MBProgressHUD showTextMessage:@"当前城市暂无对应ID！"];
                        return ;
                    }
                    FMDBPosition *position = [cityDBArr objectAtIndex:0];
                    pro_city_id = [NSString stringWithFormat:@"%@", position.positionId];
                }else{
                    
                    NSArray *areaDBArr = [DBRecorder getPro_City_id:area];
                    
                    if (areaDBArr.count<=0) {
                        
                        [MBProgressHUD showTextMessage:@"当前县区暂无对应ID！"];
                        return ;
                    }
                    FMDBPosition *position = [areaDBArr objectAtIndex:0];
                    pro_city_id = [NSString stringWithFormat:@"%@", position.positionId];
                }
            }
            
            proCityName = [NSString stringWithFormat:@"%@%@%@",province,city,area];
            
            [self.changZhuBtn setTitle:proCityName forState:UIControlStateNormal];
            
            NSLog(@"城市的ID：%@  城市名称：%@", pro_city_id,proCityName);
        });
    } cancelBlock:^{
        
    }];
}

#pragma mark 选择轮胎型号
- (void)selectTireTypeEvent:(UIButton *)sender{
    
    if (self.car_carTireInfo.name.length == 0 && self.is_alter == YES) {
        
        [PublicClass showHUD:@"请选择车型" view:self.view];
        return;
    }
    
    TireSpecificationViewController *tireSVC = [[TireSpecificationViewController alloc] init];
    tireSVC.specificationBlock = ^(NSString *text) {
        
        if ([sender isEqual:self.frontWheelBtn]) {
            
            [sender setTitle:text forState:UIControlStateNormal];
            [self.rearWheelBtn setTitle:text forState:UIControlStateNormal];
            
            front = text;
            rear = text;
        }else{
            
            [sender setTitle:text forState:UIControlStateNormal];
            rear = text;
        }
    };
    [self.navigationController pushViewController:tireSVC animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}

#pragma mark 行驶证认证
- (void)certificationEvent:(UIButton *)sender{
    
    if ([plat_number isEqualToString:@""]) {
        
        [MBProgressHUD showTextMessage:@"请先输入车牌号！"];
        return;
    }

    __block UIViewController * aipVC = [AipGeneralVC ViewControllerWithHandler:^(UIImage *image) {

        [MBProgressHUD showWaitMessage:@"正在识别..." showView:aipVC.view];
        
        [[AipOcrService shardService] detectVehicleLicenseFromImage:image withOptions:nil successHandler:^(id result) {
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                [MBProgressHUD hideWaitViewAnimated:aipVC.view];
                [MBProgressHUD showWaitMessage:@"开始认证..." showView:aipVC.view];
            }];

            NSString *discern_PlatNumber =  result[@"words_result"][@"号牌号码"][@"words"];
            ///比对车牌号
            if ([plat_number isEqualToString:discern_PlatNumber]) {
                ///是否是 修改车辆信息  是修改车辆信息 需要调用专门的认证接口 来进行认证
                if (self.is_alter == NO) {
                    
                    driving_license_date = result[@"words_result"][@"发证日期"][@"words"];
                    
                    NSMutableString *drivingLicenseDateMutable = [[NSMutableString alloc] initWithString:driving_license_date];
                    
                    [drivingLicenseDateMutable insertString:@"-" atIndex:4];
                    [drivingLicenseDateMutable insertString:@"-" atIndex:7];
                    
                    driving_license_date = drivingLicenseDateMutable;

                    ///认证成功
                    [JJRequest postRequest:@"/userCarInfo/updateAuthenticatedState" params:@{@"id":self.carInfo.carInfoid,@"drivingLicenseDateStr":driving_license_date,@"authenticatedState":@"1"} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
                        
                        if ([code longLongValue] == 1) {
                            
                            //比较当前修改车辆 是否是 默认车辆 如果是则修改全局字段
                            if ([UserConfig userCarId] == self.carInfo.carInfoid) {
                                
                                [UserConfig userDefaultsSetObject:@"1" key:@"kAuthenticatedState"];
                            }

                            authenticatedState = @"1";//认证成功
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                [MBProgressHUD hideWaitViewAnimated:aipVC.view];
                                [MBProgressHUD showTextMessage:@"认证成功！"];
                                [self.certificationBtn setTitle:@"已认证" forState:UIControlStateNormal];
                                
                                ///认证成功 禁止重新输入车牌号码
                                self.carNumberBtn.userInteractionEnabled = NO;
                                self.certificationBtn.userInteractionEnabled = NO;///禁止再次认证
                                [aipVC dismissViewControllerAnimated:YES completion:nil];
                            });
                            
                            [aipVC dismissViewControllerAnimated:YES completion:nil];
                        }else{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                [MBProgressHUD hideWaitViewAnimated:aipVC.view];
                                [MBProgressHUD showTextMessage:@"认证失败！"];
                            });
                        }
                    } failure:^(NSError * _Nullable error) {
                        
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            
                            [MBProgressHUD hideWaitViewAnimated:aipVC.view];
                            [MBProgressHUD showTextMessage:@"认证失败！"];
                        }];
                    }];
                    
                }else{
                    ///添加车辆 比对成功 即认证成功上传
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        
                        [MBProgressHUD hideWaitViewAnimated:aipVC.view];
                    }];

                    authenticatedState = @"1";//认证成功
                    driving_license_date = result[@"words_result"][@"发证日期"][@"words"];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                       
                        [self.certificationBtn setTitle:@"已认证" forState:UIControlStateNormal];
                        ///认证成功 禁止重新输入车牌号码
                        self.carNumberBtn.userInteractionEnabled = NO;
                        self.certificationBtn.userInteractionEnabled = NO;///禁止再次认证
                        [aipVC dismissViewControllerAnimated:YES completion:nil];
                    });
                }
            }else{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                   
                    [MBProgressHUD hideWaitViewAnimated:aipVC.view];
                    
                    [PublicClass showHUD:@"认证失败！" view:aipVC.view];
                });
            }
            
            
        } failHandler:^(NSError *err) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [MBProgressHUD hideWaitViewAnimated:aipVC.view];
                
                [PublicClass showHUD:@"识别失败！" view:aipVC.view];
            });
        }];
    }];

    [self presentViewController:aipVC animated:YES completion:nil];
}
-(BOOL)shouldAutorotate{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
///行驶里程
- (void)textFieldEditChanged:(UITextField*)textField{
    
    if ([textField isEqual:self.mileageTextField]) {
        
        traveled = textField.text;
    }else{
        
        invite_code = textField.text;
    }
    NSLog(@"textfield text %@",textField.text);
}
///选择路况
- (void)selectRoadEvent:(UIButton *)sender{
    
    RoadConditionViewController *roadCVC = [[RoadConditionViewController alloc] init];
    [self.navigationController pushViewController:roadCVC animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}

///设置路况
- (void)updateRoadStatusName:(NSString *)nameStr OftenId:(NSString *)oftenIdStr OnceId:(NSString *)onceIdStr NotId:(NSString *)notIdStr { 
    
//    NSLog(@"路况信息%@\n%@\n%@\n%@",nameStr,oftenIdStr,onceIdStr,notIdStr);
    road_text = nameStr;
    type_i_rate = oftenIdStr;
    type_ii_rate = onceIdStr;
    type_iii_rate = notIdStr;
    
    [self.roadConditionBtn setTitle:nameStr forState:UIControlStateNormal];
}

#pragma mark 获取当前车辆信息
///如果当前为修改车辆信息，则获取车辆信息
- (void)getCarInfoFromInternet{
    
    [MBProgressHUD showWaitMessage:@"正在获取车辆信息..." showView:self.view];
    
    NSDictionary *getCarInfoDic = @{@"userId":[NSString stringWithFormat:@"%@",[UserConfig user_id]], @"userCarId":self.user_car_idStr};
    
    NSString *getCarInforeqJson = [PublicClass convertToJsonData:getCarInfoDic];
    [JJRequest postRequest:@"getCarByUserIdAndCarId" params:@{@"reqJson":getCarInforeqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *mesgStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"-1"]) {
            
            [PublicClass showHUD:mesgStr view:self.view];
        }else{
            
            [self.carInfo setValuesForKeysWithDictionary:data];
            
            if ([self.carInfo.isNewenergy isEqualToNumber:[NSNumber numberWithInt:0]] || self.carInfo.isNewenergy == nil) {
                
                self.nEnergySwitch.on = NO;
                isNew = NO;
            }else{
                self.nEnergySwitch.on = YES;
                isNew = YES;
            }
            if ([self.carInfo.authenticatedState longLongValue] == 1) {
                
                [self.certificationBtn setTitle:@"已认证" forState:UIControlStateNormal];
                self.certificationBtn.userInteractionEnabled = NO;
            }else{
                [self.certificationBtn setTitle:@"未认证" forState:UIControlStateNormal];
            }
            [self.carBrandbtn setTitle:self.carInfo.carName forState:UIControlStateNormal];
            [self.carNumberBtn setTitle:self.carInfo.platNumber forState:UIControlStateNormal];
            [self.changZhuBtn setTitle:self.carInfo.proCityName forState:UIControlStateNormal];
            [self.fronlWheelBtn setTitle:self.carInfo.font forState:UIControlStateNormal];
            [self.rearWheelBtn setTitle:self.carInfo.rear forState:UIControlStateNormal];
            self.mileageTextField.text = [NSString stringWithFormat:@"%@",self.carInfo.traveled];
            [self.roadConditionBtn setTitle:self.carInfo.roadTxt forState:UIControlStateNormal];
            
            //赋初始值
            carID = [NSString stringWithFormat:@"%@",self.carInfo.carId];
            carName = self.carInfo.carName;
            plat_number = self.carInfo.platNumber;
            pro_city_id = [NSString stringWithFormat:@"%@",self.carInfo.proCityId];
            proCityName = self.carInfo.proCityName;
            front = self.carInfo.font;
            rear = self.carInfo.rear;
            serviceYearLength = [NSString stringWithFormat:@"%@",self.carInfo.serviceYearLength];
            traveled = [NSString stringWithFormat:@"%@",self.carInfo.traveled];
            authenticatedState = [NSString stringWithFormat:@"%@",self.carInfo.authenticatedState];
            
            if ([self.carInfo.drivingLicenseDate isEqual:[NSNull null]] || self.carInfo.drivingLicenseDate == nil || [self.carInfo.drivingLicenseDate isKindOfClass:[NSNull class]]) {
                
                driving_license_date = @"2000-01-01";
            }else{
                
                driving_license_date = [PublicClass timestampSwitchTime:[self.carInfo.drivingLicenseDate integerValue] andFormatter:@"YYYY-MM-dd"];
            }
            
            if (self.carInfo.serviceEndDate != NULL) {
                ///不可修改车辆信息状态
                
                if ([self.carInfo.carId longLongValue] == 0) {
                    
                    ///carID == 0 为小程序添加的车辆，小程序添加的车辆 不可修改前轮 与 车牌号 其他都可修改
                    self.fronlWheelBtn.userInteractionEnabled = NO;
                    self.carNumberBtn.userInteractionEnabled = NO;
                    self.nEnergySwitch.userInteractionEnabled = YES;
                    self.carBrandbtn.userInteractionEnabled = YES;
                    self.changZhuBtn.userInteractionEnabled = YES;
                    self.rearWheelBtn.userInteractionEnabled = YES;
                    self.roadConditionBtn.userInteractionEnabled = YES;
                    self.mileageTextField.userInteractionEnabled = YES;
                    self.saveBtn.userInteractionEnabled = YES;
                    [self.saveBtn setTitle:@"修改车辆信息" forState:UIControlStateNormal];
                    [self.saveBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
                }else{
                    
                    [self.saveBtn setTitle:@"车辆信息不可修改" forState:UIControlStateNormal];
                    [self.saveBtn setBackgroundColor:[UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:0.4] forState:UIControlStateNormal];
                }
                
                //如果车辆信息状态为不可修改  但车辆处于未认证状态 则可以 进行认证操作
                if ([self.carInfo.authenticatedState longLongValue] == 2) {
                    
                    self.certificationBtn.userInteractionEnabled = YES;
                }
            }else{
                ///可修改车辆信息状态
                
                if ([self.carInfo.carId longLongValue] == 0) {
                    ///carID == 0 为小程序添加的车辆，小程序添加的车辆 不可修改前轮 与 车牌号
                    self.fronlWheelBtn.userInteractionEnabled = NO;
                    self.carNumberBtn.userInteractionEnabled = NO;
                }else{
                    
                    ///只有车辆为未认证状态 才可以进行认证 才可以输入车牌号
                    if ([self.carInfo.authenticatedState longLongValue] == 2) {
                        
                        self.certificationBtn.userInteractionEnabled = YES;
                        self.carNumberBtn.userInteractionEnabled = YES;
                    }
                    self.fronlWheelBtn.userInteractionEnabled = YES;
                }
                
                self.nEnergySwitch.userInteractionEnabled = YES;
                self.carBrandbtn.userInteractionEnabled = YES;
                self.changZhuBtn.userInteractionEnabled = YES;
                self.rearWheelBtn.userInteractionEnabled = YES;
                self.roadConditionBtn.userInteractionEnabled = YES;
                self.mileageTextField.userInteractionEnabled = YES;
                self.saveBtn.userInteractionEnabled = YES;
                
                [self.saveBtn setTitle:@"修改车辆信息" forState:UIControlStateNormal];
                [self.saveBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
            }
        }
        
        [MBProgressHUD hideWaitViewAnimated:self.view];
    } failure:^(NSError * _Nullable error) {
        
        [MBProgressHUD hideWaitViewAnimated:self.view];

        NSLog(@"获取用户车辆信息错误:%@", error);
    }];
}

#pragma makr 添加修改车辆事件
- (void)saveAndChangeCarInfoEvent:(UIButton *)sender{
    NSDictionary *dic;
    

    if ([traveled isEqualToString:@""]) {
        
        [MBProgressHUD showTextMessage:@"请输入行驶里程!"];
        return;
    }
    if ([pro_city_id isEqualToString:@""] || [proCityName isEqualToString:@""]) {
        
        [MBProgressHUD showTextMessage:@"请输入常驻地区!"];
        return;
    }
    if ([front isEqualToString:@""]) {
        
        [MBProgressHUD showTextMessage:@"前轮型号不能为空！"];
        return;
    }
    if ([rear isEqualToString:@""]) {
        
        [MBProgressHUD showTextMessage:@"后轮型号不能为空！"];
        return;
    }
    
    if ([sender.titleLabel.text isEqualToString:@"保存"]) {
    
        if ([type_i_rate isEqualToString:@""] && [type_ii_rate isEqualToString:@""] && [type_iii_rate isEqualToString:@""]) {
            
            [MBProgressHUD showTextMessage:@"请选择行驶路况！"];
            return;
        }
        
        ///添加车辆
        dic =@{@"userId":[UserConfig user_id], @"car_id":carID, @"xinnengyuan":isNew == NO ? @"false" : @"true", @"plat_number":plat_number, @"pro_city_id":pro_city_id, @"font":front, @"rear":rear, @"driving_license_date":driving_license_date,@"serviceYearLength":@(1), @"type_i_rate":type_i_rate, @"type_ii_rate":type_ii_rate, @"type_iii_rate":type_iii_rate, @"traveled":traveled, @"invite_code":invite_code, @"car_name":carName, @"proCityName":proCityName, @"road_txt":road_text,@"authenticatedState":authenticatedState};
        
        [self commitInternetWithDic:dic];
    }else{
        

        ///修改车辆
        dic =@{@"userId":[UserConfig user_id], @"id":self.carInfo.carInfoid, @"carId":carID, @"isNewenergy":isNew == NO ? @(0) : @(1), @"platNumber":plat_number, @"proCityId":pro_city_id, @"font":front, @"rear":rear, @"drivingLicenseDate":driving_license_date, @"serviceYearLength":serviceYearLength,@"type_i_rate":type_i_rate, @"type_ii_rate":type_ii_rate, @"type_iii_rate":type_iii_rate, @"traveled":traveled, @"carName":carName, @"proCityName":proCityName, @"roadTxt":road_text,@"authenticatedState":authenticatedState};
        
        [self updateUserCarInfo:dic];
    }
}

#pragma mark 修改车辆信息事件
- (void)updateUserCarInfo:(NSDictionary *)dic{
    
    [MBProgressHUD showWaitMessage:@"正在修改车辆信息..." showView:self.view];
    
    NSString *reqJson = [PublicClass convertToJsonData:dic];
    [JJRequest postRequest:@"userCar/updateUserCarInfo" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        [MBProgressHUD hideWaitViewAnimated:self.view];
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            DelegateConfiguration *delegateConfiguration = [DelegateConfiguration sharedConfiguration];
            
            [delegateConfiguration changeaddCarNumber];
            [delegateConfiguration unregisterRoadStatusChangedListener:self];
            [delegateConfiguration unregisterCartypeStatusChangeListener:self];
            
            bool isVc = NO;
            
            for (int i = 0; i<self.navigationController.viewControllers.count; i++) {
                
                if ([[[self.navigationController.viewControllers objectAtIndex:i] class] isEqual:[BuyCommdityViewController class]]) {
                    
                    isVc = YES;
                    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:i] animated:YES];
                }
            }
            
            if (isVc == NO) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        [MBProgressHUD hideWaitViewAnimated:self.view];

        NSLog(@"修改用户车辆信息错误:%@", error);
    }];
}

#pragma mark 添加车辆事件
- (void)commitInternetWithDic:(NSDictionary *)dic{
    
    NSString *reqJson = [PublicClass convertToJsonData:dic];
    [JJRequest postRequest:@"addUserCar" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        NSArray *couponArr = (NSArray *)data;
        if ([statusStr isEqualToString:@"1"]) {
            
            [UserConfig userDefaultsSetObject:@"1" key:@"firstAddCar"];
            
            DelegateConfiguration *delegateConfiguration = [DelegateConfiguration sharedConfiguration];

            [delegateConfiguration changeaddCarNumber];
            [delegateConfiguration unregisterRoadStatusChangedListener:self];
            [delegateConfiguration unregisterCartypeStatusChangeListener:self];
            
            if (couponArr.count<=0) {
                
                bool isVc = NO;
                
                for (int i = 0; i<self.navigationController.viewControllers.count; i++) {
                    
                    if ([[[self.navigationController.viewControllers objectAtIndex:i] class] isEqual:[BuyCommdityViewController class]]) {
                        
                        isVc = YES;
                        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:i] animated:YES];
                    }
                }
                
                if (isVc == NO) {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
                return ;
            }
            //两种优惠券
            JJCouponView *couponView = [[JJCouponView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height)];
            couponView.counponListArr = couponArr;
            couponView.popBlock = ^{
                
                bool isVc = NO;
                
                for (int i = 0; i<self.navigationController.viewControllers.count; i++) {
                    
                    if ([[[self.navigationController.viewControllers objectAtIndex:i] class] isEqual:[BuyCommdityViewController class]]) {
                        
                        isVc = YES;
                        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:i] animated:YES];
                    }
                }
                
                if (isVc == NO) {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            };
            [couponView show];
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"添加车辆错误:%@", error);
    }];
}

@end

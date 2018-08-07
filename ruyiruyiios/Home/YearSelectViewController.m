//
//  YearSelectViewController.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/8/2.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "YearSelectViewController.h"
#import "ChoicePatternViewController.h"
#import "SelectTirePositionViewController.h"
#import "JJSliderView.h"
#import "MBProgressHUD+YYM_category.h"
#import <Masonry.h>
@interface YearSelectViewController ()

@property(nonatomic,strong)JJSliderView *sliderView;

@property(nonatomic,strong)UIImageView  *imgView;

@property(nonatomic,strong)UIImageView  *yearImgView;

@property(nonatomic,strong)UIButton     *nextStep;

@property(nonatomic,strong)UILabel      *titleLab;

@end

@implementation YearSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择服务年限";
    self.view.backgroundColor = [UIColor colorWithRed:230.f/255.f green:230.f/255.f blue:230.f/255.f alpha:1.f];
    
    [self.view addSubview:self.imgView];
    [self.view addSubview:self.yearImgView];
    [self.view addSubview:self.nextStep];
    [self.yearImgView addSubview:self.titleLab];
    [self.yearImgView addSubview:self.sliderView];
    
    [self setSubViewFrame];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
}

-(void)setSubViewFrame{
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        if (@available(iOS 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).inset(10);
        } else {
            make.top.mas_equalTo(self.view.mas_top).inset(10);
        }
        
        make.left.and.right.mas_equalTo(self.view).inset(5);
        make.height.mas_equalTo(self.view).multipliedBy(0.3);
    }];
    
    [self.yearImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.and.right.mas_equalTo(self.view).inset(5);
        make.top.mas_equalTo(self.imgView.mas_bottom).inset(10);
        make.height.mas_equalTo(self.imgView.mas_height).multipliedBy(0.5);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.yearImgView.mas_top).inset(10);
        make.left.mas_equalTo(self.yearImgView.mas_left).inset(10);
        make.height.mas_equalTo(@20);
    }];
    
    [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.leading.and.trailing.mas_equalTo(self.yearImgView).inset(10);
        make.top.mas_equalTo(self.titleLab.mas_bottom).inset(5);
        make.bottom.mas_equalTo(self.yearImgView.mas_bottom);
    }];
    
    [self.nextStep mas_makeConstraints:^(MASConstraintMaker *make) {
       
        if (@available(iOS 11.0, *)) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).inset(5);
        } else {
            make.bottom.mas_equalTo(self.view.mas_bottom).inset(5);
        }
        make.left.and.right.mas_equalTo(self.view).inset(16);
        make.height.mas_equalTo(@40);
    }];
}

-(void)nextStepPushViewController{
    
    
    if ([UserConfig token].length == 0 || ![UserConfig user_id]) {
        
        [PublicClass showHUD:@"请先登录" view:self.view];
        return;
    }
    
    if (![UserConfig userCarId] || !self.data_cars.car_id) {
        
        [PublicClass showHUD:@"没有车辆或者车辆信息获取失败！" view:self.view];
        return;
    }
    
    NSNumber *serviceYears = @([self.sliderView.currentValueStr integerValue]);
    
    if ([self.sliderView.currentValueStr integerValue] == 0) {
        
        [PublicClass showHUD:@"请选择服务年限!" view:self.view];
        return;
    }
    
    [MBProgressHUD showWaitMessage:@"正在设置服务年限.." showView:self.view];

    NSDictionary *params = @{@"userId":[UserConfig user_id],@"id":[UserConfig userCarId],@"carId":self.data_cars.car_id,@"serviceYearLength":serviceYears};
    
    [JJRequest postRequest:@"/userCar/updateUserCarInfo" params:@{@"reqJson":[PublicClass convertToJsonData:params],@"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
//        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        
        if ([code longLongValue] == 1) {
            
            if ([self.data_cars.font isEqualToString:self.data_cars.rear]) {
                
                ChoicePatternViewController *choicePVC = [[ChoicePatternViewController alloc] init];
                choicePVC.tireSize = self.data_cars.font;
                choicePVC.fontRearFlag = @"0";
                [self.navigationController pushViewController:choicePVC animated:YES];
            }else{
                
                SelectTirePositionViewController *selectTPVC = [[SelectTirePositionViewController alloc] init];
                selectTPVC.dataCars = self.data_cars;
                [self.navigationController pushViewController:selectTPVC animated:YES];
            }
        }else if ([statusStr isEqualToString:@"-999"]){
            
            [self alertIsequallyTokenView];
        }else{
            
        }
    
        [MBProgressHUD hideWaitViewAnimated:self.view];
    } failure:^(NSError * _Nullable error) {
        
        [MBProgressHUD hideWaitViewAnimated:self.view];
    }];
}

-(UIButton *)nextStep{
    
    if (!_nextStep) {
        
        _nextStep = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextStep setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextStep setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [_nextStep setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextStep addTarget:self action:@selector(nextStepPushViewController) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _nextStep;
}

-(void)setMaximumYears:(NSString *)maximumYears{
    
    self.sliderView.maxiNum = [maximumYears floatValue];   
}

-(JJSliderView *)sliderView{
    
    if (!_sliderView) {
        
        _sliderView = [[JJSliderView alloc] init];
    }
    return _sliderView;
}

-(UIImageView *)imgView{
    
    if (!_imgView) {
        
        _imgView = [[UIImageView alloc] init];
        _imgView.image = [UIImage imageNamed:@"ic_xuanze_fuwu"];
//        _imgView.contentMode = UIViewContentModeCenter;
    }
    return _imgView;
}

-(UIImageView *)yearImgView{
    
    if (!_yearImgView) {
        
        _yearImgView = [[UIImageView alloc] init];
        _yearImgView.userInteractionEnabled = YES;
        _yearImgView.image = [UIImage imageNamed:@"ic_xuanze_zhou"];
//        _yearImgView.contentMode = UIViewContentModeCenter;
    }
    
    
    return _yearImgView;
}

-(UILabel *)titleLab{
    
    if (!_titleLab) {
        
        _titleLab = [[UILabel alloc] init];
        _titleLab.text = @"服务年限";
        _titleLab.textColor = TEXTCOLOR64;
    }
    return _titleLab;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

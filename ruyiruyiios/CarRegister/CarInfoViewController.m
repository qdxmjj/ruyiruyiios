//
//  CarInfoViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/18.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "CarInfoViewController.h"
#import "TopCarInfoTableViewCell.h"
#import "BottomCarInfoTableViewCell.h"
#import "SelectBrandViewController.h"
#import "RoadConditionViewController.h"
#import "DelegateConfiguration.h"
#import "WXZPickDateView.h"
#import "WXZCustomPickView.h"
#import "AddressPickerView.h"
#import "DBRecorder.h"
#import "TireSpecificationViewController.h"
#import "PlateLicenseView.h"
#import "CarInfo.h"
#import <UIButton+WebCache.h>
#import "MBProgressHUD+YYM_category.h"
#import "JJCouponView.h"
@interface CarInfoViewController ()<UITableViewDelegate, UITableViewDataSource, RoadStatusDelegate, CartypeStatusDelegate, PickerDateViewDelegate, AddressPickerViewDelegate>{
    
    CGFloat y, height;
    int selectYear, nowYear, nowMonth, nowDay;
    BOOL isNew;
    NSString *isodomter, *carroadStr, *dateStr, *addressStr, *resultPlateStr, *pro_city_id, *pro_city_name;
    NSString *fontStr, *rearStr;
    NSString *oftenId, *onceId, *notId;
    
    
    ///选择器默认选中的位置
    NSInteger frontItem1Row, frontItem2Row, frontItem3Row;
    NSInteger rearItem1Row, rearItem2Row, rearItem3Row;

}

@property(nonatomic, strong)UIView *firstView;
@property(nonatomic, strong)UILabel *promptLabel;
@property(nonatomic, strong)UITableView *carInfoTV;
@property(nonatomic, strong)UIView *saveView;
@property(nonatomic, strong)UIButton *saveBtn;
@property(nonatomic, strong)FMDBCarTireInfo *car_carTireInfo;
@property(nonatomic, strong)NSMutableArray *customMutableA;
@property(nonatomic, strong)AddressPickerView *areaPickerView;
@property(nonatomic, strong)PlateLicenseView *plateLicenseView;
@property(nonatomic, strong)UIView *backView;
@property(nonatomic, strong)NSDictionary *commitPostDic;
@property(nonatomic, strong)CarInfo *carInfo;
@property(nonatomic, strong)NSString *updateFlagStr;

@property(nonatomic, strong)DelegateConfiguration *delegateConfiguration;
@end

@implementation CarInfoViewController
@synthesize user_car_idStr;
@synthesize is_alter;

- (UIView *)firstView{
    
    if (_firstView == nil) {
        
        _firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, 42.0)];
        _firstView.backgroundColor = [UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:0.1];
    }
    return _firstView;
}

- (UILabel *)promptLabel{
    
    if (_promptLabel == nil) {
        
        _promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [_promptLabel setNumberOfLines:0];
        _promptLabel.text = @"温馨提示：如驿如意为您的爱车提供个性化服务，需要了解你的车辆的详细信息，请如实填写。";
//        _promptLabel.backgroundColor = [UIColor whiteColor];
        _promptLabel.font = [UIFont fontWithName:TEXTFONT size:12.0];
        _promptLabel.textColor = TEXTCOLOR64;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:_promptLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        CGSize labelsize = [_promptLabel.text boundingRectWithSize:CGSizeMake(MAINSCREEN.width-20, MAINSCREEN.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        height = labelsize.height;
        [_promptLabel setFrame:CGRectMake(10, y, labelsize.width, labelsize.height)];
        [self.view addSubview:_promptLabel];
    }
    return _promptLabel;
}

- (UITableView *)carInfoTV{
    
    if (_carInfoTV == nil) {
        
        _carInfoTV = [[UITableView alloc] initWithFrame:CGRectMake(0, y+height+8, MAINSCREEN.width, MAINSCREEN.height - (y+height+8) - SafeDistance - 50) style:UITableViewStylePlain];
        NSLog(@"%f", MAINSCREEN.height - (y+height+8) - 114);
        _carInfoTV.bounces = NO;
        _carInfoTV.delegate = self;
        _carInfoTV.dataSource = self;
        _carInfoTV.backgroundColor = [UIColor whiteColor];
        _carInfoTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _carInfoTV;
}

- (UIView *)saveView{
    
    if (_saveView == nil) {
        
        _saveView = [[UIView alloc] initWithFrame:CGRectMake(0, MAINSCREEN.height - SafeDistance - 50, MAINSCREEN.width, 50)];
        _saveView.backgroundColor = [UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:0.1];
    }
    return _saveView;
}

- (UIButton *)saveBtn{
    
    if (_saveBtn == nil) {
        
        _saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 8, MAINSCREEN.width - 20, 34)];
        _saveBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _saveBtn.layer.cornerRadius = 8.0;
        _saveBtn.layer.masksToBounds = YES;
        [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _saveBtn.userInteractionEnabled = is_alter;
        if (is_alter) {
            
            [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
            [_saveBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        }
        [_saveBtn addTarget:self action:@selector(chickSaveBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}

- (FMDBCarTireInfo *)car_carTireInfo{
    
    if (_car_carTireInfo == nil) {
        
        _car_carTireInfo = [[FMDBCarTireInfo alloc] init];
    }
    return _car_carTireInfo;
}

- (NSMutableArray *)customMutableA{
    
    if (_customMutableA == nil) {
        
        _customMutableA = [[NSMutableArray alloc] init];
    }
    return _customMutableA;
}

- (AddressPickerView *)areaPickerView{
    if (!_areaPickerView) {
        _areaPickerView = [[AddressPickerView alloc]init];
        _areaPickerView.delegate = self;
        [_areaPickerView setTitleHeight:30 pickerViewHeight:215];
        // 关闭默认支持打开上次的结果
        //        _pickerView.isAutoOpenLast = NO;
    }
    return _areaPickerView;
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

- (void)chickPlateSureBtn{
    
    self.backView.hidden = YES;
    NSInteger firstRow = [self.plateLicenseView.platePickview selectedRowInComponent:0];
    NSInteger secondRow = [self.plateLicenseView.platePickview selectedRowInComponent:1];
    NSString *regionStr = [self.plateLicenseView.regionArray objectAtIndex:firstRow];
    NSString *letterStr = [self.plateLicenseView.letterArray objectAtIndex:secondRow];
    resultPlateStr = [NSString stringWithFormat:@"%@%@%@", regionStr, letterStr, self.plateLicenseView.inputTF.text];
    if (isNew) {
        
        if (self.plateLicenseView.inputTF.text.length == 6) {
            
            [_carInfoTV reloadData];
        }else{
            
            [PublicClass showHUD:@"请输入正确新能源牌号" view:self.view];
        }
    }else{
        
        if (self.plateLicenseView.inputTF.text.length == 5) {
            
            [_carInfoTV reloadData];
        }else{
            
            [PublicClass showHUD:@"请输入正确的车牌号" view:self.view];
        }
    }
}

- (UIView *)backView{
    
    if (_backView == nil) {
        
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height)];
        _backView.backgroundColor = [UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:0.2];
        _backView.hidden = YES;
    }
    return _backView;
}

- (NSDictionary *)commitPostDic{
    
    if (_commitPostDic == nil) {
        
        _commitPostDic = [[NSDictionary alloc] init];
    }
    return _commitPostDic;
}

- (CarInfo *)carInfo{
    
    if (_carInfo == nil) {
        
        _carInfo = [[CarInfo alloc] init];
    }
    return _carInfo;
}

- (void)chickSaveBtn{
    
    if ([self.saveBtn.titleLabel.text isEqualToString:@"保存"]) {
        
        NSString *useridStr = [NSString stringWithFormat:@"%@", [UserConfig user_id]];
        BottomCarInfoTableViewCell *bottomCell = [_carInfoTV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            
        if (resultPlateStr.length == 0 || fontStr.length == 0 || rearStr.length == 0 || dateStr.length == 0 || addressStr.length == 0 || bottomCell.kilometerTF.text.length == 0 || carroadStr.length == 0) {
            
            [PublicClass showHUD:@"输入信息不能为空!" view:self.view];
        }else{
            
            if (isNew) {
                
                if (self.plateLicenseView.inputTF.text.length == 6) {
                    //@"serviceYearLength":[serviceCutoffStr substringWithRange:NSMakeRange(0, serviceCutoffStr.length - 2)],
                    self.commitPostDic =@{@"userId":useridStr, @"car_id":self.car_carTireInfo.tireInfoId, @"xinnengyuan":@"true", @"plat_number":resultPlateStr, @"pro_city_id":pro_city_id, @"font":fontStr, @"rear":rearStr, @"driving_license_date":dateStr,  @"type_i_rate":oftenId,@"serviceYearLength":@(1),@"type_ii_rate":onceId, @"type_iii_rate":notId, @"traveled":bottomCell.kilometerTF.text, @"invite_code":bottomCell.codeTF.text, @"car_name":self.car_carTireInfo.verhicle, @"proCityName":addressStr, @"road_txt":carroadStr};
                    [self commitInternetWithDic:self.commitPostDic];
                }else{
                    
                    [PublicClass showHUD:@"请输入正确的新能源车牌号" view:self.view];
                }
            }else{
                
                if (self.plateLicenseView.inputTF.text.length == 5) {
                    
//                    NSLog(@"%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@", useridStr, self.car_carTireInfo.tireInfoId, resultPlateStr, pro_city_id, fontStr, rearStr, dateStr, serviceCutoffStr, oftenId, onceId, notId, bottomCell.kilometerTF.text, self.car_carTireInfo.verhicle);
                    self.commitPostDic =@{@"userId":useridStr, @"car_id":self.car_carTireInfo.tireInfoId, @"xinnengyuan":@"false", @"plat_number":resultPlateStr, @"pro_city_id":pro_city_id, @"font":fontStr, @"rear":rearStr, @"driving_license_date":dateStr,@"serviceYearLength":@(1), @"type_i_rate":oftenId, @"type_ii_rate":onceId, @"type_iii_rate":notId, @"traveled":bottomCell.kilometerTF.text, @"invite_code":bottomCell.codeTF.text, @"car_name":self.car_carTireInfo.verhicle, @"proCityName":addressStr, @"road_txt":carroadStr};
                    [self commitInternetWithDic:self.commitPostDic];
                }else{
                    
                    [PublicClass showHUD:@"请输入正确的车牌号" view:self.view];
                }
            }
        }
    }else{
        
        NSLog(@"点击了修改车辆按钮");
        NSLog(@"%@", self.car_carTireInfo.tireInfoId);
        NSString *useridStr = [NSString stringWithFormat:@"%@", [UserConfig user_id]];
        BottomCarInfoTableViewCell *bottomCell = [_carInfoTV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        if (resultPlateStr.length == 0 || fontStr.length == 0 || rearStr.length == 0 || dateStr.length == 0 || addressStr.length == 0 || bottomCell.kilometerTF.text.length == 0 || carroadStr.length == 0) {
            
            [PublicClass showHUD:@"输入信息不能为空!" view:self.view];
        }else{
            
            if (isNew) {
                
                if (resultPlateStr.length == 8) {
                    
                    //id为返回的ID
                    if (self.car_carTireInfo.tireInfoId == NULL) {
                        
                        if (self.car_carTireInfo.verhicle == NULL) {
                            
                            if ([oftenId isEqualToString:@""] && [onceId isEqualToString:@""] && [notId isEqualToString:@""]) {
                                
                                self.commitPostDic =@{@"userId":useridStr, @"id":[NSString stringWithFormat:@"%@", self.carInfo.carInfoid], @"carId":[NSString stringWithFormat:@"%@", self.carInfo.carId], @"isNewenergy":[NSNumber numberWithInt:1], @"platNumber":resultPlateStr, @"proCityId":pro_city_id, @"font":fontStr, @"rear":rearStr, @"drivingLicenseDate":dateStr, @"serviceYearLength":self.carInfo.serviceYearLength, @"type_i_rate":@"", @"type_ii_rate":@"", @"type_iii_rate":@"", @"traveled":bottomCell.kilometerTF.text, @"carName":self.carInfo.carName, @"proCityName":addressStr, @"roadTxt":@""};
                            }else{
                                
                                self.commitPostDic =@{@"userId":useridStr, @"id":[NSString stringWithFormat:@"%@", self.carInfo.carInfoid], @"carId":[NSString stringWithFormat:@"%@", self.carInfo.carId], @"isNewenergy":[NSNumber numberWithInt:1], @"platNumber":resultPlateStr, @"proCityId":pro_city_id, @"font":fontStr, @"rear":rearStr, @"drivingLicenseDate":dateStr, @"serviceYearLength":self.carInfo.serviceYearLength, @"type_i_rate":oftenId, @"type_ii_rate":onceId, @"type_iii_rate":notId, @"traveled":bottomCell.kilometerTF.text, @"carName":self.carInfo.carName, @"proCityName":addressStr, @"roadTxt":carroadStr};
                            }
                        }else{
                            
                            if (self.car_carTireInfo.verhicle == NULL) {
                                
                                if ([oftenId isEqualToString:@""] && [onceId isEqualToString:@""] && [notId isEqualToString:@""]) {
                                    
                                    self.commitPostDic =@{@"userId":useridStr, @"id":[NSString stringWithFormat:@"%@", self.carInfo.carInfoid], @"carId":[NSString stringWithFormat:@"%@", self.carInfo.carId], @"isNewenergy":[NSNumber numberWithInt:1], @"platNumber":resultPlateStr, @"proCityId":pro_city_id, @"font":fontStr, @"rear":rearStr, @"drivingLicenseDate":dateStr, @"type_i_rate":@"",@"serviceYearLength":self.carInfo.serviceYearLength, @"type_ii_rate":@"", @"type_iii_rate":@"", @"traveled":bottomCell.kilometerTF.text, @"carName":self.carInfo.carName, @"proCityName":addressStr, @"roadTxt":@""};
                                }else{
                                    
                                    self.commitPostDic =@{@"userId":useridStr, @"id":[NSString stringWithFormat:@"%@", self.carInfo.carInfoid], @"carId":[NSString stringWithFormat:@"%@", self.carInfo.carId], @"isNewenergy":[NSNumber numberWithInt:1], @"platNumber":resultPlateStr, @"proCityId":pro_city_id, @"font":fontStr, @"rear":rearStr, @"drivingLicenseDate":dateStr,  @"type_i_rate":oftenId,@"serviceYearLength":self.carInfo.serviceYearLength, @"type_ii_rate":onceId, @"type_iii_rate":notId, @"traveled":bottomCell.kilometerTF.text, @"carName":self.carInfo.carName, @"proCityName":addressStr, @"roadTxt":carroadStr};
                                }
                            }else{
                                
                                if ([oftenId isEqualToString:@""] && [onceId isEqualToString:@""] && [notId isEqualToString:@""]) {
                                    
                                    self.commitPostDic =@{@"userId":useridStr, @"id":[NSString stringWithFormat:@"%@", self.carInfo.carInfoid], @"carId":[NSString stringWithFormat:@"%@", self.carInfo.carId], @"isNewenergy":[NSNumber numberWithInt:1], @"platNumber":resultPlateStr, @"proCityId":pro_city_id, @"font":fontStr, @"rear":rearStr, @"drivingLicenseDate":dateStr,  @"type_i_rate":@"",@"serviceYearLength":self.carInfo.serviceYearLength, @"type_ii_rate":@"", @"type_iii_rate":@"", @"traveled":bottomCell.kilometerTF.text,  @"carName":self.car_carTireInfo.verhicle, @"proCityName":addressStr, @"roadTxt":@""};
                                }else{
                                    
                                    self.commitPostDic =@{@"userId":useridStr, @"id":[NSString stringWithFormat:@"%@", self.carInfo.carInfoid], @"carId":[NSString stringWithFormat:@"%@", self.carInfo.carId], @"isNewenergy":[NSNumber numberWithInt:1], @"platNumber":resultPlateStr, @"proCityId":pro_city_id, @"font":fontStr, @"rear":rearStr, @"drivingLicenseDate":dateStr,  @"type_i_rate":oftenId,@"serviceYearLength":self.carInfo.serviceYearLength, @"type_ii_rate":onceId, @"type_iii_rate":notId, @"traveled":bottomCell.kilometerTF.text, @"carName":self.car_carTireInfo.verhicle, @"proCityName":addressStr, @"roadTxt":carroadStr};
                                }
                            }
                        }
                    }else{
                        
                        if (self.car_carTireInfo.verhicle == NULL) {
                            
                            if ([oftenId isEqualToString:@""] && [onceId isEqualToString:@""] && [notId isEqualToString:@""]) {
                                
                                self.commitPostDic =@{@"userId":useridStr, @"id":[NSString stringWithFormat:@"%@", self.carInfo.carInfoid], @"carId":self.car_carTireInfo.tireInfoId, @"isNewenergy":[NSNumber numberWithInt:1], @"platNumber":resultPlateStr, @"proCityId":pro_city_id, @"font":fontStr, @"rear":rearStr, @"drivingLicenseDate":dateStr,@"serviceYearLength":self.carInfo.serviceYearLength,  @"type_i_rate":@"", @"type_ii_rate":@"", @"type_iii_rate":@"", @"traveled":bottomCell.kilometerTF.text, @"carName":self.carInfo.carName, @"proCityName":addressStr, @"roadTxt":@""};
                            }else{
                                
                                self.commitPostDic =@{@"userId":useridStr, @"id":[NSString stringWithFormat:@"%@", self.carInfo.carInfoid], @"carId":self.car_carTireInfo.tireInfoId, @"isNewenergy":[NSNumber numberWithInt:1], @"platNumber":resultPlateStr, @"proCityId":pro_city_id, @"font":fontStr, @"rear":rearStr, @"drivingLicenseDate":dateStr,@"serviceYearLength":self.carInfo.serviceYearLength, @"type_i_rate":oftenId, @"type_ii_rate":onceId, @"type_iii_rate":notId, @"traveled":bottomCell.kilometerTF.text, @"carName":self.carInfo.carName, @"proCityName":addressStr, @"roadTxt":carroadStr};
                            }
                        }else{
                            
                            if ([oftenId isEqualToString:@""] && [onceId isEqualToString:@""] && [notId isEqualToString:@""]) {
                                
                                self.commitPostDic =@{@"userId":useridStr, @"id":[NSString stringWithFormat:@"%@", self.carInfo.carInfoid], @"carId":self.car_carTireInfo.tireInfoId, @"isNewenergy":[NSNumber numberWithInt:1], @"platNumber":resultPlateStr, @"proCityId":pro_city_id, @"font":fontStr, @"rear":rearStr, @"drivingLicenseDate":dateStr, @"serviceYearLength":self.carInfo.serviceYearLength, @"type_i_rate":@"", @"type_ii_rate":@"", @"type_iii_rate":@"", @"traveled":bottomCell.kilometerTF.text, @"carName":self.car_carTireInfo.verhicle, @"proCityName":addressStr, @"roadTxt":@""};
                            }else{
                                
                                self.commitPostDic =@{@"userId":useridStr, @"id":[NSString stringWithFormat:@"%@", self.carInfo.carInfoid], @"carId":self.car_carTireInfo.tireInfoId, @"isNewenergy":[NSNumber numberWithInt:1], @"platNumber":resultPlateStr, @"proCityId":pro_city_id, @"font":fontStr, @"rear":rearStr, @"drivingLicenseDate":dateStr, @"serviceYearLength":self.carInfo.serviceYearLength, @"type_i_rate":oftenId, @"type_ii_rate":onceId, @"type_iii_rate":notId, @"traveled":bottomCell.kilometerTF.text, @"carName":self.car_carTireInfo.verhicle, @"proCityName":addressStr, @"roadTxt":carroadStr};
                            }
                        }
                    }
                    [self updateUserCarInfo:self.commitPostDic];
                }else{
                    
                    [PublicClass showHUD:@"请输入正确的新能源车牌号" view:self.view];
                }
            }else{
                
                if (resultPlateStr.length == 7) {
                    
                    //id为返回的ID
                    if (self.car_carTireInfo.tireInfoId == NULL) {
                        
                        if (self.car_carTireInfo.verhicle == NULL) {
                            
                            if ([oftenId isEqualToString:@""] && [onceId isEqualToString:@""] && [notId isEqualToString:@""]) {
                                
                                self.commitPostDic =@{@"userId":useridStr, @"id":[NSString stringWithFormat:@"%@", self.carInfo.carInfoid], @"carId":[NSString stringWithFormat:@"%@", self.carInfo.carId], @"isNewenergy":[NSNumber numberWithInt:0], @"platNumber":resultPlateStr, @"proCityId":pro_city_id, @"font":fontStr, @"rear":rearStr, @"drivingLicenseDate":dateStr, @"serviceYearLength":self.carInfo.serviceYearLength, @"type_i_rate":@"", @"type_ii_rate":@"", @"type_iii_rate":@"", @"traveled":bottomCell.kilometerTF.text, @"carName":self.carInfo.carName, @"proCityName":addressStr, @"roadTxt":@""};
                            }else{
                                
                                self.commitPostDic =@{@"userId":useridStr, @"id":[NSString stringWithFormat:@"%@", self.carInfo.carInfoid], @"carId":[NSString stringWithFormat:@"%@", self.carInfo.carId], @"isNewenergy":[NSNumber numberWithInt:0], @"platNumber":resultPlateStr, @"proCityId":pro_city_id, @"font":fontStr, @"rear":rearStr, @"drivingLicenseDate":dateStr, @"serviceYearLength":self.carInfo.serviceYearLength, @"type_i_rate":oftenId, @"type_ii_rate":onceId, @"type_iii_rate":notId, @"traveled":bottomCell.kilometerTF.text, @"carName":self.carInfo.carName, @"proCityName":addressStr, @"roadTxt":carroadStr};
                            }
                        }else{
                            
                            if ([oftenId isEqualToString:@""] && [onceId isEqualToString:@""] && [notId isEqualToString:@""]) {
                                
                                self.commitPostDic =@{@"userId":useridStr, @"id":[NSString stringWithFormat:@"%@", self.carInfo.carInfoid], @"carId":[NSString stringWithFormat:@"%@", self.carInfo.carId], @"isNewenergy":[NSNumber numberWithInt:0], @"platNumber":resultPlateStr, @"proCityId":pro_city_id, @"font":fontStr, @"rear":rearStr, @"drivingLicenseDate":dateStr, @"serviceYearLength":self.carInfo.serviceYearLength, @"type_i_rate":@"", @"type_ii_rate":@"", @"type_iii_rate":@"", @"traveled":bottomCell.kilometerTF.text, @"carName":self.car_carTireInfo.verhicle, @"proCityName":addressStr, @"roadTxt":@""};
                            }else{
                                
                                self.commitPostDic =@{@"userId":useridStr, @"id":[NSString stringWithFormat:@"%@", self.carInfo.carInfoid], @"carId":[NSString stringWithFormat:@"%@", self.carInfo.carId], @"isNewenergy":[NSNumber numberWithInt:0], @"platNumber":resultPlateStr, @"proCityId":pro_city_id, @"font":fontStr, @"rear":rearStr, @"drivingLicenseDate":dateStr,@"serviceYearLength":self.carInfo.serviceYearLength, @"type_i_rate":oftenId, @"type_ii_rate":onceId, @"type_iii_rate":notId, @"traveled":bottomCell.kilometerTF.text, @"carName":self.car_carTireInfo.verhicle, @"proCityName":addressStr, @"roadTxt":carroadStr};
                            }
                        }
                    }else{
                        
                        if (self.car_carTireInfo.verhicle == NULL) {
                            
                            if ([oftenId isEqualToString:@""] && [onceId isEqualToString:@""] && [notId isEqualToString:@""]) {
                                
                                self.commitPostDic =@{@"userId":useridStr, @"id":[NSString stringWithFormat:@"%@", self.carInfo.carInfoid], @"carId":self.car_carTireInfo.tireInfoId, @"isNewenergy":[NSNumber numberWithInt:0], @"platNumber":resultPlateStr, @"proCityId":pro_city_id, @"font":fontStr, @"rear":rearStr, @"drivingLicenseDate":dateStr,@"serviceYearLength":self.carInfo.serviceYearLength,  @"type_i_rate":@"", @"type_ii_rate":@"", @"type_iii_rate":@"", @"traveled":bottomCell.kilometerTF.text, @"carName":self.carInfo.carName, @"proCityName":addressStr, @"roadTxt":@""};
                            }else{
                                
                                self.commitPostDic =@{@"userId":useridStr, @"id":[NSString stringWithFormat:@"%@", self.carInfo.carInfoid], @"carId":self.car_carTireInfo.tireInfoId, @"isNewenergy":[NSNumber numberWithInt:0], @"platNumber":resultPlateStr, @"proCityId":pro_city_id, @"font":fontStr, @"rear":rearStr, @"drivingLicenseDate":dateStr,@"serviceYearLength":self.carInfo.serviceYearLength, @"type_i_rate":oftenId, @"type_ii_rate":onceId, @"type_iii_rate":notId, @"traveled":bottomCell.kilometerTF.text, @"carName":self.carInfo.carName, @"proCityName":addressStr, @"roadTxt":carroadStr};
                            }
                        }else{
                            
                            if ([oftenId isEqualToString:@""] && [onceId isEqualToString:@""] && [notId isEqualToString:@""]) {
                                
                                self.commitPostDic =@{@"userId":useridStr, @"id":[NSString stringWithFormat:@"%@", self.carInfo.carInfoid], @"carId":self.car_carTireInfo.tireInfoId, @"isNewenergy":[NSNumber numberWithInt:0], @"platNumber":resultPlateStr, @"proCityId":pro_city_id, @"font":fontStr, @"rear":rearStr, @"drivingLicenseDate":dateStr, @"serviceYearLength":self.carInfo.serviceYearLength,@"type_i_rate":@"", @"type_ii_rate":@"", @"type_iii_rate":@"", @"traveled":bottomCell.kilometerTF.text, @"carName":self.car_carTireInfo.verhicle, @"proCityName":addressStr, @"roadTxt":@""};
                            }else{
                                
                                self.commitPostDic =@{@"userId":useridStr, @"id":[NSString stringWithFormat:@"%@", self.carInfo.carInfoid], @"carId":self.car_carTireInfo.tireInfoId, @"isNewenergy":[NSNumber numberWithInt:0], @"platNumber":resultPlateStr, @"proCityId":pro_city_id, @"font":fontStr, @"rear":rearStr, @"drivingLicenseDate":dateStr,@"serviceYearLength":self.carInfo.serviceYearLength,  @"type_i_rate":oftenId, @"type_ii_rate":onceId, @"type_iii_rate":notId, @"traveled":bottomCell.kilometerTF.text, @"carName":self.car_carTireInfo.verhicle, @"proCityName":addressStr, @"roadTxt":carroadStr};
                            }
                        }
                    }
                    [self updateUserCarInfo:self.commitPostDic];
                }else{
                    
                    [PublicClass showHUD:@"请输入正确的车牌号" view:self.view];
                }
            }
        }
        NSLog(@"修改车辆信息的字典:%@", self.commitPostDic);
    }
}

- (void)updateUserCarInfo:(NSDictionary *)dic{
    
    NSString *reqJson = [PublicClass convertToJsonData:dic];
    [JJRequest postRequest:@"userCar/updateUserCarInfo" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {

        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {

//            DelegateConfiguration *delegateConfiguration = [DelegateConfiguration sharedConfiguration];
            [self.delegateConfiguration changeaddCarNumber];
            [self.delegateConfiguration unregisterRoadStatusChangedListener:self];
            [self.delegateConfiguration unregisterCartypeStatusChangeListener:self];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{

            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {

        NSLog(@"修改用户车辆信息错误:%@", error);
    }];
}

- (void)commitInternetWithDic:(NSDictionary *)dic{
    
    NSString *reqJson = [PublicClass convertToJsonData:dic];
    [JJRequest postRequest:@"addUserCar" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {

        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        NSArray *couponArr = (NSArray *)data;
        if ([statusStr isEqualToString:@"1"]) {

            [UserConfig userDefaultsSetObject:@"1" key:@"firstAddCar"];

            [self.delegateConfiguration changeaddCarNumber];
            [self.delegateConfiguration unregisterRoadStatusChangedListener:self];
            [self.delegateConfiguration unregisterCartypeStatusChangeListener:self];

            if (couponArr.count<=0) {
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                return ;
            }
            //两种优惠券
            JJCouponView *couponView = [[JJCouponView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height)];
            couponView.counponListArr = couponArr;
            couponView.popBlock = ^{

                [self.navigationController popToRootViewControllerAnimated:YES];
            };
            [couponView show];
        }else{

            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {

        NSLog(@"添加车辆错误:%@", error);
    }];
}

- (void)getProcityIdBypStr:(NSString *)pStr cStr:(NSString *)cStr aStr:(NSString *)aStr{
    
    NSLog(@"省%@,市%@,区%@", pStr, cStr, aStr);
    if ([cStr isEqualToString:@""]) {
        
        FMDBPosition *position = [[DBRecorder getPro_City_id:pStr] objectAtIndex:0];
        pro_city_id = [NSString stringWithFormat:@"%@", position.positionId];
    }else{
        
        if ([aStr isEqualToString:@""]) {
            
            FMDBPosition *position = [[DBRecorder getPro_City_id:cStr] objectAtIndex:0];
            pro_city_id = [NSString stringWithFormat:@"%@", position.positionId];
        }else{
            
            FMDBPosition *position = [[DBRecorder getPro_City_id:aStr] objectAtIndex:0];
            pro_city_id = [NSString stringWithFormat:@"%@", position.positionId];
        }
    }
    NSLog(@"城市的ID:%@", pro_city_id);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //yyyy-MM-dd hh:mm:ss
    nowYear = [[[PublicClass gettodayDate] substringWithRange:NSMakeRange(0, 4)] intValue];
    nowMonth = [[[PublicClass gettodayDate] substringWithRange:NSMakeRange(5, 2)] intValue];
    nowDay = [[[PublicClass gettodayDate] substringWithRange:NSMakeRange(8, 2)] intValue];
    [self initString];
//    DelegateConfiguration *delegateConfiguration = [DelegateConfiguration sharedConfiguration];
    [self.delegateConfiguration registerRoadStatusChangedListener:self];
    [self.delegateConfiguration registerCartypeStatusChangeListener:self];
    isodomter = @"1";
    self.title = @"我的宝驹";
    y = 6;
    [self addView];
    if (is_alter == NO) {
        
        [self getCarInfoFromInternet];
    }
}

- (void)getCarInfoFromInternet{
    
    NSDictionary *getCarInfoDic = @{@"userId":[NSString stringWithFormat:@"%@",[UserConfig user_id]], @"userCarId":user_car_idStr};
    NSString *getCarInforeqJson = [PublicClass convertToJsonData:getCarInfoDic];
    [JJRequest postRequest:@"getCarByUserIdAndCarId" params:@{@"reqJson":getCarInforeqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *mesgStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"-1"]) {
            
            [PublicClass showHUD:mesgStr view:self.view];
        }else{
            
            NSLog(@"%@", data);
            [self.carInfo setValuesForKeysWithDictionary:data];
            if ([self.carInfo.maturityImg isEqualToString:@""]) {
                
                isodomter = @"2";
            }else{
                
                isodomter = @"1";
            }
                
            if (self.carInfo.serviceEndDate != NULL) {
                
                [_saveBtn setTitle:@"车辆信息不可修改" forState:UIControlStateNormal];
                [_saveBtn setBackgroundColor:[UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:0.4] forState:UIControlStateNormal];
            }else{
                
                _saveBtn.userInteractionEnabled = YES;
                [_saveBtn setTitle:@"修改车辆信息" forState:UIControlStateNormal];
                [_saveBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
            }
            [self.carInfoTV reloadData];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"获取用户车辆信息错误:%@", error);
    }];
}

- (void)initString{
    
    self.updateFlagStr = @"0";
    resultPlateStr = @"";
    fontStr = @"";
    rearStr = @"";
    dateStr = @"";
    addressStr = @"";
    pro_city_id = @"";
    carroadStr = @"";
    oftenId = @"";
    onceId = @"";
    notId = @"";
}

- (IBAction)backButtonAction:(id)sender{
    
    DelegateConfiguration *delegateConfiguration = [DelegateConfiguration sharedConfiguration];
    [delegateConfiguration unregisterRoadStatusChangedListener:self];
    [delegateConfiguration unregisterCartypeStatusChangeListener:self];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addView{
    
    [self.view addSubview:self.firstView];
    [_firstView addSubview:self.promptLabel];
    [self.view addSubview:self.carInfoTV];
    [self.view addSubview:self.saveView];
    [_saveView addSubview:self.saveBtn];
    if (is_alter == YES) {
        
        [self.view addSubview:self.areaPickerView];
    }
    [self.view addSubview:self.backView];
    [_backView addSubview:self.plateLicenseView];
}

//tableViewdelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {

        //隐藏掉一个功能
        return 325.0-40;
    }else{

        return 120.0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        static NSString *cellStr = @"topCell";
        TopCarInfoTableViewCell *topCell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (topCell == nil) {

            topCell = [[TopCarInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
            topCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        topCell.backgroundColor = [UIColor clearColor];
        topCell.typeBtn.tag = 10000;
        if (self.car_carTireInfo.verhicle == NULL) {
            
            [topCell.typeBtn setTitle:self.carInfo.carName forState:UIControlStateNormal];
        }else{
            
            [topCell.typeBtn setTitle:self.car_carTireInfo.verhicle forState:UIControlStateNormal];
        }
        [topCell.typeBtn addTarget:self action:@selector(chickTopBtn:) forControlEvents:UIControlEventTouchUpInside];
        topCell.typeBtn.userInteractionEnabled = is_alter;
        [topCell.ison addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
        topCell.ison.userInteractionEnabled = is_alter;
        topCell.platenumBtn.tag = 10001;
        if (resultPlateStr.length == 8 || resultPlateStr.length == 7) {
            
            [topCell.platenumBtn setTitle:resultPlateStr forState:UIControlStateNormal];
        }else{
            
            resultPlateStr = self.carInfo.platNumber;
            [topCell.platenumBtn setTitle:self.carInfo.platNumber forState:UIControlStateNormal];
        }
        [topCell.platenumBtn addTarget:self action:@selector(chickTopBtn:) forControlEvents:UIControlEventTouchUpInside];
        topCell.platenumBtn.userInteractionEnabled = is_alter;
        topCell.frontBtn.tag = 10002;
        [topCell.frontBtn addTarget:self action:@selector(chickTopBtn:) forControlEvents:UIControlEventTouchUpInside];
        topCell.frontBtn.userInteractionEnabled = is_alter;
        topCell.rearBtn.tag = 10003;
        [topCell.rearBtn addTarget:self action:@selector(chickTopBtn:) forControlEvents:UIControlEventTouchUpInside];
        topCell.rearBtn.userInteractionEnabled = is_alter;
        topCell.selectImgBtn.userInteractionEnabled = is_alter;
        if (fontStr.length == 0) {
            
            [topCell.frontBtn setTitle:self.car_carTireInfo.font forState:UIControlStateNormal];
            fontStr = self.car_carTireInfo.font;
        }else{
            
            [topCell.frontBtn setTitle:fontStr forState:UIControlStateNormal];
        }
        if (rearStr.length == 0) {
            
            [topCell.rearBtn setTitle:self.car_carTireInfo.rear forState:UIControlStateNormal];
            rearStr = self.car_carTireInfo.rear;
        }else{
            
            [topCell.rearBtn setTitle:rearStr forState:UIControlStateNormal];
        }
        
        topCell.drivingBtn.tag = 10004;
        [topCell.drivingBtn setTitle:dateStr forState:UIControlStateNormal];
        [topCell.drivingBtn addTarget:self action:@selector(chickTopBtn:) forControlEvents:UIControlEventTouchUpInside];
        topCell.drivingBtn.userInteractionEnabled = is_alter;
        topCell.serviceBtn.tag = 10005;

        topCell.residentAreaBtn.tag = 1006;
        [topCell.residentAreaBtn addTarget:self action:@selector(chickTopBtn:) forControlEvents:UIControlEventTouchUpInside];
        topCell.residentAreaBtn.userInteractionEnabled = is_alter;
        if (is_alter == NO && [self.updateFlagStr isEqualToString:@"0"]) {
            
            [topCell.typeBtn setTitle:self.carInfo.carName forState:UIControlStateNormal];
            NSLog(@"%@", self.carInfo.isNewenergy);
            if ([self.carInfo.isNewenergy isEqualToNumber:[NSNumber numberWithInt:0]] || self.carInfo.isNewenergy == nil) {
                
                topCell.ison.on = NO;
            }else{
                
                topCell.ison.on = YES;
            }
            [topCell.platenumBtn setTitle:self.carInfo.platNumber forState:UIControlStateNormal];
            [topCell.frontBtn setTitle:self.carInfo.font forState:UIControlStateNormal];
            [topCell.rearBtn setTitle:self.carInfo.rear forState:UIControlStateNormal];
            NSString *drivingDateStr = [PublicClass timestampSwitchTime:[self.carInfo.drivingLicenseDate integerValue] andFormatter:@"YYYY-MM-dd"];
//            NSString *serviceEndStr = [NSString stringWithFormat:@"%ld 年", [self.carInfo.serviceYearLength integerValue]];
//            NSLog(@"%@---%@---%@---%@", self.carInfo.drivingLicenseDate, self.carInfo.serviceEndDate, drivingDateStr, serviceEndStr);
            [topCell.drivingBtn setTitle:drivingDateStr forState:UIControlStateNormal];
            [topCell.residentAreaBtn setTitle:self.carInfo.proCityName forState:UIControlStateNormal];
            [topCell.selectImgBtn sd_setImageWithURL:[NSURL URLWithString:self.carInfo.traveledImgObverse] forState:UIControlStateNormal];
            if (self.carInfo.serviceEndDate == NULL) {
                
                if ([self.carInfo.isNewenergy integerValue] == 1) {
                    
                    isNew = true;
                }else{
                    
                    isNew = false;
                }
                resultPlateStr = self.carInfo.platNumber;
                fontStr = self.carInfo.font;
                rearStr = self.carInfo.rear;
                dateStr = [PublicClass timestampSwitchTime:[self.carInfo.drivingLicenseDate integerValue] andFormatter:@"YYYY-MM-dd"];
                addressStr = self.carInfo.proCityName;
                pro_city_id = [NSString stringWithFormat:@"%@", self.carInfo.proCityId];
                carroadStr = self.carInfo.roadTxt;
                selectYear = [[drivingDateStr substringWithRange:NSMakeRange(0, 4)] intValue];
                [self.view addSubview:self.areaPickerView];
                topCell.typeBtn.userInteractionEnabled = YES;
                topCell.ison.userInteractionEnabled = YES;
                topCell.platenumBtn.userInteractionEnabled = YES;
                topCell.residentAreaBtn.userInteractionEnabled = YES;
                topCell.frontBtn.userInteractionEnabled = YES;
                topCell.rearBtn.userInteractionEnabled = YES;
                topCell.drivingBtn.userInteractionEnabled = YES;
            }
        }else if (is_alter == NO && [self.updateFlagStr isEqualToString:@"1"]){
            
            topCell.typeBtn.userInteractionEnabled = YES;
            topCell.ison.userInteractionEnabled = YES;
            topCell.platenumBtn.userInteractionEnabled = YES;
            topCell.residentAreaBtn.userInteractionEnabled = YES;
            topCell.frontBtn.userInteractionEnabled = YES;
            topCell.rearBtn.userInteractionEnabled = YES;
            topCell.drivingBtn.userInteractionEnabled = YES;
        }
        return topCell;
    }else{
        
        static NSString *cellIndentifier = @"bottomCell";
        BottomCarInfoTableViewCell *bottomCell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (bottomCell == nil) {

            bottomCell = [[BottomCarInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            bottomCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        bottomCell.backgroundColor = [UIColor clearColor];
        bottomCell.kilometerTF.userInteractionEnabled = is_alter;
        bottomCell.roadConditionBtn.tag = 20001;
        [bottomCell.roadConditionBtn setTitle:carroadStr forState:UIControlStateNormal];
        [bottomCell.roadConditionBtn addTarget:self action:@selector(chickBottomBtn:) forControlEvents:UIControlEventTouchUpInside];
        bottomCell.roadConditionBtn.userInteractionEnabled = is_alter;
        
        if (is_alter == NO && [self.updateFlagStr isEqualToString:@"0"]) {
            
            bottomCell.kilometerTF.text = [NSString stringWithFormat:@"%@", self.carInfo.traveled];
            [bottomCell.roadConditionBtn setTitle:self.carInfo.roadTxt forState:UIControlStateNormal];
            if (self.carInfo.serviceEndDate == NULL) {
                
                bottomCell.kilometerTF.userInteractionEnabled = YES;
                bottomCell.roadConditionBtn.userInteractionEnabled = YES;
            }
        }else if (is_alter == NO && [self.updateFlagStr isEqualToString:@"1"]){
            
            bottomCell.kilometerTF.userInteractionEnabled = YES;
            bottomCell.roadConditionBtn.userInteractionEnabled = YES;
        }
        return bottomCell;
    }
}

- (void)chickTopBtn:(UIButton *)topBtn{
    
    self.updateFlagStr = @"1";
    //10000:车型，10001:车牌号码，10002:前轮规格，10003:后轮规格，10004:行驶证注册日期，10005:服务截止日期
    switch (topBtn.tag) {
        case 10000:
            
            [self chickCarTypeBtn:topBtn];
            break;
            
        case 10001:
            
            self.backView.hidden = NO;
            break;
            
        case 10002:
            
            [self chicktireSpecificationBtn:topBtn];
            break;
            
        case 10003:
            
            [self chicktireSpecificationBtn:topBtn];
            break;
            
        case 10004:
            
            [self showPickDateView:topBtn];
            break;
            
        case 10005:
            
            break;
            
        case 1006:
            
            NSLog(@"点击地区选择");
            [self showPickCityView:topBtn];
            break;
    
        default:
            break;
    }
}

- (void)switchAction:(UISwitch *)is_switch{
    
    isNew = is_switch.isOn;
}

- (void)chickCarTypeBtn:(UIButton *)button{
    
    SelectBrandViewController *selectBrandVC = [[SelectBrandViewController alloc] init];
    [self.navigationController pushViewController:selectBrandVC animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}

- (void)chicktireSpecificationBtn:(UIButton *)button{
    
    if (self.car_carTireInfo.name.length == 0 && is_alter == YES) {

        [PublicClass showHUD:@"请选择车型" view:self.view];
        return;
    }
    JJWeakSelf
    TireSpecificationViewController *tireSVC = [[TireSpecificationViewController alloc] init];
    
    if (button.tag == 10002) {
        
        tireSVC.dItem1Row = frontItem1Row;
        tireSVC.dItem2Row = frontItem2Row;
        tireSVC.dItem3Row = frontItem3Row;
    }else {
        tireSVC.dItem1Row = rearItem1Row;
        tireSVC.dItem2Row = rearItem2Row;
        tireSVC.dItem3Row = rearItem3Row;
    }
    
    tireSVC.specificationBlock = ^(NSString *text, NSInteger item1Row, NSInteger item2Row, NSInteger item3Row) {
        NSLog(@"%ld", button.tag);
        if (button.tag == 10002) {
            
            self->fontStr = text;
            self->rearStr = text;
            TopCarInfoTableViewCell *topCell = [weakSelf.carInfoTV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            
            [topCell.rearBtn setTitle:text forState:UIControlStateNormal];
            
            self->frontItem1Row = item1Row;
            self->frontItem2Row = item2Row;
            self->frontItem3Row = item3Row;
            self->rearItem1Row = item1Row;
            self->rearItem2Row = item2Row;
            self->rearItem3Row = item3Row;
        }else{
            self->rearItem1Row = item1Row;
            self->rearItem2Row = item2Row;
            self->rearItem3Row = item3Row;
            self->rearStr = text;
        }
        [button setTitle:text forState:UIControlStateNormal];
    };
    [self.navigationController pushViewController:tireSVC animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}

- (void)showPickDateView:(UIButton *)topBtn{
    
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"joinStatusStr"];
    WXZPickDateView *pickerDate = [[WXZPickDateView alloc] init];
    [pickerDate setIsAddYetSelect:NO];
    [pickerDate setIsShowDay:YES];
    [pickerDate setDefaultTSelectYear:(NSInteger)nowYear defaultSelectMonth:(NSInteger)nowMonth defaultSelectDay:(NSInteger)nowDay];
    [pickerDate setDelegate:self];
    [pickerDate show];
    [self.view endEditing:YES];
    self.block = ^(NSString *text) {
        
        [topBtn setTitle:text forState:UIControlStateNormal];
    };
}

- (void)showPickCityView:(UIButton *)button{
    
    [self.areaPickerView show];
    self.block = ^(NSString *text) {
        
        [button setTitle:text forState:UIControlStateNormal];
    };
}

- (void)chickBottomBtn:(UIButton *)bottomBtn{
    
    self.updateFlagStr = @"1";
    //20001:行驶路况
    switch (bottomBtn.tag) {
            
        case 20001:
            
            [self chickRoadConditionBtn:bottomBtn];
            break;
            
        default:
            break;
    }
}

- (void)chickRoadConditionBtn:(UIButton *)button{
    
    RoadConditionViewController *roadCVC = [[RoadConditionViewController alloc] init];
    [self.navigationController pushViewController:roadCVC animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}

//PickerDateViewDelegate
- (void)pickerDateView:(WXZBasePickView *)pickerDateView selectYear:(NSInteger)year selectMonth:(NSInteger)month selectDay:(NSInteger)day{
    
    selectYear = (int)year;
    dateStr = [PublicClass returnDateStrselectYear:year selectMonth:month selectDay:day];
    self.block(dateStr);
}

//AddressPickerViewDelegate
- (void)cancelBtnClick{
    NSLog(@"点击了取消按钮");
    [self.areaPickerView hide];
}
- (void)sureBtnClickReturnProvince:(NSString *)province City:(NSString *)city Area:(NSString *)area{
    addressStr = [NSString stringWithFormat:@"%@%@%@",province,city,area];
    [self.areaPickerView hide];
    [self getProcityIdBypStr:province cStr:city aStr:area];
    self.block(addressStr);
}

//update delegate
- (void)updateRoadStatusName:(NSString *)nameStr OftenId:(NSString *)oftenIdStr OnceId:(NSString *)onceIdStr NotId:(NSString *)notIdStr{
    
    oftenId = oftenIdStr;
    onceId = onceIdStr;
    notId = notIdStr;
    carroadStr = nameStr;
    [_carInfoTV reloadData];
}

- (void)updateTypeStatus:(FMDBCarTireInfo *)carTireInfo{
    
    self.car_carTireInfo = carTireInfo;
    fontStr = @"";
    rearStr = @"";
    [_carInfoTV reloadData];
}


-(DelegateConfiguration *)delegateConfiguration{
    
    if (!_delegateConfiguration) {
        
        _delegateConfiguration = [DelegateConfiguration sharedConfiguration];
    }
    return _delegateConfiguration;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

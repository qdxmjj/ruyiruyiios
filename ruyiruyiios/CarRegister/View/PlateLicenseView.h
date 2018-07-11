//
//  PlateLicenseView.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/24.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlateLicenseView : UIView<UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>

@property(nonatomic, weak)UILabel *promptLabel;
@property(nonatomic, weak)UIPickerView *platePickview;
@property(nonatomic, weak)UITextField *inputTF;
@property(nonatomic, weak)UIView *inputUnderLineView;
@property(nonatomic, weak)UIButton *sureBtn;
@property(nonatomic, strong)NSArray *regionArray;
@property(nonatomic, strong)NSArray *letterArray;

@end

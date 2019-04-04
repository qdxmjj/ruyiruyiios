//
//  PlateLicenseView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/24.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "PlateLicenseView.h"

@implementation PlateLicenseView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.text = @"选择车牌号";
        textLabel.font = [UIFont fontWithName:TEXTFONT size:18.0];
        textLabel.textColor = [UIColor blackColor];
        self.promptLabel = textLabel;
        [self addSubview:textLabel];
        
        UIPickerView *pickView = [[UIPickerView alloc] init];
        pickView.showsSelectionIndicator = YES;
        pickView.delegate = self;
        pickView.dataSource = self;
        self.platePickview = pickView;
        [self addSubview:pickView];
        
        UITextField *textField = [[UITextField alloc] init];
        textField.font = [UIFont fontWithName:TEXTFONT size:16.0];
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"输入新的车牌号" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],
                                                                                                            NSFontAttributeName:textField.font}];
        textField.attributedPlaceholder = attrString;
        textField.textColor = [UIColor lightGrayColor];
        textField.delegate = self;
        textField.keyboardType = UIKeyboardTypeASCIICapable;

        self.inputTF = textField;
        [self addSubview:textField];
        
        UIView *underView = [[UIView alloc] init];
        underView.backgroundColor = LOGINBACKCOLOR;
        self.inputUnderLineView = underView;
        [self addSubview:underView];
        
        UIButton *okBtn = [[UIButton alloc] init];
        [okBtn setTitle:@"OK" forState:UIControlStateNormal];
        [okBtn setTitleColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        okBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        self.sureBtn = okBtn;
        [self addSubview:okBtn];
        
        self.letterArray = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
        self.regionArray = @[@"京", @"津", @"沪", @"渝", @"蒙", @"新", @"藏", @"宁", @"桂", @"港", @"澳", @"黑", @"吉", @"辽", @"翼", @"晋", @"青", @"鲁", @"豫", @"苏", @"皖", @"浙", @"闽", @"赣", @"湘", @"鄂", @"粤", @"台", @"琼", @"甘", @"陕", @"川", @"贵", @"云"];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.promptLabel.frame = CGRectMake(20, 20, self.frame.size.width-20, 20);
    self.platePickview.frame = CGRectMake(20, 50, self.frame.size.width/2 - 20, 130);
    self.inputTF.frame = CGRectMake(self.frame.size.width/2+20, 105, self.frame.size.width/2-20, 20);
    self.inputUnderLineView.frame = CGRectMake(self.frame.size.width/2+20, 128, self.frame.size.width/2 - 40, 1);
    self.sureBtn.frame = CGRectMake(self.frame.size.width - 60, self.frame.size.height - 40, 40, 20);
}

//UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component == 0) {
        
        return [self.regionArray count];
    }else{
        
        return [self.letterArray count];
    }
}

//UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    return (self.frame.size.width/2 - 20)/2;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component == 0) {
        
        return [self.regionArray objectAtIndex:row];
    }else{
        
        return [self.letterArray objectAtIndex:row];
    }
}

//UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

// 只能输入大写字母
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //必须得写不然无法删除
    if (range.length == 1 && string.length == 0) {
        return YES;
    }
    char lowercaseChar = [string characterAtIndex:0];
    
    if (lowercaseChar > 96 && lowercaseChar < 123) {
        
        NSString * uppercaseString = string.uppercaseString;
        NSString * frontStr = [textField.text substringToIndex:range.location];
        NSString * backStr = [textField.text substringFromIndex:range.location];
        textField.text = [NSString stringWithFormat:@"%@%@%@",frontStr,uppercaseString,backStr];
        return NO;
    }
    
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHANUM] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    return [string isEqualToString:filtered];
    
//    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

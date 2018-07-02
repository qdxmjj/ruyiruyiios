//
//  BarCodeView.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/7/1.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BarCodeView : UIView

@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)NSArray *countArray;

- (instancetype)initWithFrame:(CGRect)frame number:(NSArray *)numberArray;

@end

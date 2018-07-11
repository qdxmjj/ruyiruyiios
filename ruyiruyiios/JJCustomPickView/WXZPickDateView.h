//
//  WXZPickDateView.h
//  自定义选择器
//
//  Created by WOSHIPM on 2017/4/28.
//  Copyright © 2017年 WOSHIPM. All rights reserved.
//

#import "WXZBasePickView.h"
@class WXZBasePickView;
@protocol  PickerDateViewDelegate<NSObject>
- (void)pickerDateView:(WXZBasePickView *)pickerDateView selectYear:(NSInteger)year selectMonth:(NSInteger)month selectDay:(NSInteger)day;

@end
@interface WXZPickDateView : WXZBasePickView
 
@property(nonatomic, weak)id <PickerDateViewDelegate>delegate ;

@property(nonatomic, assign)BOOL isAddYetSelect;//是否增加至今的选项
@property(nonatomic, assign)BOOL isShowDay;//是否显示日
@property(nonatomic, strong)NSString *firstFlagStr;
//@property(nonatomic, strong)NSString *joinStatusStr;//0---注册用户信息页面，1---注册车辆信息页面

-(void)setDefaultTSelectYear:(NSInteger)defaultSelectYear defaultSelectMonth:(NSInteger)defaultSelectMonth defaultSelectDay:(NSInteger)defaultSelectDay;

@end

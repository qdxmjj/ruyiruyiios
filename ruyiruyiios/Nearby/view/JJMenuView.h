//
//  JJMenuView.h
//  TestOrdersType
//
//  Created by 小马驾驾 on 2018/5/29.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JJMenuView;

@protocol JJDropdownViewDelegate <NSObject>

@optional

-(void)dropdownView:(JJMenuView *)dropdownView didSelectTitle:(NSString *)title didSelectIndex:(NSInteger)index whereGroup:(NSInteger)group;
-(void)dropdownViewDidShow:(JJMenuView *)dropdownView;
-(void)dropdownViewDidDismiss:(JJMenuView *)dropdownView;

@end
@interface JJMenuView : UIView

@property(nonatomic,assign)id <JJDropdownViewDelegate>delegate;

@property(nonatomic,assign)NSInteger whereGroup;

-(void)showViewWithSuperView:(UIView *)view titleArr:(NSArray *)titleArr;

-(void)disView;

-(BOOL)status;


@end

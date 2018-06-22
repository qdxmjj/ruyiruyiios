//
//  ExtensionBottomView.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/20.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExtensionBottomView : UIView<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UIView *leftView;
@property(nonatomic, strong)UILabel *getAwardLabel;
@property(nonatomic, strong)UIView *rightView;
@property(nonatomic, strong)UILabel *alertLabel;
@property(nonatomic, strong)NSMutableArray *shareList;
@property(nonatomic, strong)UITableView *inviterTableV;

//flagStr--1  inviterTableV show;  flagStr--2  alertLabel show;
- (instancetype)initWithFrame:(CGRect)frame sharePersons:(NSMutableArray *)shareMutableA viewFlage:(NSString *)flagStr;
- (void)setdatatoViews:(NSMutableArray *)shareRelationList;

@end

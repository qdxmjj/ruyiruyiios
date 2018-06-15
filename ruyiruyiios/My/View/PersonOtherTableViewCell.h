//
//  PersonOtherTableViewCell.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/14.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonOtherTableViewCell : UITableViewCell<UITextFieldDelegate>

@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UITextField *nameTF;
@property(nonatomic, strong)UILabel *dataLabel;
@property(nonatomic, strong)UIImageView *rightImageV;
@property(nonatomic, strong)NSString *flagStr;
@property(nonatomic, strong)NSString *isemail;
@property(nonatomic, strong)UIView *b_view;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier flag:(NSString *)flagStr email:(NSString *)isemail;
- (void)setdatatoCellViewstitleStr:(NSString *)titleStr data:(NSString *)dataStr;

@end

//
//  BottomCarInfoTableViewCell.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/18.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomCarInfoTableViewCell : UITableViewCell<UITextFieldDelegate>

@property(nonatomic, strong)UITextField *kilometerTF;
@property(nonatomic, strong)UIView *firstView;
@property(nonatomic, strong)UIButton *roadConditionBtn;
@property(nonatomic, strong)UILabel *codeLabel;
@property(nonatomic, strong)UITextField *codeTF;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end

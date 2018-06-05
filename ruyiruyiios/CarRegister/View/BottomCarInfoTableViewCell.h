//
//  BottomCarInfoTableViewCell.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/18.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomCarInfoTableViewCell : UITableViewCell<UITextFieldDelegate>

@property(nonatomic, strong)UIButton *odometerBtn;
@property(nonatomic, strong)UITextField *kilometerTF;
@property(nonatomic, strong)UIView *firstView;
@property(nonatomic, strong)UIButton *b_selectImgBtn;
@property(nonatomic, strong)UIButton *b_deleteBtn;
@property(nonatomic, strong)UIButton *roadConditionBtn;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end

//
//  RegisterTableViewCell.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/9.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterTableViewCell : UITableViewCell<UITextFieldDelegate>

@property(nonatomic, strong)UILabel *leftLabel;
@property(nonatomic, strong)UITextField *rightTF;
@property(nonatomic, strong)UIView *underView;
@property(copy, nonatomic)void(^block)(NSString *);

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end

//
//  CarInfoTableViewCell.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/18.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarInfoTableViewCell : UITableViewCell<UITextFieldDelegate>

@property(nonatomic, strong)UILabel *leftLabel;
@property(nonatomic, strong)UILabel *rightLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end

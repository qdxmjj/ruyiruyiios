//
//  DateTableViewCell.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/9.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateTableViewCell : UITableViewCell<UIPickerViewDelegate>
@property (nonatomic, strong)UILabel *dateLabel;
@property (nonatomic, strong)UIButton *dateButton;
@property(nonatomic, strong)UIView *underView;
@property(nonatomic, strong)UIImageView *jianTouimgV;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end

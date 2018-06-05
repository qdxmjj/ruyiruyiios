//
//  ManageCarTableViewCell.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/25.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManageCarTableViewCell : UITableViewCell

@property(nonatomic, strong)UIImageView *carImageV;
@property(nonatomic, strong)UILabel *carNameLabel;
@property(nonatomic, strong)UILabel *platNumberLabel;
@property(nonatomic, strong)UIView *underLineV;
@property(nonatomic, strong)UIImageView *defultImageV;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end

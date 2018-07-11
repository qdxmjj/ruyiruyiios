//
//  StoreDetailsPhoneCell.h
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/6.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreDetailsModel.h"

@interface StoreDetailsPhoneCell : UITableViewCell

-(void)setModel:(StoreDetailsModel *)model;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;

@end

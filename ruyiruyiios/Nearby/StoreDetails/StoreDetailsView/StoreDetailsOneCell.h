//
//  StoreDetailsOneCell.h
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/6.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreDetailsModel.h"
@interface StoreDetailsOneCell : UITableViewCell

-(void)setModel:(StoreDetailsModel *)model;
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *storeAddress;
@property (weak, nonatomic) IBOutlet UILabel *storetype;
@property (weak, nonatomic) IBOutlet UIImageView *navImg;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UIButton *pushNavBtn;

@end

//
//  StoreDetailsCell.h
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/5.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreAssessModel.h"
@interface StoreDetailsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *storeAssessUserHeadImg;

@property (weak, nonatomic) IBOutlet UILabel *storeAssessUserName;

@property (weak, nonatomic) IBOutlet UILabel *storeAssessTime;

@property (weak, nonatomic) IBOutlet UILabel *storeAssessContent;




-(void)setAssessContentModel:(StoreAssessModel *)model;


@end

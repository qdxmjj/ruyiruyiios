//
//  FJStoreServiceListCell.h
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/5/30.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YM_FJStoreServiceModel.h"
@interface FJStoreServiceListCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *serviceLab;


-(void)setCellLabelContent:(YM_FJStoreServiceModel *)model;

@end

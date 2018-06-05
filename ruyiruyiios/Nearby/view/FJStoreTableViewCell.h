//
//  FJStoreTableViewCell.h
//  TestOrdersType
//
//  Created by 小马驾驾 on 2018/5/29.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YM_FjStoreModel.h"
@interface FJStoreTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *storeImg;

@property (weak, nonatomic) IBOutlet UILabel *storeName;

@property (weak, nonatomic) IBOutlet UILabel *storeType;
@property (weak, nonatomic) IBOutlet UILabel *storeAddress;
@property (weak, nonatomic) IBOutlet UILabel *storeDistance;
@property (weak, nonatomic) IBOutlet UICollectionView *storeServiceType;

-(void)setCellDataModel:(YM_FjStoreModel *)model;

@end

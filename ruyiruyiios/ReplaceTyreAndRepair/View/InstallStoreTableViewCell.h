//
//  InstallStoreTableViewCell.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/11.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstUpdateCollectionViewCell.h"
#import "StoreInfo.h"
#import "StoreServiceInfo.h"

@interface InstallStoreTableViewCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong)UILabel *installStoreLabel;
@property(nonatomic, strong)UIImageView *rightImageV;
@property(nonatomic, strong)UIImageView *storeImageV;
@property(nonatomic, strong)UILabel *storeNameLabel;
@property(nonatomic, strong)UILabel *locationLabel;
@property(nonatomic, strong)UILabel *distanceLabel;
@property(nonatomic, strong)UICollectionView *functionCollectionV;
@property(nonatomic, strong)NSMutableArray *functionMutableA;

- (void)setDatatoInstallStoreCellStoreInfo:(StoreInfo *)storeInfo;

@end

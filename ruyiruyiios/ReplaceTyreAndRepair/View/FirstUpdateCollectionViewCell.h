//
//  FirstUpdateCollectionViewCell.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/11.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreServiceInfo.h"

@interface FirstUpdateCollectionViewCell : UICollectionViewCell

@property(nonatomic, strong)UILabel *functionLabel;

- (void)setDatatoBtn:(StoreServiceInfo *)serviceInfo;

@end

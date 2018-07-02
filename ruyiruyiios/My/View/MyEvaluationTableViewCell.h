//
//  MyEvaluationTableViewCell.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/26.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyEvaluationInfo.h"

@interface MyEvaluationTableViewCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong)UIImageView *headImageV;
@property(nonatomic, strong)UILabel *userNameLabel;
@property(nonatomic, strong)UILabel *timeLabel;
@property(nonatomic, strong)UILabel *detialLabel;
@property(nonatomic, strong)UICollectionView *imgCollectionV;
@property(nonatomic, strong)UIImageView *storeImageV;
@property(nonatomic, strong)UILabel *storeNameLabel;
@property(nonatomic, strong)UILabel *storeAddressLabel;
@property(nonatomic, strong)UIView *underLineView;
@property(nonatomic, strong)NSString *contentStr;
@property(nonatomic, strong)NSMutableArray *imgMutableA;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier content:(NSString *)contentStr imgUrl:(NSMutableArray *)imgUrlMutableA;
- (void)setdatatoEvaluationCell:(MyEvaluationInfo *)myEvaluationInfo;

@end

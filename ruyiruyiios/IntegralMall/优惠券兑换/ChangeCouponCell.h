//
//  ChangeCouponCell.h
//  Menu
//
//  Created by 姚永敏 on 2018/12/25.
//  Copyright © 2018 YYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChangeCouponCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImgView;
@property (weak, nonatomic) IBOutlet UIButton *exchangeBtn;
@property (weak, nonatomic) IBOutlet UILabel *titlelab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *stockLab;
@property (weak, nonatomic) IBOutlet UILabel *valueLab;

@end

NS_ASSUME_NONNULL_END

//
//  IntegralDetailsCell.h
//  ruyiruyiios
//
//  Created by 姚永敏 on 2018/12/27.
//  Copyright © 2018 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IntegralDetailsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UILabel *amountLab;

@end

NS_ASSUME_NONNULL_END

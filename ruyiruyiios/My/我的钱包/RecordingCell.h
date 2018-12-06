//
//  RecordingCell.h
//  ruyiRuyi
//
//  Created by 姚永敏 on 2018/10/17.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WithdrawModel.h"
@interface RecordingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *statusLab;

@property (weak, nonatomic) IBOutlet UIImageView *payTypeImgView;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;


-(void)setWithdrawRecordingModel:(WithdrawModel *)model;
@end

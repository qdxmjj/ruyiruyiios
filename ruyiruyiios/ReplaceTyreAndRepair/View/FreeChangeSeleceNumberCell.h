//
//  FreeChangeSeleceNumberCell.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/7/4.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^updateTirePhotoCellBlock)(BOOL isPlus);

@interface FreeChangeSeleceNumberCell : UITableViewCell

@property(nonatomic,copy)updateTirePhotoCellBlock updateBlock;
@property (weak, nonatomic) IBOutlet UILabel *tireNumberLab;

@property (weak, nonatomic) IBOutlet UIButton *plusbtn;
@property (weak, nonatomic) IBOutlet UIButton *lessBtn;
@property (weak, nonatomic) IBOutlet UILabel *numberLab;

@property(assign,nonatomic) NSInteger total;//记录当前cell选择的轮胎数量

@end

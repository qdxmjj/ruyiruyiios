//
//  RecordingCell.m
//  ruyiRuyi
//
//  Created by 姚永敏 on 2018/10/17.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "RecordingCell.h"
@implementation RecordingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setWithdrawRecordingModel:(WithdrawModel *)model{
    

    
    self.dateLab.text =[PublicClass getTimestampFromTime:[NSString stringWithFormat:@"%@",model.time] formatter:nil];
    
    if ([model.type integerValue] == 1) {
        
        if ([model.expensesType integerValue] ==1) {
            
            self.payTypeImgView.image = [UIImage imageNamed:@"ic_pay"];
        }else{
            self.payTypeImgView.image = [UIImage imageNamed:@"ic_wechat"];
        }
        NSString *statusStr  = [model.status integerValue] == 1?@"提现中":[model.status integerValue] == 2?@"提现成功":@"提现失败";
        
        self.statusLab.text = statusStr;
        
        self.priceLab.text = [NSString stringWithFormat:@"-%@",model.money];
    }else{
        self.payTypeImgView.image = [UIImage imageNamed:@"hongbao-2"];
        self.statusLab.text = @"红包领取成功";
        self.priceLab.text = [NSString stringWithFormat:@"+%@",model.money];
        self.priceLab.textColor = LOGINBACKCOLOR;
    }
   
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

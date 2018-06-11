//
//  FirstUpdateMiddleView.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/11.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NumberSelectView.h"

@interface FirstUpdateMiddleView : UIView

@property(nonatomic, strong)NumberSelectView *fontSelectView;
@property(nonatomic, strong)NumberSelectView *rearSelectView;
@property(nonatomic, strong)UIButton *updateProcessBtn;
@property(nonatomic, strong)UIImageView *processImageV;
@property(nonatomic, strong)NSString *f_limitNumberStr;
@property(nonatomic, strong)NSString *r_limitNumberStr;

@end

//
//  AboutUsHeadView.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/19.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutUsHeadView : UIView

@property(nonatomic, strong)UIImageView *iconImageV;
@property(nonatomic, strong)UILabel *versionLabel;

- (void)setversionLabelText:(NSString *)textStr imgStr:(NSString *)imageNamestr;

@end

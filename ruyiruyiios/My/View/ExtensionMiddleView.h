//
//  ExtensionMiddleView.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/20.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExtensionMiddleView : UIView

@property(nonatomic, strong)UILabel *awardLabel;
@property(nonatomic, strong)UILabel *modeLabel;
@property(nonatomic, strong)NSString *awardStr;
@property(nonatomic, strong)NSString *modeStr;

- (instancetype)initWithFrame:(CGRect)frame award:(NSString *)awardStr mode:(NSString *)modeStr;

@end

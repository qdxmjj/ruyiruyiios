//
//  JJCouponView.h
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/9/12.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^popViewBlock)(void);

@interface JJCouponView : UIView

@property(nonatomic,copy)NSString *imgName;

@property(nonatomic,copy)NSString *couponType;

@property(nonatomic,strong)NSArray *counponListArr;

@property(nonatomic,copy)popViewBlock popBlock;

-(void)show;

@end

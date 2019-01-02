//
//  IntegralNavigationView.h
//  Menu
//
//  Created by 姚永敏 on 2018/12/19.
//  Copyright © 2018 YYM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IntegralNavigationView;
NS_ASSUME_NONNULL_BEGIN
@protocol IntegralNavigationViewDelegate <NSObject>

- (void)integralNavigationView:(IntegralNavigationView *)view didSelectMyIntegral:(NSString *)userId;

@end

@interface IntegralNavigationView : UIView

@property(nonatomic,strong)UILabel *numberLab;

@property(nonatomic, weak)id <IntegralNavigationViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END

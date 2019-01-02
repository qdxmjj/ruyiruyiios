//
//  GuideView.h
//  Menu
//
//  Created by 姚永敏 on 2018/12/19.
//  Copyright © 2018 YYM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GuideView;
NS_ASSUME_NONNULL_BEGIN

@protocol GuideViewDelegate <NSObject>

-(void)GuideView:(GuideView *)view didSelectRowAtIndex:(NSInteger )index;

@end

@interface GuideView : UIView

@property(nonatomic,weak)id <GuideViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END

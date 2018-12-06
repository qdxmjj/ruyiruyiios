//
//  ADView.h
//  Menu
//
//  Created by 姚永敏 on 2018/11/30.
//  Copyright © 2018 YYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    shareStatusAble,
    shareStatusNotAble,
} shareType;


@class ADView;
@protocol ADActivityDelegate <NSObject>

-(void)adview:(ADView *)adview didSelectItemAtShareType:(shareType )type shareText:(NSString *)text shareURL:(NSString *)url;

@end


@interface ADView : UIView

@property(nonatomic,weak)id <ADActivityDelegate> delegate;

-(void)show:(UIView *)view;

-(void)setActivityInfo:(id)info;

@end

NS_ASSUME_NONNULL_END

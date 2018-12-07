//
//  EntranceView.h
//  ruyiruyiios
//
//  Created by 姚永敏 on 2018/12/7.
//  Copyright © 2018 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EntranceView;
NS_ASSUME_NONNULL_BEGIN

@protocol EntranceViewDelegate <NSObject>

-(void)EntranceView:(EntranceView *)view didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface EntranceView : UIView

@property(nonatomic,weak)id <EntranceViewDelegate >delegate;

@end

NS_ASSUME_NONNULL_END

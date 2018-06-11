//
//  TopBarView.h
//  TestOrdersType
//
//  Created by 小马驾驾 on 2018/5/28.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^setTitleLabTextBlcok)(NSString *text);

@class TopBarView;

@protocol JJClickExpandDelegate <NSObject>

-(void)clickExpandView:(TopBarView *)topBarView menuData:(NSArray *)dataArr didSelectIndex:(NSInteger)index;

@end


@interface TopBarView : UIView




@property(nonatomic,assign)id <JJClickExpandDelegate>delegate;

@property(nonatomic,strong)NSArray *conditionArr;

@property(nonatomic,copy)setTitleLabTextBlcok textBlock;


@end

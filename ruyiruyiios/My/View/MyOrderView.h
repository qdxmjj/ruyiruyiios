//
//  MyOrderView.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/7.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyOrderView;
@protocol ClickOrderDelegate<NSObject>

-(void)myOrderView:(MyOrderView *)view cellForItemAtIndexPath:(NSIndexPath *)indexPath;
@end
@interface MyOrderView : UIView

@property(nonatomic, strong)UIButton *lookAllOrderBtn;

@property(nonatomic,weak)id <ClickOrderDelegate>delegate;

@end

//
//  AppDelegate.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/7.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UINavigationControllerDelegate, WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;

-(void)setMainViewController;

@end


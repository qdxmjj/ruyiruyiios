//
//  MyWebViewController.h
//  JCMO
//
//  Created by JCreate on 2017/7/24.
//  Copyright © 2017年 JCreate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADView.h"
@interface MyWebViewController : UIViewController

@property(nonatomic,strong)NSString *url;

-(void)activityInfoWithShareType:(shareType)type shareText:(NSString *)text shareUrl:(NSString *)url;
@end

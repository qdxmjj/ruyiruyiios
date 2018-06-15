//
//  CommdoityDetailsViewController.h
//  TestOrdersType
//
//  Created by 小马驾驾 on 2018/5/29.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DirectoryTableViewController.h"

@interface CommdoityDetailsViewController : UIViewController

@property(nonatomic,strong)DirectoryTableViewController *directoryVC;

@property(nonatomic,strong)NSDictionary *commodityInfo;

@property(nonatomic,assign)NSInteger clickButtonTag;

@end

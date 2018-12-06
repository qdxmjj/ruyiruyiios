//
//  BaseTableViewController.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/4/26.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>
#import <Masonry.h>
#import <MJRefresh.h>
#import "JJRequest.h"
@interface BaseTableViewController : UITableViewController

-(void)addRefreshControl;

-(void)loadMoreData;

-(void)loadNewData;

@end

//
//  DirectoryTableViewController.h
//  TestCommodityInfo
//
//  Created by 小马驾驾 on 2018/5/30.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^RefreshContentTableViewBlock)(NSInteger index,NSString *commodityID);

@interface DirectoryTableViewController : UITableViewController

/**
 * 刷新商品内容的block
 */
@property(nonatomic,copy)RefreshContentTableViewBlock refreshBlock;

/**
 * 商品列表下标
 */
@property(nonatomic,assign)NSInteger subScript;

/**
 * 商品总服务大类
 */
@property(nonatomic,strong)NSMutableArray *sevrviceGroup;

/**
 *更新角标
 */
-(void)refreshBadgeNumberWithserviceID:(NSInteger )serviceID;


@end

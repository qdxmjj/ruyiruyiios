//
//  MyWebViewController.h
//  JCMO
//
//  Created by JCreate on 2017/7/24.
//  Copyright © 2017年 JCreate. All rights reserved.
//

#import "RootViewController.h"
#import "ADView.h"

typedef void (^refreshBlock) (void);

@interface MyWebViewController : RootViewController

@property(nonatomic,strong)NSString *url;

/*
 * shareUrl == 1  则在本页面获取分享信息
 *
 */
-(void)activityInfoWithShareType:(shareType)type shareText:(NSString *)text shareUrl:(NSString *)url;

///isRefresh == 1 则返回刷新
@property (nonatomic, copy) NSString *isRefresh;

@property (nonatomic, copy) refreshBlock block;

@property(nonatomic,strong)NSString *shareType;

@end

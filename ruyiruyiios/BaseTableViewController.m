//
//  BaseTableViewController.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/4/26.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "BaseTableViewController.h"
#import <AFNetworking.h>
@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置CGRectZero从导航栏下开始计算
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    //解决tableview 再iOS11下无法顶到顶
    if (@available(iOS 11.0, *)) {
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    

    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:20], NSFontAttributeName, nil]];
    
    self.navigationItem.leftBarButtonItem =[self BarButtonItemWithImage:[UIImage imageNamed:@"ic_back"] target:self action:@selector(backButtonAction)];
    
}

- (void)backButtonAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}



-(UIBarButtonItem *)BarButtonItemWithImage:(UIImage *)image target:(id)target action:(SEL)action
{
    UIButton*bt=[UIButton buttonWithType:UIButtonTypeCustom];
    [bt setImage:image forState:UIControlStateNormal];
    bt.frame=CGRectMake(0, 0, 33, 33);
    [bt addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:bt];
}

-(void)addRefreshControl{
    
    //上拉更多
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self loadMoreData];
        
    }];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self loadNewData];
        
    }];
}

-(void)loadMoreData{
    
    
}

-(void)loadNewData{
    
    
}

-(void)dealloc{
    
    [[[AFHTTPSessionManager manager]operationQueue] cancelAllOperations];
    
    NSLog(@"dealloc：%@",self);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/


@end

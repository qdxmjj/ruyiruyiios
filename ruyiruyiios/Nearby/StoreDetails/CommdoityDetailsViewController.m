//
//  CommdoityDetailsViewController.m
//  TestOrdersType
//
//  Created by 小马驾驾 on 2018/5/29.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "CommdoityDetailsViewController.h"

#import "StoreDetailsRequest.h"
#import <UIImageView+WebCache.h>
#import "UIButton+Subscript.h"
#import "MBProgressHUD+YYM_category.h"
#import "UserConfig.h"
#import "HeadView.h"
#import "BootView.h"
#import "TabbarView.h"
#import "ShopCartView.h"

#import "ContentTableViewController.h"
#import "StoreDetailsViewController.h"
#import "BuyCommdityViewController.h"

static NSInteger const HeadViewH = 150;

@interface CommdoityDetailsViewController ()<UINavigationControllerDelegate>

@property(nonatomic,strong)ContentTableViewController *contentVC;

@property(nonatomic,strong)ShopCartView *shopCartView;
@property(nonatomic,strong)BootView *bootV;
@property(nonatomic,strong)HeadView *headV;
@property(nonatomic,strong)TabbarView *tabbarV;

@property(nonatomic,strong)NSMutableArray *contentVCDataArr;


@property(nonatomic,strong)NSMutableArray *meirongArr;
@property(nonatomic,strong)NSMutableArray *anzhuangArr;
@property(nonatomic,strong)NSMutableArray *baoyangArr;
@property(nonatomic,strong)NSMutableArray *fuwuArr;


@property(nonatomic,assign)BOOL directoryRequest;
@property(nonatomic,assign)BOOL contentRequest;

@property(nonatomic,assign)NSInteger totalNumberProducts;

@property(nonatomic,strong)NSMutableDictionary *badgeNumberDic;
@end

@implementation CommdoityDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationController.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
//    NSLog(@"%@  %@",self.directoryRequest?@"YES":@"NO",self.contentRequest?@"YES":@"NO");
    
    [self.view addSubview:self.headV];
    
    [self.view addSubview:self.bootV];
    
    [self.view addSubview:self.tabbarV];
    
    [self addChildViewController:self.directoryVC];
    
    [self addChildViewController:self.contentVC];
    
    [self.view addSubview:self.directoryVC.tableView];
    
    [self.view addSubview:self.contentVC.tableView];
    
    
    __weak __typeof(self)weakSelf = self;
    
    //有空全都换成代理,好看
    //刷新商品详细内容
    self.directoryVC.refreshBlock = ^(NSInteger index, NSString *commodityID) {
    
        NSMutableArray *SubserviceCorrespondingGoods = [NSMutableArray array];
    
        if (SubserviceCorrespondingGoods.count>0) {
            
            [SubserviceCorrespondingGoods removeAllObjects];
        }
        //筛选全部的商品 获得对应商品目录下的商品
        for (NSDictionary *commodity in weakSelf.contentVCDataArr) {
            
            if ([[commodity objectForKey:@"serviceId"]longLongValue] ==[commodityID longLongValue]) {
                
                [SubserviceCorrespondingGoods addObject:commodity];
            }
            
        }
        //根据index来取得对应的内容
        weakSelf.contentVC.dataArr = SubserviceCorrespondingGoods;
        
        [weakSelf.contentVC.tableView reloadData];
    };
    
    
    //显示购物车列表
    self.bootV.showBlcok = ^(BOOL isShow) {
        
        if (isShow) {
            
            NSMutableArray *commodityArr = [NSMutableArray array];
            for (NSDictionary *commodityDic in weakSelf.contentVCDataArr) {
                
                if ([[commodityDic objectForKey:@"commodityNumber"] longLongValue] >0) {
                    
                    [commodityArr addObject:commodityDic];
                }
            }
            weakSelf.shopCartView.commodityList = commodityArr;
            [weakSelf.view addSubview:weakSelf.shopCartView];
            [weakSelf.view bringSubviewToFront:weakSelf.bootV];//添加新视图需设置一遍
            
        }else{
            
            [weakSelf.shopCartView removeFromSuperview];
        }
    };
    
    //点击刷新商品目录--默认为第一个大类服务
    self.tabbarV.serviceBlcok = ^(NSInteger row) {
      
        weakSelf.directoryVC.subScript = row;
    };
    
    //清空购物车
    self.shopCartView.removeBlock = ^(BOOL isRemove) {
        
        for (NSDictionary *commodityDic in weakSelf.contentVCDataArr) {
                
            if ([[commodityDic objectForKey:@"commodityNumber"] longLongValue] >0) {
                    
                [commodityDic setValue:@"0" forKey:@"commodityNumber"];
            }
        }
//        NSArray *arr = weakSelf.directoryVC.sevrviceGroup;
//        NSLog(@"目录：%@",arr);
        //清除角标
        for (NSMutableArray *arr in weakSelf.directoryVC.sevrviceGroup) {
            
            for (id dic in arr) {
                
                if ([dic isKindOfClass:[NSDictionary class]]) {
                    
                    if ([[dic objectForKey:@"badgeNumber"] longLongValue] !=0) {
                        
                        [dic setValue:@"0" forKey:@"badgeNumber"];
                    }
                }
            }
        }
        [weakSelf.directoryVC.tableView reloadData];

        [weakSelf.tabbarV emptyBadgeNumer];
        
        weakSelf.shopCartView.commodityList = @[];
        [weakSelf.shopCartView reloadTableView];
        [weakSelf.contentVC.tableView reloadData];
        weakSelf.bootV.numberLab.text = [NSString stringWithFormat:@"合计：0 元"];
        weakSelf.bootV.isDisplay = YES;
        weakSelf.bootV.totalPrice = @"0";
        [weakSelf.shopCartView removeFromSuperview];
    };
    
    
    //始终保持在最后设置
    [self.view bringSubviewToFront:self.bootV];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(totalPriceLessNotification:) name:@"TotalPriceLessNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(totalPricePlusNotification:) name:@"TotalPricePlusNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(totalPriceLessNotification:) name:@"ShopCartLessNotification" object:nil];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(totalPricePlusNotification:) name:@"ShopCartPlusNotification" object:nil];
    
    [self getCommodityInfoWithSetHeadView];
}


-(void)getCommodityInfoWithSetHeadView{
    
    //给子视图赋值，需在子视图添加完成之后
    if (self.commodityInfo.count>0) {
        
        [self getStoreDetailsInfoWithStoreID:[self.commodityInfo objectForKey:@"storeId"]];
        
        NSInteger storeId = [[self.commodityInfo objectForKey:@"storeId"] integerValue];
        
        [self getStockListByStoreWithStoreID:@(storeId)];
        
        [self.headV.storeImg sd_setImageWithURL:[NSURL URLWithString:[self.commodityInfo objectForKey:@"storeImg"]]];
        
        self.headV.storeName.text =[self.commodityInfo objectForKey:@"storeName"];
        self.headV.serviceTypeList = [self.commodityInfo objectForKey:@"storeServcieList"];
        
    }
}

#pragma mark 获取全部商品信息
-(void)getStockListByStoreWithStoreID:(NSNumber *)storeID{
    
    [StoreDetailsRequest getStockListByStoreWithInfo:@{@"shopId":storeID} succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
       
        NSArray *arr = [data objectForKey:@"rows"];
        
        for (NSDictionary * dic1 in arr) {
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            [dic setValuesForKeysWithDictionary:dic1];
            [dic setObject:@"0" forKey:@"commodityNumber"];///增加新字段 选择的商品数量
            
            [self.contentVCDataArr addObject:dic];
        }
        
        if (self.contentVCDataArr) {
            
            self.contentRequest = YES;
            
            if (self.directoryRequest && self.contentRequest) {
                
                if (self.clickButtonTag) {
                    
                    //如果有默认选择的商品，则跳转到对应的商品分类，self.clickButtonTag，分类页面点击商品跳转到对应页面
                    [self AutomaticClick:100100+self.clickButtonTag];
                    
                }else{
                    
                    //附近的门店进入此页面，执行此方法，默认选择第一个
                    [self AutomaticClick:100100];
                }
                
            }
            
        }

    } failure:^(NSError * _Nullable error) {
        
        
    }];
    
}


#pragma mark 获取全部的商品目录
-(void)getStoreDetailsInfoWithStoreID:(NSString *)storeID{
    
    [StoreDetailsRequest getStoreAddedServicesWith:@{@"storeId":storeID} succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if (self.directoryVC.sevrviceGroup.count>0) {
            
            [self.directoryVC.sevrviceGroup removeAllObjects];
            [self.meirongArr removeAllObjects];
            [self.anzhuangArr removeAllObjects];
            [self.baoyangArr removeAllObjects];
            [self.fuwuArr removeAllObjects];
        }
        
        // badgeNumber 角标数量
        //汽车保养  美容清洗 安装改装 轮胎服务 顺序不能乱
        for (NSMutableDictionary *dic in [data objectForKey:@"汽车保养"]) {
            
            NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];

            [dic1 setValuesForKeysWithDictionary:dic];
            
            [dic1 setObject:@"0" forKey:@"badgeNumber"];
            [self.baoyangArr addObject:dic1];
        }
        
        /**此参数是用来 确定选中哪一个目录的 不设置默认为0 也就是第一个目录
         * 如果有手动设置默认的话 那么跳转对应目录
         * 以下类同
         */
        [self.baoyangArr addObject:@"0"];
        
        for (NSMutableDictionary *dic in [data objectForKey:@"美容清洗"]) {
            
            NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
            
            [dic1 setValuesForKeysWithDictionary:dic];
            
            [dic1 setObject:@"0" forKey:@"badgeNumber"];
            [self.meirongArr addObject:dic1];
            
        }
        [self.meirongArr addObject:@"0"];
        
        for (NSMutableDictionary *dic in [data objectForKey:@"安装改装"]) {
            
            NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
            
            [dic1 setValuesForKeysWithDictionary:dic];
            
            [dic1 setObject:@"0" forKey:@"badgeNumber"];
            [self.anzhuangArr addObject:dic1];
        }
        [self.anzhuangArr addObject:@"0"];
        
        for (NSMutableDictionary *dic in [data objectForKey:@"轮胎服务"]) {
            
            NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
            
            [dic1 setValuesForKeysWithDictionary:dic];
            
            [dic1 setObject:@"0" forKey:@"badgeNumber"];
            [self.fuwuArr addObject:dic1];

        }
        [self.fuwuArr addObject:@"0"];
        

        
        [self.directoryVC.sevrviceGroup addObject:self.baoyangArr];
        [self.directoryVC.sevrviceGroup addObject:self.meirongArr];
        [self.directoryVC.sevrviceGroup addObject:self.anzhuangArr];
        [self.directoryVC.sevrviceGroup addObject:self.fuwuArr];
        
        if (self.directoryVC.sevrviceGroup.count>0) {
            
            self.directoryRequest = YES;
            
            if (self.directoryRequest && self.contentRequest) {
                
                if (self.clickButtonTag) {
                    
                    //自动选择时会调用此方法，self.clickButtonTag，分类页面点击商品跳转到对应页面
                    [self AutomaticClick:100100+self.clickButtonTag];
                    
                }else{
                    
                    //附近的门店进入此页面，执行此方法，默认选择第一个
                    [self AutomaticClick:100100];
                } 
            }
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
    
    
}

#pragma mark 通知事件
/**
 *商品数量的减少通知改变。并修改源数据的商品数量，用于刷新商品目录填充初始数量
 *info = @[0商品价格，1商品ID，2商品数量,3，小类ID，4大类ID];
 */
-(void)totalPriceLessNotification:(NSNotification *)info{
    
    NSArray *priceInfo = [info object];
    
    CGFloat number = [priceInfo[0] floatValue];

    CGFloat price = [self.bootV.totalPrice floatValue];
    self.bootV.totalPrice = [NSString stringWithFormat:@"%.2f",price-number];
    
    //判断所有的商品 取得ID  ID相同修改商品数量状态
    for (NSDictionary *dic in self.contentVCDataArr) {
        
        if ([[dic objectForKey:@"id"]longLongValue] == [priceInfo[1] longLongValue]) {
            
            // 修改源数据
            [dic setValue:priceInfo[2] forKey:@"commodityNumber"];
        }
    }
    
    [self.contentVC.tableView reloadData];
    
    //子服务角标显示
    for (id arr in self.directoryVC.sevrviceGroup) {
        
        if (![arr isKindOfClass:[NSArray class]]) {return;}
        
        for (id dic in arr) {
            
            if ([dic isKindOfClass:[NSDictionary class]]) {
                
                if ([[dic objectForKey:@"serviceId"] longLongValue] == [priceInfo[3] longLongValue]) {
                    
                    NSInteger number = [[dic objectForKey:@"badgeNumber"] integerValue];
                    
                    [dic setValue:[NSString stringWithFormat:@"%ld",number-1] forKey:@"badgeNumber"];//修改源数据
                    
                    [self.directoryVC refreshBadgeNumberWithserviceID:[priceInfo[3] integerValue]];
                    
                    break;
                }
            }}}
    
    //大类服务角标显示
    [self.tabbarV changeBadgeNumberWithButton:self.directoryVC.subScript status:NO];
}

/**
 *商品数量的增加通知改变。并修改源数据的商品数量，用于刷新商品目录填充初始数量
 */
-(void)totalPricePlusNotification:(NSNotification *)info{
    
    NSArray *priceInfo = [info object];
    
    CGFloat number = [priceInfo[0] floatValue];
    
    CGFloat price = [self.bootV.totalPrice floatValue];
    
    self.bootV.totalPrice = [NSString stringWithFormat:@"%.2f",price+number];
    
    for (NSDictionary *dic in self.contentVCDataArr) {
        
        if ([[dic objectForKey:@"id"]longLongValue] == [priceInfo[1] longLongValue]) {
            
            // 修改源数据
            [dic setValue:priceInfo[2] forKey:@"commodityNumber"];
        }
    }
    
    [self.contentVC.tableView reloadData];
    
    for (id arr in self.directoryVC.sevrviceGroup) {
        
        if (![arr isKindOfClass:[NSArray class]]) {return;}
        
        for (id dic in arr) {
            
            if ([dic isKindOfClass:[NSDictionary class]]) {
                
                if ([[dic objectForKey:@"serviceId"] longLongValue] == [priceInfo[3] longLongValue]) {
                    
                    NSInteger number = [[dic objectForKey:@"badgeNumber"] integerValue];
                    
                    [dic setValue:[NSString stringWithFormat:@"%ld",number+1] forKey:@"badgeNumber"];//修改源数据
                    
                    [self.directoryVC refreshBadgeNumberWithserviceID:[priceInfo[3] integerValue]];
                    
                    break;
                }
            }}}
    
    [self.tabbarV changeBadgeNumberWithButton:self.directoryVC.subScript status:YES];
}

#pragma mark button 点击事件
-(void)popViewController{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)pushBuyCommdityWithPayingViewController{
    
    NSMutableArray *commodityArr = [NSMutableArray array];
    for (NSDictionary *commodityDic in self.contentVCDataArr) {
        
        if ([[commodityDic objectForKey:@"commodityNumber"] longLongValue] >0) {
            
            [commodityArr addObject:commodityDic];
        }
    }
    
    if (commodityArr.count<=0) {
        
        [MBProgressHUD showTextMessage:@"没有选择商品!"];
        return;
    }
    
    BuyCommdityViewController *buyCommdityVC = [[BuyCommdityViewController alloc] init];
    
    buyCommdityVC.storeName = [self.commodityInfo objectForKey:@"storeName"];
    buyCommdityVC.userPhone =[UserConfig phone];
    buyCommdityVC.userName = [UserConfig nick];
    buyCommdityVC.totalPrice = self.bootV.totalPrice;
    buyCommdityVC.storeID = [self.commodityInfo objectForKey:@"storeId"];
    buyCommdityVC.commodityList = commodityArr;
    [self.navigationController pushViewController:buyCommdityVC animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}

-(void)pushStoreDetailsVC{
    
    StoreDetailsViewController *storeDetailsVC = [[StoreDetailsViewController alloc] init];
    storeDetailsVC.storeID = [self.commodityInfo objectForKey:@"storeId"];
    [self.navigationController pushViewController:storeDetailsVC animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}

-(void)AutomaticClick:(NSInteger )buttonTag{
    
    for (UIButton *btn in self.tabbarV.subviews) {
        
        if (btn.tag == buttonTag) {
            
            [btn sendActionsForControlEvents:UIControlEventTouchUpInside];//默认选中
        }
    }
}


#pragma mark 懒加载视图
-(DirectoryTableViewController *)directoryVC{
    
    if (!_directoryVC) {
        
        _directoryVC = [[DirectoryTableViewController alloc] initWithStyle:UITableViewStylePlain];
        _directoryVC.tableView.frame = CGRectMake(0, HeadViewH+45+2, self.view.frame.size.width/4+10, self.view.frame.size.height-HeadViewH-45-45-2-bottom_height);
        _directoryVC.tableView.backgroundColor = [UIColor colorWithRed:230/255.f green:230/255.f blue:230/255.f alpha:1.f];
    }
    
    return _directoryVC;
}

-(ContentTableViewController *)contentVC{
    
    if (!_contentVC) {
        
        _contentVC = [[ContentTableViewController alloc] initWithStyle:UITableViewStylePlain];
        _contentVC.tableView.frame = CGRectMake(self.view.frame.size.width/4+10, HeadViewH+45+2, self.view.frame.size.width-self.view.frame.size.width/4-10, self.view.frame.size.height-HeadViewH-45-45-2-bottom_height);
    }
    return _contentVC;
}

-(BootView *)bootV{
    
    if (!_bootV) {
    
        _bootV = [[BootView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-45-(Height_TabBar-49), self.view.frame.size.width, 45)];
        [_bootV.submitBtn addTarget:self action:@selector(pushBuyCommdityWithPayingViewController) forControlEvents:UIControlEventTouchUpInside];
        _bootV.layer.shadowOffset = CGSizeMake(0, 0);
        _bootV.layer.shadowOpacity = 0.5;
        _bootV.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    }
    return _bootV;
}

-(HeadView *)headV{
    
    if (!_headV) {
        
        _headV = [[HeadView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, HeadViewH)];
        [_headV.backBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
        [_headV.itemBtn addTarget:self action:@selector(pushStoreDetailsVC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headV;
}

-(TabbarView *)tabbarV{
    
    if (!_tabbarV) {
        
        _tabbarV = [[TabbarView alloc] initWithFrame:CGRectMake(0, HeadViewH, self.view.frame.size.width, 45)];
    }
    return _tabbarV;
}

-(ShopCartView *)shopCartView{
    
    if (!_shopCartView) {
        
        _shopCartView = [[ShopCartView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-self.bootV.frame.size.height-bottom_height)];
        [self.directoryVC.tableView bringSubviewToFront:_shopCartView];
    }
    return _shopCartView;
}

-(NSMutableArray *)contentVCDataArr{
    
    if (!_contentVCDataArr) {
        
        _contentVCDataArr = [NSMutableArray array];
    }
    return _contentVCDataArr;
}

-(NSMutableArray *)meirongArr{
    
    if (!_meirongArr) {
        
        _meirongArr = [NSMutableArray array];
    }
    return _meirongArr;
}

-(NSMutableArray *)baoyangArr{
    
    if (!_baoyangArr) {
        
        _baoyangArr = [NSMutableArray array];
    }
    return _baoyangArr;
}

-(NSMutableArray *)fuwuArr{
    
    if (!_fuwuArr) {
        
        _fuwuArr = [NSMutableArray array];
    }
    return _fuwuArr;
}

-(NSMutableArray *)anzhuangArr{
    
    if (!_anzhuangArr) {
        
        _anzhuangArr = [NSMutableArray array];
    }
    return _anzhuangArr;
}

-(NSMutableDictionary *)badgeNumberDic{
    
    if (!_badgeNumberDic) {
        
        _badgeNumberDic = [NSMutableDictionary dictionary];
        [_badgeNumberDic setObject:@"0" forKey:@"2"];
        [_badgeNumberDic setObject:@"0" forKey:@"3"];
        [_badgeNumberDic setObject:@"0" forKey:@"4"];
        [_badgeNumberDic setObject:@"0" forKey:@"5"];
    }
    return _badgeNumberDic;
}
-(void)dealloc{
    
    self.navigationController.delegate = nil;

    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"TotalPriceLessNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"TotalPricePlusNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ShopCartLessNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ShopCartPlusNotification" object:nil];
}


//隐藏导航栏
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//
//    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
//    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

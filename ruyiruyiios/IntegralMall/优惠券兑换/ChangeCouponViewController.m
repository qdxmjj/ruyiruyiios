//
//  ChangeCouponViewController.m
//  Menu
//
//  Created by 姚永敏 on 2018/12/24.
//  Copyright © 2018 YYM. All rights reserved.
//

#import "ChangeCouponViewController.h"
#import "ChangeCouponCell.h"
#import "MBProgressHUD+YYM_category.h"
@interface ChangeCouponViewController ()<UITableViewDelegate,UITableViewDataSource,ChangeCouponCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *goodsArr;
@property (copy, nonatomic) NSString *integral;
@property (weak, nonatomic) IBOutlet UILabel *integralLab;

@end

@implementation ChangeCouponViewController
- (instancetype)initWithIntegral:(NSString *)integral{
    self = [super init];
    if (self) {
        
        self.integral = integral;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    
    UIView * barBackground = self.navigationController.navigationBar.subviews.firstObject;
    if (@available(iOS 11.0, *))
    {
        barBackground.alpha = 0;
        [barBackground.subviews setValue:@(0) forKeyPath:@"alpha"];
    } else {
        barBackground.alpha = 0;
    }
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
- (void)viewWillDisappear:(BOOL)animated{
    
    UIView * barBackground = self.navigationController.navigationBar.subviews.firstObject;
    if (@available(iOS 11.0, *))
    {
        barBackground.alpha = 1;
        [barBackground.subviews setValue:@(1) forKeyPath:@"alpha"];
    } else {
        barBackground.alpha = 1;
    }
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"积分兑换";
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeAll;
    }
    
    self.integralLab.text = self.integral;

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ChangeCouponCell class]) bundle:nil] forCellReuseIdentifier:@"ChangeCouponCellID"];
    
    [JJRequest getRequest:[NSString stringWithFormat:@"%@/score/sku",INTEGRAL_IP] params:@{@"skuType":@"1"} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        if ([code integerValue] == 1) {
            
            for (NSDictionary *dic in data) {
                
                IntegralGoodsMode *model = [[IntegralGoodsMode alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [self.goodsArr addObject:model];
            }
            
            [self.tableView reloadData];
        }
        NSLog(@"实物积分商品：%@",data);
    } failure:^(NSError * _Nullable error) {
        
    }];
}

- (void)ClickExchangeButtonWithChangeCouponCell:(ChangeCouponCell *)cell{
    [MBProgressHUD showWaitMessage:@"正在兑换..." showView:self.view];
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    IntegralGoodsMode *model = self.goodsArr[indexPath.row];
    
    NSString *skuId = [NSString stringWithFormat:@"%@",model.skuId];
    NSString *skuImg = [NSString stringWithFormat:@"%@",model.imgUrl];
    NSString *score = [NSString stringWithFormat:@"%@",model.score];
    
    [JJRequest interchangeablePostRequestWithIP:INTEGRAL_IP path:@"/score/order" params:@{@"userId":[UserConfig user_id],@"orderType":@"2",@"skuId":skuId,@"skuImg":skuImg,@"score":score,@"addressId":@"",@"token":[UserConfig token]} success:^(id  _Nullable data) {
        
        [MBProgressHUD hideWaitViewAnimated:self.view];
        
        if ([data[@"status"] integerValue] == 1) {
            ///刷新主页积分
            self.block();
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError * _Nullable error) {
        [MBProgressHUD hideWaitViewAnimated:self.view];
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ChangeCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChangeCouponCellID" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    IntegralGoodsMode *model = self.goodsArr[indexPath.row];

    cell.goodsModel = model;
    
    if ([model.score integerValue] > [self.integral integerValue]) {
        
        cell.exchangeBtn.userInteractionEnabled = NO;
        [cell.exchangeBtn setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }else{
        cell.exchangeBtn.userInteractionEnabled = YES;
        [cell.exchangeBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ChangeCouponCell *changeCouponCell = (ChangeCouponCell *)cell;
    
    changeCouponCell.delegate = nil;
    
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.goodsArr.count>0) {
        return self.goodsArr.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
}
- (NSMutableArray *)goodsArr{
    if (!_goodsArr) {
        _goodsArr = [NSMutableArray array];
    }
    return _goodsArr;
}
@end

//
//  InterestsRenewViewController.m
//  ruyiruyiTest
//
//  Created by 姚永敏 on 2019/5/27.
//  Copyright © 2019 YYM. All rights reserved.
//

#import "InterestsRenewViewController.h"
#import "CashierViewController.h"
#import "InterestsRenewCell.h"

#import "MBProgressHUD+YYM_category.h"

@interface InterestsRenewViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSString *s_renewalYear;//选择的服务年限
    NSString *s_renewalPrice;//选择的服务价格
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *dayLab;

@end

@implementation InterestsRenewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"续约";
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([InterestsRenewCell class]) bundle:nil] forCellWithReuseIdentifier:@"InterestsRenewCellID"];
    
    NSString *endTime = [PublicClass getTimestampFromTime:self.data[@"serviceEndDate"] formatter:@"yyyy-MM-dd"];
    self.endTimeLab.text = [NSString stringWithFormat:@"%@到期",endTime];
    self.dayLab.text = [NSString stringWithFormat:@"%@天",self.data[@"remainingServiceDays"]];
    
    NSLog(@"%@",self.data);
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    InterestsRenewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"InterestsRenewCellID" forIndexPath:indexPath];
    
    cell.contentView.layer.cornerRadius = 5;
    
    cell.contentView.layer.masksToBounds = YES;
    
    cell.contentView.layer.borderWidth = 1;
    
    cell.contentView.layer.borderColor =[[UIColor grayColor] CGColor];
    
    NSDictionary *renewalPriceInfo = self.data[@"renewalPriceInfo"];
    switch (indexPath.item) {
        case 0:
            
            cell.priceLab.text = [NSString stringWithFormat:@"%@元",renewalPriceInfo[@"1"]];
            cell.yearLab.text = @"1年";
            break;
        case 1:
            cell.priceLab.text = [NSString stringWithFormat:@"%@元",renewalPriceInfo[@"2"]];
            cell.yearLab.text = @"2年";
            break;
        case 2:
            cell.priceLab.text = [NSString stringWithFormat:@"%@元",renewalPriceInfo[@"3"]];
            cell.yearLab.text = @"3年";
            break;
        case 3:
            cell.priceLab.text = [NSString stringWithFormat:@"%@元",renewalPriceInfo[@"4"]];
            cell.yearLab.text = @"4年";
            break;
        default:
            cell.priceLab.text = @"";
            cell.yearLab.text = @"";
            break;
    }
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSDictionary *renewalPriceInfo = self.data[@"renewalPriceInfo"];
    
    if (renewalPriceInfo.count>0) {
        
        return renewalPriceInfo.count;
    }
    return 0;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return CGSizeMake((self.view.frame.size.width-60)/2, (self.view.frame.size.width-60)/2/3);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    InterestsRenewCell *cell = (InterestsRenewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.layer.borderColor =[[UIColor redColor] CGColor];
    cell.yearLab.textColor = [UIColor redColor];
    cell.priceLab.textColor = [UIColor redColor];
    
    NSDictionary *renewalPriceInfo = self.data[@"renewalPriceInfo"];
    switch (indexPath.item) {
        case 0:
            
            s_renewalPrice = [NSString stringWithFormat:@"%@",renewalPriceInfo[@"1"]];
            s_renewalYear = @"1";
            break;
        case 1:
            s_renewalPrice = [NSString stringWithFormat:@"%@",renewalPriceInfo[@"2"]];
            s_renewalYear = @"1";
            break;
        case 2:
            s_renewalPrice = [NSString stringWithFormat:@"%@",renewalPriceInfo[@"3"]];
            s_renewalYear = @"1";
            break;
        case 3:
            s_renewalPrice = [NSString stringWithFormat:@"%@",renewalPriceInfo[@"4"]];
            s_renewalYear = @"1";
            break;
        default:
            s_renewalPrice = @"";
            s_renewalYear = @"";
            break;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    InterestsRenewCell *cell = (InterestsRenewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    cell.yearLab.textColor = [UIColor grayColor];
    cell.priceLab.textColor = [UIColor grayColor];
    cell.contentView.layer.borderColor =[[UIColor grayColor] CGColor];
}
- (IBAction)renewNowEvent:(UIButton *)sender {
    
    if (!s_renewalYear||s_renewalYear.length<=0||!s_renewalPrice||s_renewalPrice.length<=0) {
        
        [PublicClass showHUD:@"请选择续约年限!" view:self.view];
        return;
    }
    
    [MBProgressHUD showWaitMessage:@"正在发起支付..." showView:self.view];
    
    NSString *barCodeCount = [NSString stringWithFormat:@"%ld",[self.data[@"barCodeVoList"] count]];
    NSString *serviceYear = [NSString stringWithFormat:@"%@",self.data[@"serviceYearLength"]];
    NSString *serviceEndTime = [NSString stringWithFormat:@"%@",self.data[@"serviceEndDate"]];
    
    NSString *reqJson = [PublicClass convertToJsonData:@{@"userId":[UserConfig user_id],@"userCarId":[UserConfig userCarId],@"shoeNum":barCodeCount,@"serviceYearLength":serviceYear,@"renewalYear":s_renewalYear,@"renewalPrice":s_renewalPrice,@"serviceEndTime":serviceEndTime}];
    
    [JJRequest postRequest:@"/renewalOrderInfo/addRenewalOrder" params:@{@"reqJson":reqJson,@"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        [MBProgressHUD hideWaitViewAnimated:self.view];
        
        if ([code longLongValue] == 1) {
            
            CashierViewController *cashierVC = [[CashierViewController alloc] init];
            
            cashierVC.orderTypeStr = @"8";
            cashierVC.orderNoStr = data;
            cashierVC.totalPriceStr = s_renewalPrice;
            
            [self.navigationController pushViewController:cashierVC animated:YES];
        }
        NSLog(@"订单号:%@",data);
    } failure:^(NSError * _Nullable error) {
        
        [MBProgressHUD hideWaitViewAnimated:self.view];
    }];
}
@end

//
//  MyInterestsViewController.m
//  ruyiruyiTest
//
//  Created by 姚永敏 on 2019/5/27.
//  Copyright © 2019 YYM. All rights reserved.
//

#import "MyInterestsViewController.h"
#import "InterestsRenewViewController.h"
#import "MyInterestsCell.h"
#import "MBProgressHUD+YYM_category.h"
#define IS_iPhone_5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_iPhone_6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)


@interface MyInterestsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSDictionary *interestsData;
}
@property (weak, nonatomic) IBOutlet UIView *interestsBackgroundView;
@property (weak, nonatomic) IBOutlet UIView *contentBackGroundView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *serviceContentHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *serviceContentTopConstraint;

@property (weak, nonatomic) IBOutlet UIImageView *serviceInfoImgView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *maturityTimeLab;

@property (strong, nonatomic) NSArray *barCodeArr;


@end

@implementation MyInterestsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.serviceInfoImgView.layer.cornerRadius = 10;
    self.serviceInfoImgView.layer. masksToBounds = YES;
    
    if (IS_iPhone_5) {
        self.serviceContentHeightConstraint.constant = 60;
        self.serviceContentTopConstraint.constant = 10;
    }
    
    UIImage *image = [UIImage imageNamed:@"vip.png"];
    
    self.interestsBackgroundView.layer.contents = (id)image.CGImage;
    
    UIImage *image1 = [UIImage imageNamed:@"ic_zhengwen.png"];
    
    self.contentBackGroundView.layer.contents = (id)image1.CGImage;
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MyInterestsCell class]) bundle:nil] forCellWithReuseIdentifier:@"MyInterestsCellID"];

    
    [self getInterestsInfoData];
}

- (IBAction)popCurrentViewControllerEvent:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)LookCouponsEvent:(UIButton *)sender {
    

}
- (IBAction)renewNowEvent:(UIButton *)sender {
    
    if (self.barCodeArr.count<=0) {
        
        [PublicClass showHUD:@"您还未购买轮胎" view:self.view];
        return;
    }
    
    if (interestsData.count <= 0) {
        
        [MBProgressHUD showTextMessage:@"数据获取失败！"];
        return;
    }
    
    InterestsRenewViewController *vc = [[InterestsRenewViewController alloc] init];
    vc.data = interestsData;
    [self.navigationController pushViewController:vc animated:YES];
    
    self.hidesBottomBarWhenPushed = YES;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    MyInterestsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyInterestsCellID" forIndexPath:indexPath];
    
    if (self.barCodeArr.count>0) {
        
        NSString *barcodeStr = self.barCodeArr[indexPath.item][@"barCode"];
        NSArray *dayStr = self.barCodeArr[indexPath.item][@"usedDays"];
        
        cell.lab.text = [NSString stringWithFormat:@"NO.%@  %@天",barcodeStr,dayStr];
    }else{
        
        cell.lab.text = @"您还未购买轮胎！";
    }
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.barCodeArr.count>0) {
        
        return self.barCodeArr.count;
    }
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return CGSizeMake((collectionView.frame.size.width-15-10)/2, 20);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    
    return UIEdgeInsetsMake(0, 5, 0, 5);
}

- (void)getInterestsInfoData{
    
    [MBProgressHUD showWaitMessage:@"正在获取数据..." showView:self.view];
    
    NSString *reqJson = [PublicClass convertToJsonData:@{@"userId":[UserConfig user_id],@"userCarId":[UserConfig userCarId]}];
    
    [JJRequest postRequest:@"/userEquityInfo/getUserEquityInfo" params:@{@"reqJson":reqJson} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
    
        [MBProgressHUD hideWaitViewAnimated:self.view];
       
        if ([code longLongValue] == 200) {
            
            
        }else if([code longLongValue] == 1){
            
            interestsData = data;
            
            self.barCodeArr = data[@"barCodeVoList"];
            
            NSString *endTime = [PublicClass getTimestampFromTime:data[@"serviceEndDate"] formatter:@"yyyy-MM-dd"];
            
            self.maturityTimeLab.text = [NSString stringWithFormat:@"%@到期",endTime];
            
            [self.collectionView reloadData];

        }else{
            
        }
        
    } failure:^(NSError * _Nullable error) {
        [MBProgressHUD hideWaitViewAnimated:self.view];
    }];
}

- (NSArray *)barCodeArr{
    if (!_barCodeArr) {
        
        _barCodeArr = [NSArray array];
    }
    return _barCodeArr;
}
@end

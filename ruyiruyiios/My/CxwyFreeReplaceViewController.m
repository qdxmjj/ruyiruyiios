//
//  CxwyFreeReplaceViewController.m
//  ruyiruyiios
//
//  Created by 姚永敏 on 2018/9/20.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "CxwyFreeReplaceViewController.h"
#import "FirstUpdateCollectionViewCell.h"
#import "NearbyViewController.h"
#import <UIImageView+WebCache.h>
#import "MBProgressHUD+YYM_category.h"
#import "HYStepper.h"
#import "CarCXWYInfo.h"
@interface CxwyFreeReplaceViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,valueChangdDelegate>
{
    
    CGFloat tireTotalNumber;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionVIew;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *distance;//设置间距 前后轮一致 只显示一个信息 叫当前轮胎数量 前后轮不一致 显示两个  前轮数量 后轮数量 修改间距 隐藏后轮数量 修改前轮数量显示内容为：当前轮胎数量

@property (weak, nonatomic) IBOutlet UILabel *userLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UILabel *carCodeLab;
@property (weak, nonatomic) IBOutlet UILabel *cxwyNumberLab;//可换轮胎数量 即为畅行无忧数量

@property (weak, nonatomic) IBOutlet HYStepper *frontStepper;
@property (weak, nonatomic) IBOutlet HYStepper *rearStepper;

@property (weak, nonatomic) IBOutlet UILabel *frontTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *rearTitleLab;

@property (weak, nonatomic) IBOutlet UILabel *frontNumberLab;
@property (weak, nonatomic) IBOutlet UILabel *rearNumberLab;
//默认门店信息
@property (weak, nonatomic) IBOutlet UIView *storeView;

@property (weak, nonatomic) IBOutlet UIImageView *storeImgView;
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *sotreAddress;
@property (weak, nonatomic) IBOutlet UILabel *storeDistance;

@property (nonatomic, strong)NSMutableArray *functionMutableA;

@property (nonatomic, strong)NSString *storeID;

@end

@implementation CxwyFreeReplaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"免费再换";
    
    self.frontStepper.delagate = self;
    self.rearStepper.delagate = self;
    
    [self.collectionVIew registerClass:[FirstUpdateCollectionViewCell class] forCellWithReuseIdentifier:@"cxwyFreeReplaceCollectionViewCellID"];
    
    [self getBarCodeInfo];//获取车牌号
    [self selectStoreByCondition];//获取第一个店铺，默认店铺
    
    self.userLab.text = [UserConfig nick];
    self.phoneLab.text = [UserConfig phone];
    self.cxwyNumberLab.text = [NSString stringWithFormat:@"%ld",self.cxwyList.count];
    
    if ([[self.tireInfoDic objectForKey:@"fontRearFlag"] longLongValue] == 0) {
        
        self.distance.constant = 15.f;
        self.frontTitleLab.text = @"所有轮胎数量";
        self.rearNumberLab.hidden = YES;
        self.rearTitleLab.hidden = YES;
        self.frontNumberLab.text = [NSString stringWithFormat:@"%@",self.tireInfoDic[@"fontAmount"]];
        
        //可选轮胎数量 不可以超过畅行无忧数量
        if (self.cxwyList.count < [self.tireInfoDic[@"fontAmount"] integerValue]) {
            
            tireTotalNumber = self.cxwyList.count;
        }else{
            
            tireTotalNumber = [self.tireInfoDic[@"fontAmount"] floatValue];
        }
        
        if (tireTotalNumber >=2.f) {
            
            self.frontStepper.maxValue = 2;
        }else{
            
            self.frontStepper.maxValue = tireTotalNumber;
        }
        
        if (tireTotalNumber >=2.f) {
            
            self.rearStepper.maxValue = 2;
        }else{
            
            self.rearStepper.maxValue = tireTotalNumber;
        }
        
    }else{
        
        self.frontNumberLab.text = [NSString stringWithFormat:@"%@",self.tireInfoDic[@"fontAmount"]];
        self.rearNumberLab.text = [NSString stringWithFormat:@"%@",self.tireInfoDic[@"rearAmount"]];
        
        if (self.cxwyList.count<2) {
            
            self.frontStepper.maxValue = self.cxwyList.count;
            self.rearStepper.maxValue = self.cxwyList.count;
        }else{
            
            self.frontStepper.maxValue = [self.tireInfoDic[@"fontAmount"] floatValue];
            self.rearStepper.maxValue = [self.tireInfoDic[@"rearAmount"] floatValue];
        }
    }
    
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(storeViewAction:)];
    
    [self.storeView addGestureRecognizer:tapGesturRecognizer];
    
}


- (IBAction)submitOrderEvent:(UIButton *)sender {
    
    if ((self.frontStepper.value + self.rearStepper.value) <= 0) {
        
        [PublicClass showHUD:@"最少选择一个轮胎！" view:self.view];
        return;
    }else if ((self.frontStepper.value + self.rearStepper.value) != self.cxwyList.count){
        
        [PublicClass showHUD:@"轮胎数量请与优惠券数量一致！" view:self.view];
        return;
    }else{
    }
    
    if (self.storeID.length<=0) {
        
        [PublicClass showHUD:@"请选择一个门店！" view:self.view];
        return;
    }
    
    NSMutableArray *cxwyIDList = [NSMutableArray array];
    
    for (CarCXWYInfo *cxwyInfo in self.cxwyList) {
        
        [cxwyIDList addObject:[NSString stringWithFormat:@"%@",cxwyInfo.carCXWYInfoid]];
    }
    
    NSString *cxwuIDStr = [cxwyIDList componentsJoinedByString:@";"];
    
    NSDictionary *params  = @{@"storeId":self.storeID,@"userCarId":[UserConfig userCarId],@"userId":[UserConfig user_id],@"fontAmount":[NSString stringWithFormat:@"%.0f",self.frontStepper.value],@"rearAmount":[NSString stringWithFormat:@"%.0f",self.rearStepper.value],@"fontRearFlag":self.tireInfoDic[@"fontRearFlag"],@"orderType":@"3",@"reason":@"0",@"cxwyList":cxwuIDStr};
    
    NSString *reqJsonStr = [PublicClass convertToJsonData:params];

    [JJRequest postRequest:@"/addFreeChangeOrderWithCXWY" params:@{@"reqJson":reqJsonStr,@"token":[UserConfig token ]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if ([code longLongValue] == 1) {
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
        if ([code longLongValue] == -99) {
            
            [PublicClass showHUD:@"当前有进行中订单!" view:self.view];
        }else{
            
            [MBProgressHUD showTextMessage:message];
        }
        
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}


-(void)storeViewAction:(id)view
{
    
    NSLog(@"点击了storeView");
    NearbyViewController *nearbyVC = [[NearbyViewController alloc] init];
    nearbyVC.condition = @"轮胎服务";
    nearbyVC.status = @"1";
    nearbyVC.isLocation = @"1";
    nearbyVC.serviceType = @"5";
    nearbyVC.backBlock = ^(NSDictionary *dataDic) {
        
        [self setStoreInfo:dataDic];
    };
    [self.navigationController pushViewController:nearbyVC animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}

-(void)setStoreInfo:(NSDictionary *)info{
    
    CGFloat distance = [info[@"distance"] floatValue];
    
    [self.storeImgView sd_setImageWithURL:[NSURL URLWithString:info[@"storeImg"]]];
    self.storeName.text = info[@"storeName"];
    self.storeDistance.text = [NSString stringWithFormat:@"%.1fkm",distance/1000];
    self.sotreAddress.text = info[@"storeAddress"];
    self.storeID = info[@"storeId"];
    if (self.functionMutableA.count>0) {
        
        [self.functionMutableA removeAllObjects];
    }
    
    for (NSDictionary *serviceDIC in info[@"storeServcieList"]) {
        
        StoreServiceInfo *serviceinfo = [[StoreServiceInfo alloc] init];
        
        [serviceinfo setValuesForKeysWithDictionary:[serviceDIC objectForKey:@"service"]];
        
        [self.functionMutableA addObject:serviceinfo];
    }
    
    [self.collectionVIew reloadData];
    
}

- (void)valueChangedWithValue:(CGFloat)value stepper:(HYStepper *)stepper {

    if ([[self.tireInfoDic objectForKey:@"fontRearFlag"] longLongValue] == 0) {
        
        //前轮后轮 每种最多选择两个 两者加起来的总数最多与前后轮总数齐平 不可以超过畅行无忧数量
        if ([stepper isEqual:self.frontStepper]) {
            
            CGFloat rearNumber = tireTotalNumber-value;
            
            if (rearNumber >=2.f) {
                
                self.rearStepper.maxValue = 2;
            }else{
                
                self.rearStepper.maxValue = rearNumber;
            }
        }else{
            
            CGFloat frontNumber = tireTotalNumber-value;
            
            if (frontNumber >=2.f) {
                
                self.frontStepper.maxValue = 2;
            }else{
                
                self.frontStepper.maxValue = frontNumber;
            }
        }
    }else{
        
        //前后轮不一致 总轮胎数量 不可以超过畅行无忧数量
        if ([stepper isEqual:self.frontStepper]) {
         
            CGFloat frontTotalNumber = self.cxwyList.count-value;

            if (frontTotalNumber>=2.f) {
                
                self.rearStepper.maxValue = 2;
            }else{
                self.rearStepper.maxValue = frontTotalNumber;
            }
        }else{
            
            CGFloat rearTotalNumber = self.cxwyList.count-value;

            if (rearTotalNumber>=2.f) {
                
                self.frontStepper.maxValue = 2;
            }else{
                self.frontStepper.maxValue = rearTotalNumber;
            }
        }
    }
}


-(void)getBarCodeInfo{
    
    NSDictionary *getCarDic = @{@"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]], @"userCarId":[NSString stringWithFormat:@"%@", [UserConfig userCarId]]};
    NSString *reqJson = [PublicClass convertToJsonData:getCarDic];
    
    [JJRequest postRequest:@"getCarByUserIdAndCarId" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        
        if ([statusStr isEqualToString:@"1"]) {
            
            if ([data isEqual:[NSNull null]] ) {
                
                [PublicClass showHUD:@"请先添加车辆！" view:self.view];
                return ;
            }
            self.carCodeLab.text = [NSString stringWithFormat:@"%@",[data objectForKey:@"platNumber"]];
            
            
        }else if ([statusStr isEqualToString:@"-999"]){
            
            [self alertIsequallyTokenView];
            
        }else{
            
            if ([messageStr isEqualToString:@"查询用户车辆失败"]) {
                [PublicClass showHUD:@"请先添加车辆！" view:self.view];
            }else{
                [PublicClass showHUD:messageStr view:self.view];
            }
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"车牌号信息错误:%@", error);
    }];
}

- (void)selectStoreByCondition{
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"currentCity"] == NULL) {
        
        [PublicClass showHUD:@"定位失败" view:self.view];
    }else{
        
        NSString *longitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"longitude"] == NULL ? @"" : [[NSUserDefaults standardUserDefaults] objectForKey:@"longitude"];
        NSString *latitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"latitude"] == NULL ? @"" : [[NSUserDefaults standardUserDefaults] objectForKey:@"latitude"];
        
        NSDictionary *postDic = @{@"page":@"1", @"rows":@"1", @"cityName":[[NSUserDefaults standardUserDefaults] objectForKey:@"currentCity"], @"storeName":@"", @"storeType":@"", @"serviceType":@"5", @"longitude":longitude, @"latitude":latitude, @"rankType":@"1"};
        NSString *reqJson = [PublicClass convertToJsonData:postDic];
        [JJRequest postRequest:@"selectStoreByCondition" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
            
            NSString *statusStr = [NSString stringWithFormat:@"%@", code];
            NSString *messageStr = [NSString stringWithFormat:@"%@", message];
            if ([statusStr isEqualToString:@"1"]) {
                
                NSLog(@"店铺%@", data);
                
                if ([[data objectForKey:@"storeQuaryResVos"] count]<=0) {
                    
                    [PublicClass showHUD:@"周围没有店铺！" view:self.view];
                    return;
                }
                
                [self setStoreInfo:[data[@"storeQuaryResVos"] objectAtIndex:0]];

            }else{
                
                [PublicClass showHUD:messageStr view:self.view];
            }
        } failure:^(NSError * _Nullable error) {
            
            NSLog(@"获取筛选店铺错误:%@", error);
        }];
    }
}

#pragma mark UICollectionViewDelegate and UICollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (self.functionMutableA.count>0) {
        
        return self.functionMutableA.count;
    }
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"cxwyFreeReplaceCollectionViewCellID";
    FirstUpdateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    
    StoreServiceInfo *storeServiceInfo = [self.functionMutableA objectAtIndex:indexPath.item];
        
    [cell setDatatoBtn:storeServiceInfo];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%f",collectionView.frame.size.width);
    return  CGSizeMake((collectionView.frame.size.width-10)/2,20);
}

-(NSMutableArray *)functionMutableA{
    
    if (!_functionMutableA) {
        
        _functionMutableA = [NSMutableArray array];
    }
    
    return _functionMutableA;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

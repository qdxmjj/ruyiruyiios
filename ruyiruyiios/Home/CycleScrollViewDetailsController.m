//
//  CycleScrollViewDetailsController.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/7/19.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "CycleScrollViewDetailsController.h"
#import "SelectTirePositionViewController.h"
#import "YMDetailedServiceViewController.h"
#import "NewTirePurchaseViewController.h"
#import "CarInfoViewController.h"
@interface CycleScrollViewDetailsController ()


@property(nonatomic,strong)UIImageView *backGroupView;

@property(nonatomic,strong)UIButton *btn;

@property(nonatomic,strong)UIScrollView *scrollView;

@end

@implementation CycleScrollViewDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"最新活动";

    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.backGroupView];
    
    if (self.index == 0) {
        [self.view addSubview:self.btn];
    }
}

#pragma mark 跳转轮胎购买页面事件
#pragma mark buttoncheckEvent
-(void)pushBuyingTireViewController{
    
    switch (self.index) {
        case 0:
            
            if ([self.dataCars isEqual:[NSNull null]] || self.dataCars == nil || !self.dataCars || [UserConfig userCarId].intValue == 0) {
                
                //        [PublicClass showHUD:@"轮胎信息获取失败！" view:self.view];
                
                CarInfoViewController *carinfoVC = [[CarInfoViewController alloc] init];
                carinfoVC.is_alter = YES;
                [self.navigationController pushViewController:carinfoVC animated:YES];
                self.hidesBottomBarWhenPushed = YES;
                return;
            }

            //前后轮一致 直接进入轮胎购买页面 不一致先进入选择前后轮界面 再进入轮胎购买
            if ([self.dataCars.font isEqualToString:self.dataCars.rear]) {
                
                NewTirePurchaseViewController *newTireVC = [[NewTirePurchaseViewController alloc] init];
                
                newTireVC.fontRearFlag = @"0";
                newTireVC.tireSize = self.dataCars.font;
                newTireVC.service_end_date = self.dataCars.service_end_date;
                newTireVC.service_year = self.dataCars.service_year;
                newTireVC.service_year_length = self.dataCars.service_year_length;
                
                [self.navigationController pushViewController:newTireVC animated:YES];
                self.hidesBottomBarWhenPushed = YES;
            }else{
                
                SelectTirePositionViewController *selectTPVC = [[SelectTirePositionViewController alloc] init];
                selectTPVC.dataCars = self.dataCars;
                [self.navigationController pushViewController:selectTPVC animated:YES];
                self.hidesBottomBarWhenPushed = YES;
            }
            break;
            
        default:
            NSLog(@"跳转异常");
            break;
    }
}

-(UIScrollView *)scrollView{
    
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height-SafeAreaTopHeight)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.scrollsToTop = NO;
    }
    return _scrollView;
}

-(UIImageView *)backGroupView{
    
    if (!_backGroupView) {
        _backGroupView = [[UIImageView alloc] init];
        NSString *imgName = @"";
        switch (self.index) {
            case 0:
                imgName = @"ic_bujimianpei";
                _backGroupView.frame = CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height-SafeAreaTopHeight);
                break;
            case 1:
                imgName = @"ic_jingpin";
                _backGroupView.frame = CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height-SafeAreaTopHeight);

                break;
            case 2:
                imgName = @"ic_neirong";
                _backGroupView.frame = CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height-SafeAreaTopHeight);
                break;
            case 3:
                imgName = @"ic_hd4_bj";
                _backGroupView.frame = CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height+200);
                _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame),  MAINSCREEN.height+200);

                break;
                
            default:
                break;
        }
        _backGroupView.image = [UIImage imageNamed:imgName];
    }
    return _backGroupView;
}

-(UIButton *)btn{
    
    if (!_btn) {
        
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn addTarget:self action:@selector(pushBuyingTireViewController) forControlEvents:UIControlEventTouchUpInside];
        NSString *imgName = @"";
        switch (self.index) {
            case 0:
                imgName = @"ic_button";
                [_btn setFrame:CGRectMake((MAINSCREEN.width - MAINSCREEN.width*0.7)/2, MAINSCREEN.height-44-20-Height_TabBar, MAINSCREEN.width*0.7, MAINSCREEN.height*0.07)];
                break;
            default:
                break;
        }
        [_btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    }
    return _btn;
}


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

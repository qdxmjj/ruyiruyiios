//
//  CycleScrollViewDetailsController.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/7/19.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "CycleScrollViewDetailsController.h"
#import "ChoicePatternViewController.h"
#import "SelectTirePositionViewController.h"
#import "YMDetailedServiceViewController.h"
@interface CycleScrollViewDetailsController ()


@property(nonatomic,strong)UIImageView *backGroupView;

@property(nonatomic,strong)UIButton *btn;

@end

@implementation CycleScrollViewDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"最新活动";

    [self.view addSubview:self.backGroupView];
    [self.view addSubview:self.btn];
}

#pragma mark 跳转轮胎购买页面事件
- (void)chickBuytyreEvent{
    
    if ([self.dataCars.font isEqualToString:self.dataCars.rear]) {
        
        ChoicePatternViewController *choicePVC = [[ChoicePatternViewController alloc] init];
        choicePVC.tireSize = self.dataCars.font;
        choicePVC.fontRearFlag = @"0";
        [self.navigationController pushViewController:choicePVC animated:YES];
    }else{
        
        SelectTirePositionViewController *selectTPVC = [[SelectTirePositionViewController alloc] init];
        selectTPVC.dataCars = self.dataCars;
        [self.navigationController pushViewController:selectTPVC animated:YES];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark buttoncheckEvent

-(void)pushBuyingTireViewController{
    
    switch (self.index) {
        case 0:case 1:

            if ([self.dataCars.font isEqualToString:self.dataCars.rear]) {
                
                ChoicePatternViewController *choicePVC = [[ChoicePatternViewController alloc] init];
                choicePVC.tireSize = self.dataCars.font;
                choicePVC.fontRearFlag = @"0";
                [self.navigationController pushViewController:choicePVC animated:YES];
            }else{
                
                SelectTirePositionViewController *selectTPVC = [[SelectTirePositionViewController alloc] init];
                selectTPVC.dataCars = self.dataCars;
                [self.navigationController pushViewController:selectTPVC animated:YES];
            }
            break;
        case 3:{
         
            YMDetailedServiceViewController *detailedServiceVC = [[YMDetailedServiceViewController alloc] init];
            
            detailedServiceVC.title = @"搜索商品";
            detailedServiceVC.serviceID = @"";
            detailedServiceVC.serviceName = @"精致洗车";
            
            [self.navigationController pushViewController:detailedServiceVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

-(UIImageView *)backGroupView{
    
    if (!_backGroupView) {
        _backGroupView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height-SafeAreaTopHeight)];
        NSString *imgName = @"";
        switch (self.index) {
            case 0:
                imgName = @"ic_huoodng_3";
                break;
            case 1:
                imgName = @"ic_huoodng_1";
                break;
            case 2:
                break;
            case 3:
                imgName = @"ic_huoodng_2";
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
                imgName = @"ic_hd_button3";
                [_btn setFrame:CGRectMake((MAINSCREEN.width - MAINSCREEN.width*0.7)/2, MAINSCREEN.height-44-20-Height_TabBar, MAINSCREEN.width*0.7, MAINSCREEN.height*0.07)];

                break;
            case 1:
                imgName = @"ic_hd_button1";
                [_btn setFrame:CGRectMake((MAINSCREEN.width - MAINSCREEN.width*0.51)/2, MAINSCREEN.height-54-20-Height_TabBar, MAINSCREEN.width*0.51, MAINSCREEN.height*0.08)];

                break;
            case 2:
                break;
            case 3:
                imgName = @"ic_hd_button2";
                [_btn setFrame:CGRectMake((MAINSCREEN.width - MAINSCREEN.width*0.7)/2, MAINSCREEN.height-52-20-Height_TabBar, MAINSCREEN.width*0.7, MAINSCREEN.height*0.08)];

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

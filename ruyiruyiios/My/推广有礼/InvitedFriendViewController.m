//
//  InvitedFriendViewController.m
//  ruyiruyiios
//
//  Created by 姚永敏 on 2018/12/4.
//  Copyright © 2018 ruyiruyi. All rights reserved.
//

#import "InvitedFriendViewController.h"
#import "FriendListController.h"
#import <Masonry.h>
@interface InvitedFriendViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)FriendListController *notConsumptionVC;
@property(nonatomic,strong)FriendListController *ConsumptionVC;
@property(nonatomic,strong)UIScrollView *mainView;
@property(nonatomic,strong)UIButton *noConsumptionBtn;
@property(nonatomic,strong)UIButton *ConsumptionBtn;
@property(nonatomic,strong)UIView *lineView;
@end

@implementation InvitedFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"邀请有礼";
    [self.view addSubview:self.noConsumptionBtn];
    [self.view addSubview:self.ConsumptionBtn];
    [self.view addSubview:self.lineView];
    [self.view addSubview:self.mainView];
    [self addChildViewController:self.notConsumptionVC];
    [self.mainView addSubview:self.notConsumptionVC.view];
    [self addChildViewController:self.ConsumptionVC];
    [self.mainView addSubview:self.ConsumptionVC.view];
    
    [self.noConsumptionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.mas_equalTo(self.view);
        make.width.mas_equalTo(self.view.frame.size.width/2);
        make.height.mas_equalTo(45);
    }];
    [self.ConsumptionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.right.mas_equalTo(self.view);
        make.width.mas_equalTo(self.view.frame.size.width/2);
        make.height.mas_equalTo(45);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.noConsumptionBtn.mas_bottom);
        make.height.mas_equalTo(2);
        make.width.mas_equalTo(self.view.frame.size.width/4);
        make.left.mas_equalTo(self.view.frame.size.width/8);
    }];
    
    self.mainView.frame = CGRectMake(0, 47, MAINSCREEN.width, MAINSCREEN.height-45-2-SafeAreaTopHeight);
    
    self.notConsumptionVC.view.frame = CGRectMake(0, 0, MAINSCREEN.width, self.mainView.frame.size.height);
    
    self.ConsumptionVC.view.frame = CGRectMake(MAINSCREEN.width, 0, MAINSCREEN.width, self.mainView.frame.size.height);
}


#pragma mark event
-(void)topBtnPressed:(UIButton *)btn{
    
    [self.mainView setContentOffset:CGPointMake(btn.frame.origin.x*2, 0) animated:YES];
}

#pragma mark scrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    if (scrollView.contentOffset.x == MAINSCREEN.width) {
        
        [self.noConsumptionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.ConsumptionBtn setTitleColor:LOGINBACKCOLOR forState:UIControlStateNormal];
    }else if(scrollView.contentOffset.x == 0){
        
        [self.noConsumptionBtn setTitleColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [self.ConsumptionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else{
        
    }
    [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(scrollView.contentOffset.x/2+self.view.frame.size.width/8);
    }];
}

-(UIScrollView *)mainView{
    
    if (!_mainView) {
        
        _mainView = [[UIScrollView alloc] init];
        _mainView.contentSize = CGSizeMake(MAINSCREEN.width*2, 0);
        _mainView.backgroundColor=[UIColor lightGrayColor];
        _mainView.showsVerticalScrollIndicator=NO;
        _mainView.delegate=self;
        _mainView.showsHorizontalScrollIndicator=NO;
        _mainView.pagingEnabled=YES;
    }
    return _mainView;
}
-(UIButton *)noConsumptionBtn{
    
    if (!_noConsumptionBtn) {
        
        _noConsumptionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_noConsumptionBtn setTitle:@"未消费" forState:UIControlStateNormal];
        [_noConsumptionBtn setTitleColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [_noConsumptionBtn addTarget:self action:@selector(topBtnPressed:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _noConsumptionBtn;
}
-(UIButton *)ConsumptionBtn{
    
    if (!_ConsumptionBtn) {
        
        _ConsumptionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_ConsumptionBtn setTitle:@"已消费" forState:UIControlStateNormal];
        [_ConsumptionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_ConsumptionBtn addTarget:self action:@selector(topBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _ConsumptionBtn;
}
-(FriendListController *)notConsumptionVC{
    
    if (!_notConsumptionVC) {
        
        _notConsumptionVC = [[FriendListController alloc] initWithStyle:UITableViewStyleGrouped withCellIdentifier:@"notConsumptionCellID" withState:@"0"];
//        _notConsumptionVC.view.backgroundColor = [UIColor redColor];
    }
    return _notConsumptionVC;
}
-(FriendListController *)ConsumptionVC{
    
    if (!_ConsumptionVC) {
        
        _ConsumptionVC = [[FriendListController alloc] initWithStyle:UITableViewStyleGrouped withCellIdentifier:@"ConsumptionCellID" withState:@"1"];
//        _ConsumptionVC.view.backgroundColor = [UIColor greenColor];
    }
    return _ConsumptionVC;
}
-(UIView *)lineView{
    
    if (!_lineView) {
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = LOGINBACKCOLOR;
    }
    return _lineView;
}
@end

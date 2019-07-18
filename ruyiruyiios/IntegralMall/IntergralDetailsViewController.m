//
//  IntergralDetailsViewController.m
//  Menu
//
//  Created by 姚永敏 on 2018/12/26.
//  Copyright © 2018 YYM. All rights reserved.
//

#import "IntergralDetailsViewController.h"
#import "IntergralTypeViewController.h"
#import <Masonry.h>
#import "UIView+BorderLine.h"
@interface IntergralDetailsViewController () <UIScrollViewDelegate>

@property(nonatomic,strong)UIView *topView;//顶部item

@property(nonatomic,strong)UIButton *expendBtn;//收入
@property(nonatomic,strong)UIButton *incomeBtn;//支出

@property(nonatomic,strong)UIView *lineView;//滚动线

@property(nonatomic,strong)IntergralTypeViewController *expendVC;//支出
@property(nonatomic,strong)IntergralTypeViewController *incomeVC;//收入

@property (nonatomic, strong)UIScrollView *mainView;//滚动的主页面

@end

@implementation IntergralDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addChildViewController:self.expendVC];
    [self addChildViewController:self.incomeVC];
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.mainView];
    [self.topView addSubview:self.expendBtn];
    [self.topView addSubview:self.incomeBtn];
    [self.topView addSubview:self.lineView];
    [self.mainView addSubview:self.expendVC.view];
    [self.mainView addSubview:self.incomeVC.view];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.view.mas_top);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(35);
    }];
    
    [self.expendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.topView.mas_left);
        make.width.mas_equalTo(MAINSCREEN.width/2);
        make.height.mas_equalTo(self.topView.mas_height).inset(2);
        make.top.mas_equalTo(self.topView.mas_top);
    }];
    
    [self.incomeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.topView.mas_right);
        make.top.mas_equalTo(self.topView.mas_top);
        make.height.mas_equalTo(self.topView.mas_height).inset(2);
        make.width.mas_equalTo(MAINSCREEN.width/2);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAINSCREEN.width/2);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(2);
        make.bottom.mas_equalTo(self.topView);
    }];
    
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.topView.mas_bottom);
        if (@available(iOS 11.0, *)) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.view.mas_bottom);
        }
        make.left.right.mas_equalTo(self.view);
    }];
    
    [self.expendVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.mainView.mas_top);
        make.left.mas_equalTo(self.mainView.mas_left);
        make.width.mas_equalTo(MAINSCREEN.width);
        make.height.mas_equalTo(self.mainView.mas_height);
    }];
    
    [self.incomeVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.mainView.mas_top);
        make.left.mas_equalTo(self.expendVC.view.mas_right);
        make.width.mas_equalTo(MAINSCREEN.width);
        make.height.mas_equalTo(self.mainView.mas_height);
    }];
    
    [self.view layoutIfNeeded];
    
    [self.topView borderForColor:[UIColor colorWithRed:220.f/255.f green:220.f/255.f blue:220.f/255.f alpha:1.f] borderWidth:1.f borderType:UIBorderSideTypeBottom];
    
}

#pragma mark button click event
- (void)topBtnPressed:(UIButton *)btn{
    
    [self.mainView setContentOffset:CGPointMake(btn.frame.origin.x*2, 0) animated:YES];
}
#pragma mark scrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(scrollView.contentOffset.x/2);
    }];
}

- (UIScrollView *)mainView{
    
    if (_mainView == nil) {
        
        _mainView = [[UIScrollView alloc] init];
        _mainView.contentSize = CGSizeMake(MAINSCREEN.width*2, 0);
        _mainView.backgroundColor = [UIColor lightGrayColor];
        _mainView.showsHorizontalScrollIndicator = NO;
        _mainView.showsVerticalScrollIndicator = NO;
        _mainView.delegate = self;
        _mainView.pagingEnabled=YES;
    }
    return _mainView;
}

- (UIView *)topView{
    
    if (!_topView) {
        
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}
- (UIButton *)expendBtn{
    
    if (!_expendBtn) {
        
        _expendBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_expendBtn setTitle:@"积分支出" forState:UIControlStateNormal];
        [_expendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_expendBtn addTarget:self action:@selector(topBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _expendBtn;
}

- (UIButton *)incomeBtn{
    
    if (!_incomeBtn) {
        
        _incomeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_incomeBtn setTitle:@"积分收入" forState:UIControlStateNormal];
        [_incomeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_incomeBtn addTarget:self action:@selector(topBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _incomeBtn;
}

-(UIView *)lineView{
    
    if (!_lineView) {
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor redColor];
    }
    return _lineView;
}

-(IntergralTypeViewController *)expendVC{
    
    if (!_expendVC) {
        
        _expendVC = [[IntergralTypeViewController alloc] initWithType:@"1"];
    }
    return _expendVC;
}

-(IntergralTypeViewController *)incomeVC{
    
    if (!_incomeVC) {
        
        _incomeVC = [[IntergralTypeViewController alloc] initWithType:@"0"];
    }
    return _incomeVC;
}
@end

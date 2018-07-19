//
//  WelcomeViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/14.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "WelcomeViewController.h"
#import "MainTabBarViewController.h"

#define ImageCount 3

@interface WelcomeViewController ()<UIScrollViewDelegate>

@property(nonatomic, strong)UIScrollView *mainScrollV;
//@property(nonatomic, strong)UIPageControl *pageControl;
@property(nonatomic, strong)UIButton *welcomeBtn;

@end

@implementation WelcomeViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (UIScrollView *)mainScrollV{
    
    if (_mainScrollV == nil) {
        
        _mainScrollV = [[UIScrollView alloc] init];
        _mainScrollV.frame = CGRectMake(0, (SafeAreaTopHeight - 64)+20, MAINSCREEN.width, MAINSCREEN.height - 20 - (SafeAreaTopHeight - 64));
        _mainScrollV.showsHorizontalScrollIndicator = NO;
        CGSize size = _mainScrollV.frame.size;
        _mainScrollV.contentSize = CGSizeMake(size.width*ImageCount, 0);
        _mainScrollV.pagingEnabled = YES;
        _mainScrollV.delegate = self;
    }
    return _mainScrollV;
}

//- (UIPageControl *)pageControl{
//
//    if (_pageControl == nil) {
//
//        CGSize size = self.view.frame.size;
//        _pageControl = [[UIPageControl alloc] init];
//        _pageControl.center = CGPointMake(size.width*0.5, size.height*0.97);
//        _pageControl.numberOfPages = ImageCount;
//        _pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
//        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
//        _pageControl.bounds = CGRectMake(0, 0, 25, 25);
//    }
//    return _pageControl;
//}

- (UIButton *)welcomeBtn{
    
    if (_welcomeBtn == nil) {
        
        _welcomeBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, _mainScrollV.frame.size.height*0.97 - 60, MAINSCREEN.width - 80, 40)];
        _welcomeBtn.hidden = YES;
        _welcomeBtn.layer.cornerRadius = (MAINSCREEN.width - 80)*0.06;
        _welcomeBtn.layer.masksToBounds = YES;
        _welcomeBtn.layer.borderColor = [LOGINBACKCOLOR CGColor];
        _welcomeBtn.layer.borderWidth = 1.3;
        _welcomeBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:18.0];
        [_welcomeBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_welcomeBtn setTitleColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [_welcomeBtn setTitle:@"开启如驿如意" forState:UIControlStateNormal];
        [_welcomeBtn addTarget:self action:@selector(chickWelcomeBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _welcomeBtn;
}

- (void)chickWelcomeBtn{
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"insertCompletion"]) {
        
        [PublicClass showHUD:@"正在导入数据...." view:self.view];
    }else{
        
        MainTabBarViewController *mainTabVC = [[MainTabBarViewController alloc] init];
        [self.navigationController pushViewController:mainTabVC animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.mainScrollV];
    [self addScrollImages];
//    [self.view addSubview:self.pageControl];
    [self.view addSubview:self.welcomeBtn];
    // Do any additional setup after loading the view.
}

- (void)addScrollImages{
    
    CGSize size = _mainScrollV.frame.size;
    for (int i = 0; i<ImageCount; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *name = [NSString stringWithFormat:@"ic_yindaoye_%d.png", i+1];
        imageView.frame = CGRectMake(i*size.width, 0, size.width, size.height);
        imageView.image = [UIImage imageNamed:name];
        [_mainScrollV addSubview:imageView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger currentPage = _mainScrollV.contentOffset.x/_mainScrollV.frame.size.width;
    if (currentPage == 2) {
        
        _welcomeBtn.hidden = NO;
    }else{
        
        _welcomeBtn.hidden = YES;
    }
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

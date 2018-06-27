//
//  ReplacementProcessViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/11.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "ReplacementProcessViewController.h"

@interface ReplacementProcessViewController ()

@property(nonatomic, strong)UIImageView *mainImageV;

@end

@implementation ReplacementProcessViewController

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
}

- (UIImageView *)mainImageV{
    
    if (_mainImageV == nil) {
        
        _mainImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height - SafeDistance)];
        _mainImageV.image = [UIImage imageNamed:@"ic_five_change"];
    }
    return _mainImageV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"更换流程";
    [self addViews];
    // Do any additional setup after loading the view.
}

- (void)addViews{
    
    [self.view addSubview:self.mainImageV];
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

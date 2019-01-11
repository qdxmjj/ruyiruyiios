//
//  GoodsDetailsViewController.m
//  Menu
//
//  Created by 姚永敏 on 2018/12/25.
//  Copyright © 2018 YYM. All rights reserved.
//

#import "GoodsDetailsViewController.h"
#import "OrderConfirmViewController.h"
@interface GoodsDetailsViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation GoodsDetailsViewController
- (void)viewWillAppear:(BOOL)animated{
    
    UIView * barBackground = self.navigationController.navigationBar.subviews.firstObject;
    if (@available(iOS 11.0, *))
    {
        barBackground.alpha = 1;
        [barBackground.subviews setValue:@(1) forKeyPath:@"alpha"];
    } else {
        barBackground.alpha = 1;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];

    self.title = @"商品详情";
    
    self.textView.text = @"2346572547587635475\nfdggfghxgfhx\nafdghdjjdsfgjjnxdfgufhgsfddgf";

}
- (IBAction)redeemNowEvent:(UIButton *)sender {
    
    OrderConfirmViewController *orderConfirmVC = [[OrderConfirmViewController alloc] init];
    
    [self.navigationController pushViewController:orderConfirmVC animated:YES];
}


@end

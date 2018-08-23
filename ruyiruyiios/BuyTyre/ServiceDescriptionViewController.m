//
//  ServiceDescriptionViewController.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/8/14.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "ServiceDescriptionViewController.h"

@interface ServiceDescriptionViewController ()

@end

@implementation ServiceDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
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

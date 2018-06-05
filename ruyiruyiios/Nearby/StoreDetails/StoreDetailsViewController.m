//
//  StoreDetailsViewController.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/4.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "StoreDetailsViewController.h"
#import "StoreDetailsRequest.h"
@interface StoreDetailsViewController ()

@property(nonatomic,strong)NSDictionary *dataDic;

@end

@implementation StoreDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"门店首页";
    
}


-(void)setStoreID:(NSString *)storeID{
    
    if (storeID == nil ||storeID.length<=0) {
        return;
    }
    
    [StoreDetailsRequest getStoreInfoByStoreIdWithInfo:@{@"storeId":storeID} succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if ([data isKindOfClass:[NSDictionary class]]) {
            
            self.dataDic = data;
        }
        
        NSLog(@"%@",data);
        
    } failure:^(NSError * _Nullable error) {
                                                                                                                                                  
    }];
}

-(NSDictionary *)dataDic{
    
    if (!_dataDic) {
        
        _dataDic = [NSDictionary dictionary];
    }
    
    return _dataDic;
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

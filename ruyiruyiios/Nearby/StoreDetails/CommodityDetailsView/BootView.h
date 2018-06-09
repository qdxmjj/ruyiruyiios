//
//  BootView.h
//  TestCommodityInfo
//
//  Created by 小马驾驾 on 2018/5/30.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^showShopCartViewBlock)(BOOL isShow);

@interface BootView : UIView

@property(nonatomic,copy)showShopCartViewBlock showBlcok;//显示购物车页面

@property(nonatomic,copy)NSString *totalPrice;//总价

@property(nonatomic,strong)UILabel *numberLab;//显示总价

@property(nonatomic,assign)BOOL isDisplay;//是否可以显示。默认YES

@property(nonatomic,strong)UIButton *submitBtn;

@end

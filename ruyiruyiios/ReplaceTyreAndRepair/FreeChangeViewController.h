//
//  FreeChangeViewController.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/7/4.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "RootViewController.h"
@interface FreeChangeViewController : RootViewController

//不传返回上一页，随便传入任何内容返回MyOrderViewController
@property(nonatomic,copy)NSString *popStatus;

@end

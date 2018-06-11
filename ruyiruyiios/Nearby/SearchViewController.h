//
//  SearchViewController.h
//  TestOrdersType
//
//  Created by 小马驾驾 on 2018/5/29.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "RootViewController.h"

typedef void (^clickSearchBlock)(NSArray *searchContent);

@interface SearchViewController : RootViewController

@property(copy,nonatomic)clickSearchBlock searchBlock;

@end

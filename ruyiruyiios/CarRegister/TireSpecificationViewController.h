//
//  TireSpecificationViewController.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/24.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "RootViewController.h"

@interface TireSpecificationViewController : RootViewController

@property(nonatomic, copy)void(^specificationBlock)(NSString *text,NSInteger item1Row, NSInteger item2Row, NSInteger item3Row);

@property (nonatomic, assign) NSInteger dItem1Row;
@property (nonatomic, assign) NSInteger dItem2Row;
@property (nonatomic, assign) NSInteger dItem3Row;

@end

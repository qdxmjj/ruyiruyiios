//
//  FMDBCarTireType.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/16.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMDBCarTireType : NSObject

@property(nonatomic, strong)NSString *time;                 //时间
@property(nonatomic, strong)NSString *tireDiameter;         //直径
@property(nonatomic, strong)NSString *tireFlatWidth;        //胎面宽
@property(nonatomic, strong)NSString *tireFlatnessRatio;    //偏平比
@property(nonatomic, strong)NSNumber *tireState;            //状态
@property(nonatomic, strong)NSNumber *tireTypeId;           //类型ID

@end

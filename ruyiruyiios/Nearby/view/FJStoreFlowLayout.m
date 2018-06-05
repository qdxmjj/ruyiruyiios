//
//  FJStoreFlowLayout.m
//  TestOrdersType
//
//  Created by 小马驾驾 on 2018/5/29.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "FJStoreFlowLayout.h"

@implementation FJStoreFlowLayout


-(void)prepareLayout{
    [super prepareLayout];
    // 1.设置列间距
    self.minimumInteritemSpacing = 1;
    // 2.设置行间距
    self.minimumLineSpacing = 5;
    // 3.设置每个item的大小
    // 4.设置Item的估计大小,用于动态设置item的大小，结合自动布局（self-sizing-cell）
    //    self.estimatedItemSize = CGSizeMake(320, 60);
    // 5.设置布局方向
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
//    self.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
}
@end

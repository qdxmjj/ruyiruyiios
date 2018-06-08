//
//  storeDetailsOneFlowLayout.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/6.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "storeDetailsOneFlowLayout.h"

@implementation storeDetailsOneFlowLayout


-(void)prepareLayout{
    [super prepareLayout];
    
    // 1.设置列间距
    self.minimumInteritemSpacing = 10;
    // 2.设置行间距
    self.minimumLineSpacing = 10;
    // 3.设置每个item的大小
    
    self.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    // 5.设置布局方向
    //    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //    self.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
}


@end

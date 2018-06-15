//
//  WinterTyreFlowLayout.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/13.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "WinterTyreFlowLayout.h"

@implementation WinterTyreFlowLayout


-(void)prepareLayout{
    [super prepareLayout];
    
    // 1.设置列间距
    self.minimumInteritemSpacing = 1.5;
    // 2.设置行间距
    self.minimumLineSpacing = 3;
    // 3.设置每个item的大小
    
    self.sectionInset = UIEdgeInsetsMake(3, 3, 3, 3);
    // 5.设置布局方向
    //    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    
}


@end

//
//  CxwyFreeReplaceFlowLayout.m
//  ruyiruyiios
//
//  Created by 姚永敏 on 2018/9/20.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "CxwyFreeReplaceFlowLayout.h"

@implementation CxwyFreeReplaceFlowLayout

-(void)prepareLayout{
    [super prepareLayout];
    // 1.设置列间距
    self.minimumInteritemSpacing = 10;
    // 2.设置行间距
    self.minimumLineSpacing = 10;
    // 5.设置布局方向
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    
//    self.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
}
@end

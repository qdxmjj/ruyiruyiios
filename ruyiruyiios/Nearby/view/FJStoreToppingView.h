//
//  FJStoreToppingView.h
//  ruyiruyiios
//
//  Created by 姚永敏 on 2018/10/22.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ToppingDidSelectDelegate <NSObject>

-(void)toppingDidSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end
@interface FJStoreToppingView : UIView

@property(nonatomic,strong)NSArray *toppingStoreArr;

@property(nonatomic,weak)id <ToppingDidSelectDelegate> delegate;
@end

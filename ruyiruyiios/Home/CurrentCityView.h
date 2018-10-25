//
//  CurrentCityView.h
//  ruyiruyiios
//
//  Created by 姚永敏 on 2018/10/24.
//  Copyright © 2018 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FoldCountyListDelegate <NSObject>

-(void)refreshSuperViewFrameWithStatus:(BOOL )status;

-(void)selectCurrentWithName:(NSString *)currentName;

@end
@interface CurrentCityView : UIView

@property(nonatomic,strong)NSArray *dataList;

@property(nonatomic,weak)id <FoldCountyListDelegate> delegate;

@property(nonatomic,copy)NSString *selectCityStr;

@property(nonatomic,assign)BOOL viewStatus;

@end

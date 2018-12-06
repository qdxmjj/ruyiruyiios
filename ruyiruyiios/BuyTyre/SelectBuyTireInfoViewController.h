//
//  SelectBuyTireInfoViewController.h
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/8/13.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuyTireData.h"

@protocol selectTireInfoDelegate <NSObject>

-(void)selectTireInfoWithPrice:(NSString *)price tireInfo:(NSString *)tireInfo tireNumber:(NSString *)tireNumber cxwyNumber:(NSString *)cxwyNumber cxwyPrice:(NSString *)cxwyPrice buyTireData:(BuyTireData *)buyTireData shoeID:(NSString *)shoeID remainYear:(NSString *)remainYear imgURL:(NSString *)imgURL;
@end

typedef void (^selectBuyTireInfoBlock)(NSString *tirePrice,NSString *tireInfo,NSString *tireNumber,NSString *cxwyNumber,NSString *cxwyPrice,BuyTireData *buyTireData,NSString *shoeID,NSString *remainYear,NSString *imgURL);

@interface SelectBuyTireInfoViewController : UIViewController

// 根据花纹 数组 查询 速度级别
@property(nonatomic,strong)NSArray *patternArr;

@property(nonatomic, copy)NSString  *service_end_date;

@property(nonatomic, strong)NSNumber  *service_year;//最大服务年限

@property(nonatomic, strong)NSNumber  *service_year_length;//当前服务年限

@property(nonatomic,copy)selectBuyTireInfoBlock selectTireInfoBlock;

@property(nonatomic,assign)id<selectTireInfoDelegate> delegate;

@property(nonatomic,strong)NSNumber      *tireNumber;
@property(nonatomic,strong)NSNumber      *cxwuNumber;

@end

//
//  ChoicePatternTableViewCell.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/31.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TirePattern.h"

@interface UIButton(FillColor)

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
+ (UIImage *)imageWithColor:(UIColor *)color;
@end

@interface ChoicePatternTableViewCell : UITableViewCell

@property(nonatomic, strong)UIImageView *tireImageV;
@property(nonatomic, strong)UIButton *leftBtn;
@property(nonatomic, strong)UIButton *midBtn;
@property(nonatomic, strong)UIButton *rightBtn;
@property(nonatomic, strong)UILabel *t_descriptionLabel;
@property(nonatomic, strong)TirePattern *c_tirePattern;
@property(nonatomic, strong)NSArray *resultArray;
@property(nonatomic, strong)NSMutableArray *selectTireMutableA;
@property(copy, nonatomic)void(^block)(NSInteger);
@property(nonatomic, strong)UIButton *tmpBtn;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier shoeSpeedList:(NSArray *)array;

@property(nonatomic,strong)TirePattern *tirePattern;

//- (void)setTirePattern:(TirePattern *)tirePattern;

@end

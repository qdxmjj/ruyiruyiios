//
//  ActivityCell.h
//  ruyiruyiios
//
//  Created by 姚永敏 on 2018/12/8.
//  Copyright © 2018 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ActivityCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *OneBtn1;

@property (weak, nonatomic) IBOutlet UIButton *TwoBtn1;
@property (weak, nonatomic) IBOutlet UIButton *TwoBtn2;

@property (weak, nonatomic) IBOutlet UIButton *ThreeBtn1;
@property (weak, nonatomic) IBOutlet UIButton *ThreeBtn2;
@property (weak, nonatomic) IBOutlet UIButton *ThreeBtn3;
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;

@end

NS_ASSUME_NONNULL_END

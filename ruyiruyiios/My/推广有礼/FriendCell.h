//
//  FriendCell.h
//  ruyiruyiios
//
//  Created by 姚永敏 on 2018/12/4.
//  Copyright © 2018 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FriendCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;

@end

NS_ASSUME_NONNULL_END

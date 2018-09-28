//
//  JJUILabel.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/14.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;
@interface JJUILabel : UILabel
{
//@private
//    VerticalAlignment _verticalAlignment;
}

@property (nonatomic) VerticalAlignment verticalAlignment;

- (void)setVerticalAlignment:(VerticalAlignment)verticalAlignment;

@end

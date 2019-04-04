//
//  SpacingLineScrollView.m
//  ruyiruyiios
//
//  Created by 姚永敏 on 2019/3/15.
//  Copyright © 2019 ruyiruyi. All rights reserved.
//

#import "SpacingLineScrollView.h"

@implementation SpacingLineScrollView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    for (int i = 2; i < 11; i++) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(16, 44*i, MAINSCREEN.width-16, 1)];
        
        view.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:view];
    }
}

@end

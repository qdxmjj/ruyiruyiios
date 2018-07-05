//
//  FreeChangeFooterView.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/7/5.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "FreeChangeFooterView.h"

@implementation FreeChangeFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.submitBtn];
    }
    return self;
}

-(UIButton *)submitBtn{
    
    if (!_submitBtn) {
        
        _submitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_submitBtn setFrame:CGRectMake(10, 0, self.frame.size.width-20, CGRectGetHeight(self.frame))];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_submitBtn setBackgroundColor:LOGINBACKCOLOR];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
        _submitBtn.layer.cornerRadius = 5.f;
        _submitBtn.layer.masksToBounds = YES;
    }
    return _submitBtn;
}
@end

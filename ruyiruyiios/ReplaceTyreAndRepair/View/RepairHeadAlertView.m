//
//  RepairHeadAlertView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/26.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "RepairHeadAlertView.h"

@implementation RepairHeadAlertView

- (UILabel *)alertLabel{
    
    if (_alertLabel == nil) {
        
        _alertLabel = [[UILabel alloc] init];
        _alertLabel.numberOfLines = 0;
        _alertLabel.text = @"温馨提示:以下修补轮胎的规则请您认真阅读，可以帮助您更好的使用我们的产品与服务";
        _alertLabel.font = [UIFont fontWithName:TEXTFONT size:12.0];
        _alertLabel.textColor = TEXTCOLOR64;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:_alertLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        CGSize labelSize = [_alertLabel.text boundingRectWithSize:CGSizeMake(MAINSCREEN.width - 8, MAINSCREEN.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        [_alertLabel setFrame:CGRectMake(8, 6, labelSize.width, labelSize.height)];
    }
    return _alertLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.alertLabel];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

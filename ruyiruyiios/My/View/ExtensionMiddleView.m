//
//  ExtensionMiddleView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/20.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "ExtensionMiddleView.h"

@implementation ExtensionMiddleView
@synthesize awardStr;
@synthesize modeStr;

- (UILabel *)awardLabel{
    
    if (_awardLabel == nil) {
        
        _awardLabel = [[UILabel alloc] init];
        [_awardLabel setNumberOfLines:0];
        _awardLabel.text = self.awardStr;
        _awardLabel.textColor = TEXTCOLOR64;
        _awardLabel.font = [UIFont fontWithName:TEXTFONT size:10.0];
        NSMutableParagraphStyle *paragrephStyle = [[NSMutableParagraphStyle alloc] init];
        paragrephStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:_awardLabel.font, NSParagraphStyleAttributeName:paragrephStyle.copy};
        CGSize awardSize = [_awardLabel.text boundingRectWithSize:CGSizeMake(MAINSCREEN.width - 90, MAINSCREEN.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        self.awardLabel.frame = CGRectMake(0, 5, awardSize.width, awardSize.height);
    }
    return _awardLabel;
}

- (UILabel *)modeLabel{
    
    if (_modeLabel == nil) {
        
        _modeLabel = [[UILabel alloc] init];
        [_modeLabel setNumberOfLines:0];
        _modeLabel.text = self.modeStr;
        _modeLabel.textColor = TEXTCOLOR64;
        _modeLabel.font = [UIFont fontWithName:TEXTFONT size:10.0];
        NSMutableParagraphStyle *paragrephStyle = [[NSMutableParagraphStyle alloc] init];
        NSDictionary *attributes = @{NSFontAttributeName:_modeLabel.font, NSParagraphStyleAttributeName:paragrephStyle.copy};
        CGSize modeSize = [_modeLabel.text boundingRectWithSize:CGSizeMake(MAINSCREEN.width - 90, MAINSCREEN.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        _modeLabel.frame = CGRectMake(0, self.awardLabel.frame.size.height+self.awardLabel.frame.origin.y+3, modeSize.width, modeSize.height);
    }
    return _modeLabel;
}

- (instancetype)initWithFrame:(CGRect)frame award:(NSString *)awardStr mode:(NSString *)modeStr{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.awardStr = awardStr;
        self.modeStr = modeStr;
        [self addSubview:self.awardLabel];
        [self addSubview:self.modeLabel];
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

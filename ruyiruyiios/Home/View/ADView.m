//
//  ADView.m
//  Menu
//
//  Created by 姚永敏 on 2018/11/30.
//  Copyright © 2018 YYM. All rights reserved.
//

#import "ADView.h"
#import <SDCycleScrollView.h>
#import <Masonry.h>
@interface ADView () <SDCycleScrollViewDelegate>

@property(nonatomic,strong)SDCycleScrollView *dcycleView;
@property(nonatomic,strong)UIButton *deleteBtn;

@property(nonatomic,strong)NSArray *activityArr;
@end
@implementation ADView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5f];

        self.userInteractionEnabled = YES;
        [self addSubview:self.dcycleView];
        [self addSubview:self.deleteBtn];
    }
    return self;
}

-(void)layoutSubviews{
    
    [self.dcycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.frame.size.height/2+((self.frame.size.width-32)*1.1)/2);
        make.left.and.right.mas_equalTo(self).inset(25);
        make.height.mas_equalTo((self.frame.size.width-50)*1.1);
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.dcycleView.mas_bottom);
        make.centerX.mas_equalTo(self.dcycleView.mas_centerX);
        make.width.and.height.mas_equalTo(CGSizeMake(50, 50));
    }];
}

-(void)setActivityInfo:(id)info{
    
    self.activityArr = info;
    
    NSArray *imgUrlArr = [self.activityArr valueForKeyPath:@"imageUrl"];
    
    self.dcycleView.imageURLStringsGroup = imgUrlArr;
}

-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    NSString *shareStatus = [NSString stringWithFormat:@"%@",[self.activityArr[index] objectForKey:@"shareable"]];//是否可以分享 0 否 1是
    NSString *clickStatus = [NSString stringWithFormat:@"%@",[self.activityArr[index] objectForKey:@"clickable"]];//是否可以点击 0否 1是
    NSString *text = [NSString stringWithFormat:@"%@",[self.activityArr[index] objectForKey:@"text"]];
    NSString *webUrl = [NSString stringWithFormat:@"%@?userId=%@",[self.activityArr[index] objectForKey:@"webUrl"],[UserConfig user_id]];
    
    NSString *shareURL = [NSString stringWithFormat:@"%@?userId=%@",[self.activityArr[index] objectForKey:@"shareUrl"],[UserConfig user_id]];
    
    if ([clickStatus isEqualToString:@"1"]) {
        NSLog(@"可以点击！");
        
        if ([shareStatus isEqualToString:@"1"]) {
            
            if ([self.delegate respondsToSelector:@selector(adview:didSelectItemAtShareType:webUrl:shareText:shareURL:)]) {
                
                [self.delegate adview:self didSelectItemAtShareType:shareStatusAble webUrl:webUrl shareText:text shareURL:shareURL];
            }
        }else{
            
            if ([self.delegate respondsToSelector:@selector(adview:didSelectItemAtShareType:webUrl:shareText:shareURL:)]) {
                
                [self.delegate adview:self didSelectItemAtShareType:shareStatusAble webUrl:webUrl shareText:text shareURL:shareURL];
            }
        }
    }else{
        NSLog(@"不可以点击！");
    }
}
-(SDCycleScrollView *)dcycleView{
    
    if (!_dcycleView) {
        
        _dcycleView = [[SDCycleScrollView alloc] init];
        _dcycleView.delegate = self;
        _dcycleView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        _dcycleView.contentMode = UIViewContentModeCenter;
        _dcycleView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _dcycleView.autoScrollTimeInterval = 3.0;//轮播时间间隔，默认1.0秒，可自定义
    }
    return _dcycleView;
}

-(UIButton *)deleteBtn{
    
    if (!_deleteBtn) {
        
        _deleteBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setImage:[UIImage imageNamed:@"ic_closeWhite"] forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

-(NSArray *)activityArr{
    
    if (!_activityArr) {
        
        _activityArr = [NSArray array];
    }
    return _activityArr;
}

-(void)show:(UIView *)view{
    
    if (view) {
        [view addSubview:self];
    }else{
        
        [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    }
    
//    __weak __typeof(self)weakSelf  = self;
    
    [self layoutIfNeeded];//绘制dcycleView的原始约束

    [self.dcycleView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    [UIView animateWithDuration:.5f animations:^{
    
        [self layoutIfNeeded];//绘制更新后的 约束
    }];
}
-(void)dismiss{
    
    [UIView animateWithDuration:1.f animations:^{
        
        
    } completion:^(BOOL finished) {
       
        [self removeFromSuperview];
    }];
    
}

@end

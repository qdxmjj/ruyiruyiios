//
//  JJCouponView.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/9/12.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "JJCouponView.h"
#import <Masonry.h>
@interface JJCouponView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIImageView *imgView;

@property(nonatomic,strong)UIButton *determineBtn;

@property(nonatomic,strong)UITableView *tableView;
@end
@implementation JJCouponView

#pragma mark - Action
-(void)show {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.imgView.transform = CGAffineTransformMakeScale(0.7, 0.7);
    // 弹簧动画，参数分别为：时长，延时，弹性（越小弹性越大），初始速度
    [UIView animateWithDuration: 0.7 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.3 options:0 animations:^{
        // 放大
        self.imgView.transform = CGAffineTransformMakeScale(1, 1);
    } completion:nil];
}
-(void)dismiss {
    
    [UIView animateWithDuration:.3 animations:^{
        
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self removeFromSuperview];
    }];
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];

        [self addSubview:self.imgView];
        [self.imgView addSubview:self.tableView];
        [self.imgView addSubview:self.determineBtn];
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.and.height.mas_equalTo(CGSizeMake(232, 349));
        }];
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.width.and.height.mas_equalTo(CGSizeMake(200, 175));
            make.centerX.mas_equalTo(self.imgView.mas_centerX);
            make.top.mas_equalTo(self.imgView.mas_top).inset(120);
        }];
        
        [self.determineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.bottom.mas_equalTo(self.imgView.mas_bottom).inset(3);
            make.width.and.height.mas_equalTo(CGSizeMake(240, 40));
            make.centerX.mas_equalTo(self.imgView.mas_centerX);
        }];
        
    }
    return self;
}

-(void)jj_popViewController{
    
    [self dismiss];
    self.popBlock();
}

-(void)setCounponListArr:(NSArray *)counponListArr{
    _counponListArr = counponListArr;
    if (counponListArr) {
        
        [self.tableView reloadData];
    }
}


//
-(UIImageView *)imgView{
    
    if (!_imgView) {
        
        _imgView = [[UIImageView alloc] init];
        _imgView.contentMode = UIViewContentModeCenter;
        _imgView.userInteractionEnabled = YES;
        _imgView.image = [UIImage imageNamed:@"ic_songquanbj"];
    }
    return _imgView;
}

-(UIButton *)determineBtn{
    
    if (!_determineBtn) {
        
        _determineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_determineBtn setImage:[UIImage imageNamed:@"ic_tcbutton"] forState:UIControlStateNormal];
        [_determineBtn addTarget:self action:@selector(jj_popViewController) forControlEvents:UIControlEventTouchUpInside];
    }
    return _determineBtn;
}

-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"couponCellID"];
    }
    return _tableView;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"couponCellID" forIndexPath:indexPath];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    cell.imageView.image = [UIImage imageNamed:@"ic_xiaoquan"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ X%@",[self.counponListArr[indexPath.row] objectForKey:@"saleName"],[self.counponListArr[indexPath.row] objectForKey:@"saleNumber"]];
    cell.textLabel.font = [UIFont systemFontOfSize:14.f];
    cell.textLabel.numberOfLines = 0;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.counponListArr.count>0) {
        
        return self.counponListArr.count;
    }
    return 0;
}


@end

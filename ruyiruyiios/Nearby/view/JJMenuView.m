//
//  JJMenuView.m
//  TestOrdersType
//
//  Created by 小马驾驾 on 2018/5/29.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "JJMenuView.h"
#import <MJRefresh.h>

#define kCellHeight 44

@interface JJMenuView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,assign)BOOL show;
@property(nonatomic,strong)NSArray *titleArr;

@end
@implementation JJMenuView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
        
        
        [self addSubview:self.tableview];
        
    }
    return self;
}


-(void)showViewWithSuperView:(UIView *)view titleArr:(NSArray *)titleArr{
    
    self.titleArr = titleArr;
    
    [view addSubview:self];
    
    if (self.show==NO) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.tableview.mj_h =kCellHeight*self.titleArr.count;
            
            [self.tableview reloadData];
            
            [self layoutIfNeeded];
        }];
        self.show=YES;
        
        if ([self.delegate respondsToSelector:@selector(dropdownViewDidShow:)]) {
            
            [self.delegate dropdownViewDidShow:self];
        }
    }else{
        
    }
}

-(BOOL)status{
    
    
    return self.show;
}

-(void)disView{
    
    [UIView animateWithDuration:.3 animations:^{
        
        self.tableview.mj_h = 0;
        [self layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
    
    self.show = NO;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}


-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.titleArr.count>0) {
        
        return self.titleArr.count;
    }
    
    return 0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JJMenuCellID" forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (self.titleArr.count>0) {
        cell.textLabel.text = self.titleArr[indexPath.row];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([self.delegate respondsToSelector:@selector(dropdownView:didSelectTitle:didSelectIndex:whereGroup:)]) {
        
        [self.delegate dropdownView:self didSelectTitle:self.titleArr[indexPath.row] didSelectIndex:indexPath.row whereGroup:self.whereGroup];
    }
    
    [self disView];
}





-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kCellHeight;
}

-(UITableView*)tableview{
    
    if (!_tableview) {
        
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0) style:(UITableViewStylePlain)];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        _tableview.bounces=NO;
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"JJMenuCellID"];
    }
    return _tableview;
}
@end

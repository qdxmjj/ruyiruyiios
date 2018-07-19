//
//  ExtensionBottomView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/20.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "ExtensionBottomView.h"
#import "ExtensionBottomTableViewCell.h"
#import "SharePersonInfo.h"

@implementation ExtensionBottomView

- (UIView *)leftView{
    
    if (_leftView == nil) {
        
        _leftView = [[UIView alloc] init];
    }
    return _leftView;
}

- (UILabel *)getAwardLabel{
    
    if (_getAwardLabel == nil) {
        
        _getAwardLabel = [[UILabel alloc] init];
        _getAwardLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _getAwardLabel.textColor = [UIColor blackColor];
        _getAwardLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _getAwardLabel;
}

- (UIView *)rightView{
    
    if (_rightView == nil) {
        
        _rightView = [[UIView alloc] init];
    }
    return _rightView;
}

- (UILabel *)alertLabel{
    
    if (_alertLabel == nil) {
        
        _alertLabel = [[UILabel alloc] init];
        _alertLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _alertLabel.textAlignment = NSTextAlignmentCenter;
        _alertLabel.textColor = TEXTCOLOR64;
        _alertLabel.numberOfLines = 0;
        _alertLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _alertLabel;
}

- (NSMutableArray *)shareList{
    
    if (_shareList == nil) {
        
        _shareList = [[NSMutableArray alloc] init];
    }
    return _shareList;
}

- (UITableView *)inviterTableV{
    
    if (_inviterTableV == nil) {
        
        _inviterTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, MAINSCREEN.width, (self.shareList.count + 1)*30) style:UITableViewStylePlain];
        _inviterTableV.dataSource = self;
        _inviterTableV.delegate = self;
        _inviterTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _inviterTableV.bounces = NO;
        _inviterTableV.backgroundColor = [UIColor clearColor];
    }
    return _inviterTableV;
}

- (instancetype)initWithFrame:(CGRect)frame sharePersons:(NSMutableArray *)shareMutableA viewFlage:(NSString *)flagStr{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.shareList = shareMutableA;
        [self addSubview:self.leftView];
        [self addSubview:self.getAwardLabel];
        [self addSubview:self.rightView];
        if ([flagStr isEqualToString:@"1"]) {
            
            [self addSubview:self.alertLabel];
        }else{
            
            [self addSubview:self.inviterTableV];
        }
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.getAwardLabel.frame = CGRectMake((MAINSCREEN.width - 110)/2, 10, 110, 20);
    self.leftView.frame = CGRectMake(10, 20, (MAINSCREEN.width - 20 - 110)/2, 1);
    self.rightView.frame = CGRectMake(self.getAwardLabel.frame.size.width+self.getAwardLabel.frame.origin.x, 20, self.leftView.frame.size.width, 1);
    self.alertLabel.frame = CGRectMake(MAINSCREEN.width/2 - 140, 40, 280, 50);
}

- (void)setdatatoViews:(NSMutableArray *)shareRelationList{
    
    self.leftView.backgroundColor = [UIColor blackColor];
    self.rightView.backgroundColor = [UIColor blackColor];
    self.getAwardLabel.text = @"已获得邀请奖励";
    if (shareRelationList.count == 0) {
        
        self.alertLabel.text = @"您还未成功邀请到好友~\n赶快分享给朋友们一起来省钱吧！";
    }else{
        
        [self.inviterTableV reloadData];
    }
}

//UITableViewDelegate and UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.shareList.count + 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 30.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIndentifier = @"cell";
    ExtensionBottomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIndentifier];
    if (cell == nil) {
        
        cell = [[ExtensionBottomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIndentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row == 0) {
        
        cell.userphoneLabel.text = @"用户";
        cell.userphoneLabel.textColor = [UIColor blackColor];
        cell.statusLabel.text = @"状态";
        cell.statusLabel.textColor = [UIColor blackColor];
        cell.joinLabel.text = @"加入时间";
        cell.joinLabel.textColor = [UIColor blackColor];
    }else{
        
        SharePersonInfo *sharePersonInfo = [self.shareList objectAtIndex:(indexPath.row - 1)];
        [cell setdatatoCellSubviews:sharePersonInfo];
    }
    return cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

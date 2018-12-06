//
//  FriendListController.m
//  ruyiruyiios
//
//  Created by 姚永敏 on 2018/12/4.
//  Copyright © 2018 ruyiruyi. All rights reserved.
//

#import "FriendListController.h"
#import "FriendCell.h"
@interface FriendListController ()
{
    NSString *cellID;
}
@end

@implementation FriendListController

-(instancetype)initWithStyle:(UITableViewStyle)style withCellIdentifier:(NSString *)identifier{
    
    if (self = [super initWithStyle:style]) {
        
        cellID = identifier;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FriendCell class]) bundle:nil] forCellReuseIdentifier:cellID];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 60.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 2.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    return cell;
}

@end

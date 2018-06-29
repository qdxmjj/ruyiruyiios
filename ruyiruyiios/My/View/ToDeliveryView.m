//
//  ToDeliveryView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/29.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "ToDeliveryView.h"
#import "ToDeliveryTableViewCell.h"
#import "TireChaneOrderInfo.h"

@implementation ToDeliveryView

- (UILabel *)userNameLabel{
    
    if (_userNameLabel == nil) {
        
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _userNameLabel.textColor = [UIColor lightGrayColor];
        _userNameLabel.textAlignment = NSTextAlignmentRight;
    }
    return _userNameLabel;
}

- (UILabel *)userPhoneLabel{
    
    if (_userPhoneLabel == nil) {
        
        _userPhoneLabel = [[UILabel alloc] init];
        _userPhoneLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _userPhoneLabel.textColor = [UIColor lightGrayColor];
        _userPhoneLabel.textAlignment = NSTextAlignmentRight;
    }
    return _userPhoneLabel;
}

- (UILabel *)userPlatNumberLabel{
    
    if (_userPlatNumberLabel == nil) {
        
        _userPlatNumberLabel = [[UILabel alloc] init];
        _userPlatNumberLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _userPlatNumberLabel.textColor = [UIColor lightGrayColor];
        _userPlatNumberLabel.textAlignment = NSTextAlignmentRight;
    }
    return _userPlatNumberLabel;
}

- (UILabel *)serviceLabel{
    
    if (_serviceLabel == nil) {
        
        _serviceLabel = [[UILabel alloc] init];
        _serviceLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _serviceLabel.textColor = [UIColor lightGrayColor];
        _serviceLabel.textAlignment = NSTextAlignmentRight;
    }
    return _serviceLabel;
}

- (UIButton *)storeNameBtn{
    
    if (_storeNameBtn == nil) {
        
        _storeNameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _storeNameBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _storeNameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_storeNameBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    return _storeNameBtn;
}

- (UIView *)underView{
    
    if (_underView == nil) {
        
        _underView = [[UIView alloc] init];
    }
    return _underView;
}

- (UITableView *)tireChangeTableview{
    
    if (_tireChangeTableview == nil) {
        
        _tireChangeTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 190, MAINSCREEN.width, self.changeShoeMutableA.count*150) style:UITableViewStylePlain];
        _tireChangeTableview.delegate = self;
        _tireChangeTableview.dataSource = self;
        _tireChangeTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tireChangeTableview.bounces = NO;
    }
    return _tireChangeTableview;
}

- (NSMutableArray *)changeShoeMutableA{
    
    if (_changeShoeMutableA == nil) {
        
        _changeShoeMutableA = [[NSMutableArray alloc] init];
    }
    return _changeShoeMutableA;
}

- (instancetype)initWithFrame:(CGRect)frame change:(NSMutableArray *)changeMutableA{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.changeShoeMutableA = changeMutableA;
        NSArray *nameArray = @[@"联系人", @"联系电话", @"车牌号", @"服务项目", @"店铺名称"];
        [self addUnchangeViews:nameArray];
        [self addChangeViews];
    }
    return self;
}

- (void)addUnchangeViews:(NSArray *)array{
    
    for (int i = 0; i<array.count; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 15+35*i, MAINSCREEN.width/2 - 20, 20)];
        label.text = array[i];
        label.textColor = TEXTCOLOR64;
        label.font = [UIFont fontWithName:TEXTFONT size:16.0];
        label.textAlignment = NSTextAlignmentLeft;
        [self addSubview:label];
    }
}

- (void)addChangeViews{
    
    [self addSubview:self.userNameLabel];
    [self addSubview:self.userPhoneLabel];
    [self addSubview:self.userPlatNumberLabel];
    [self addSubview:self.serviceLabel];
    [self addSubview:self.storeNameBtn];
    [self addSubview:self.underView];
    [self addSubview:self.tireChangeTableview];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.userNameLabel.frame = CGRectMake(MAINSCREEN.width/2, 15, MAINSCREEN.width/2 - 20, 20);
    self.userPhoneLabel.frame = CGRectMake(MAINSCREEN.width/2, 50, MAINSCREEN.width/2 - 20, 20);
    self.userPlatNumberLabel.frame = CGRectMake(MAINSCREEN.width/2, 85, MAINSCREEN.width/2 - 20, 20);
    self.serviceLabel.frame = CGRectMake(MAINSCREEN.width/2, 120, MAINSCREEN.width/2 - 20, 20);
    self.storeNameBtn.frame = CGRectMake(MAINSCREEN.width/2, 155, MAINSCREEN.width/2 - 20, 20);
    self.underView.frame = CGRectMake(0, 188, MAINSCREEN.width, 1);
}

- (void)setDatatoDeliveryViews:(FirstUpdateOrFreeChangeInfo *)firstUpdateOrFreeChaneInfo{
    
    self.tireImgUrlStr = firstUpdateOrFreeChaneInfo.orderImg;
    self.userNameLabel.text = firstUpdateOrFreeChaneInfo.userName;
    self.userPhoneLabel.text = firstUpdateOrFreeChaneInfo.userPhone;
    self.userPlatNumberLabel.text = firstUpdateOrFreeChaneInfo.platNumber;
    if (firstUpdateOrFreeChaneInfo.firstChangeOrderVoList != NULL) {
        
        self.serviceLabel.text = @"首次更换";
    }else{
        
        self.serviceLabel.text = @"免费再换";
    }
    
    [self.storeNameBtn setTitle:firstUpdateOrFreeChaneInfo.storeName forState:UIControlStateNormal];
    [self.storeNameBtn setImage:[UIImage imageNamed:@"ic_right"] forState:UIControlStateNormal];
    [self.storeNameBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    [self.storeNameBtn setImageEdgeInsets:UIEdgeInsetsMake(0, MAINSCREEN.width/2-20-10, 0, 0)];
    self.underView.backgroundColor = [PublicClass colorWithHexString:@"#ececec"];
    [self.tireChangeTableview reloadData];
}

//UITableViewDelegate and UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.changeShoeMutableA.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIndentifier = @"cell";
    ToDeliveryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIndentifier];
    if (cell == nil) {
        
        cell = [[ToDeliveryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIndentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    TireChaneOrderInfo *tireInfo = [self.changeShoeMutableA objectAtIndex:indexPath.row];
    [cell setdatatoCellViews:tireInfo img:self.tireImgUrlStr];
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

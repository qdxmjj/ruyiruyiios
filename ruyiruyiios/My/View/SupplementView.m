//
//  SupplementView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/7/9.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "SupplementView.h"
#import "SupplementTableViewCell.h"
#import "UserCarShoeOldBarCodeInfo.h"

@implementation SupplementView

- (UILabel *)needSuppleLabel{
    
    if (_needSuppleLabel == nil) {
        
        _needSuppleLabel = [[UILabel alloc] init];
        _needSuppleLabel.textColor = TEXTCOLOR64;
        _needSuppleLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _needSuppleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _needSuppleLabel;
}

- (UITableView *)suppleTableV{
    
    if (_suppleTableV == nil) {
        
        _suppleTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 35, MAINSCREEN.width, self.suppleNumberMutableA.count*180) style:UITableViewStylePlain];
        _suppleTableV.bounces = NO;
        _suppleTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _suppleTableV.showsVerticalScrollIndicator = NO;
        _suppleTableV.showsHorizontalScrollIndicator = NO;
        _suppleTableV.delegate = self;
        _suppleTableV.dataSource = self;
    }
    return _suppleTableV;
}

- (NumberSelectView *)passnotWorryView{
    
    if (_passnotWorryView == nil) {
        
        _passnotWorryView = [[NumberSelectView alloc] init];
        [_passnotWorryView.leftBtn addTarget:self action:@selector(chickWorryViewLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_passnotWorryView.rightBtn addTarget:self action:@selector(chickWorryViewRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _passnotWorryView;
}

- (UILabel *)needMoneyLabel{
    
    if (_needMoneyLabel == nil) {
        
        _needMoneyLabel = [[UILabel alloc] init];
        _needMoneyLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _needMoneyLabel.textColor = LOGINBACKCOLOR;
        _needMoneyLabel.textAlignment = NSTextAlignmentRight;
    }
    return _needMoneyLabel;
}

- (NSMutableArray *)suppleNumberMutableA{
    
    if (_suppleNumberMutableA == nil) {
        
        _suppleNumberMutableA = [[NSMutableArray alloc] init];
    }
    return _suppleNumberMutableA;
}

- (instancetype)initWithFrame:(CGRect)frame numberOfSupplement:(NSMutableArray *)numberMutableA{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.suppleNumberMutableA = numberMutableA;
        self.tirePriceInteger = 0;
        [self addChangeViews];
        [self addUnchangeViews];
    }
    return self;
}

- (void)addChangeViews{
    
    [self addSubview:self.needSuppleLabel];
    [self addSubview:self.suppleTableV];
    [self addSubview:self.passnotWorryView];
    [self addSubview:self.needMoneyLabel];
}

- (void)addUnchangeViews{
    
    NSArray *nameArray = @[@"使用畅行无忧数量", @"需要补差的金额"];
    for (int i = 0; i<nameArray.count; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(20, self.suppleTableV.frame.size.height + self.suppleTableV.frame.origin.y + 50*i+15, MAINSCREEN.width/2 - 20, 20);
        label.text = nameArray[i];
        label.textColor = TEXTCOLOR64;
        label.font = [UIFont fontWithName:TEXTFONT size:16.0];
        label.textAlignment = NSTextAlignmentLeft;
        [self addSubview:label];
        
        UIView *underLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.suppleTableV.frame.size.height + self.suppleTableV.frame.origin.y + 50*i + 15 + 13 + 20, MAINSCREEN.width, 1)];
        underLineView.backgroundColor = [PublicClass colorWithHexString:@"#ececec"];
        [self addSubview:underLineView];
    }
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.needSuppleLabel.frame = CGRectMake(20, 15, MAINSCREEN.width/2 - 20, 20);
    self.passnotWorryView.frame = CGRectMake(MAINSCREEN.width - 130, self.suppleTableV.frame.size.height + self.suppleTableV.frame.origin.y + 10, 110, 30);
    self.needMoneyLabel.frame = CGRectMake(MAINSCREEN.width/2, self.suppleTableV.frame.size.height + self.suppleTableV.frame.origin.y + 50 + 15, MAINSCREEN.width/2 - 20, 20);
}

- (void)setdatatoSupplementViews:(NSString *)numberStr{
    
    self.needSuppleLabel.text = @"需要补差的轮胎";
    if (self.suppleNumberMutableA.count > [numberStr integerValue]) {
        
        self.passnotWorryView.limitNumberStr = numberStr;
    }else{
        
        self.passnotWorryView.limitNumberStr = [NSString stringWithFormat:@"%ld", self.suppleNumberMutableA.count];
    }
    
    NSInteger price = 0;
    for (int i = 0; i<self.suppleNumberMutableA.count; i++) {
        
        UserCarShoeOldBarCodeInfo *userInfo = [self.suppleNumberMutableA objectAtIndex:i];
        self.tirePriceInteger = [userInfo.price integerValue];
        price = price + [userInfo.price intValue];
    }
    self.needPriceInteger = price;
    self.needMoneyLabel.text = [NSString stringWithFormat:@"¥ %ld", price];
}

//UITableViewDelegate and UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.suppleNumberMutableA.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 180.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIndentifier = @"cell";
    SupplementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIndentifier];
    if (cell == nil) {
        
        cell = [[SupplementTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIndentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    UserCarShoeOldBarCodeInfo *userShoeInfo = [self.suppleNumberMutableA objectAtIndex:indexPath.row];
    [cell setdatatoViews:userShoeInfo];
    return cell;
}

- (void)chickWorryViewLeftBtn:(UIButton *)button{
    
    NSInteger allPriceInteger = self.tirePriceInteger * [self.passnotWorryView.numberLabel.text integerValue];
    NSInteger remainPriceInteger = self.needPriceInteger - allPriceInteger;
    self.needMoneyLabel.text = [NSString stringWithFormat:@"¥ %ld", remainPriceInteger];
}

- (void)chickWorryViewRightBtn:(UIButton *)button{
    
    NSLog(@"右边按钮的数量：%@", self.passnotWorryView.numberLabel.text);
    NSInteger allPriceInteger = self.tirePriceInteger * [self.passnotWorryView.numberLabel.text integerValue];
    NSInteger remainPriceInteger = self.needPriceInteger - allPriceInteger;
    self.needMoneyLabel.text = [NSString stringWithFormat:@"¥ %ld", remainPriceInteger];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

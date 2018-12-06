//
//  SelectTirePositionViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/30.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "SelectTirePositionViewController.h"
#import "SelectTirePositionTableViewCell.h"
//#import "ChoicePatternViewController.h"
#import "NewTirePurchaseViewController.h"
@interface SelectTirePositionViewController ()<UITableViewDelegate, UITableViewDataSource>{
    
    CGFloat y, height;
}

@property(nonatomic, strong)UIView *headView;
@property(nonatomic, strong)UILabel *promptLabel;
@property(nonatomic, strong)UITableView *tirePositionTV;

@end

@implementation SelectTirePositionViewController

@synthesize dataCars;


- (UIView *)headView{
    
    if (_headView == nil) {
        
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, 45)];
        _headView.backgroundColor = [PublicClass colorWithHexString:@"#ececec"];
        [_headView addSubview:self.promptLabel];
    }
    return _headView;
}

- (UILabel *)promptLabel{
    
    if (_promptLabel == nil) {
        
        _promptLabel = [[UILabel alloc] init];
        [_promptLabel setNumberOfLines:0];
        _promptLabel.text = @"温馨提示：由于您的宝车前后轮型号不一致，请分别购买前后轮轮胎";
        _promptLabel.textColor = TEXTCOLOR64;
        _promptLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];;
        NSMutableParagraphStyle *paragraphStyle  = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:_promptLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        CGSize labelSize = [_promptLabel.text boundingRectWithSize:CGSizeMake(MAINSCREEN.width, MAINSCREEN.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        height = labelSize.height;
        [_promptLabel setFrame:CGRectMake(6, y, labelSize.width, labelSize.height)];
    }
    return _promptLabel;
}

- (UITableView *)tirePositionTV{
    
    if (_tirePositionTV == nil) {
        
        _tirePositionTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, MAINSCREEN.width, MAINSCREEN.height - 45 - SafeDistance) style:UITableViewStylePlain];
        _tirePositionTV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tirePositionTV.bounces = NO;
        _tirePositionTV.delegate = self;
        _tirePositionTV.dataSource = self;
    }
    return _tirePositionTV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择轮胎位置";
    y = 6;
    [self addView];
    // Do any additional setup after loading the view.
}

- (void)addView{
    
    [self.view addSubview:self.headView];
    [self.view addSubview:self.tirePositionTV];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIndentifier = @"cell";
    SelectTirePositionTableViewCell *tireCell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (tireCell == nil) {
        
        tireCell = [[SelectTirePositionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        tireCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row == 0) {
        
        tireCell.nameLabel.text = [NSString stringWithFormat:@"前轮：%@", self.dataCars.font];
    }else{
        
        tireCell.nameLabel.text = [NSString stringWithFormat:@"后轮：%@", self.dataCars.rear];
    }
    return tireCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    ChoicePatternViewController *choicPVC = [[ChoicePatternViewController alloc] init];
//    if (indexPath.row == 0) {
//
//        choicPVC.tireSize = dataCars.font;
//        choicPVC.fontRearFlag = @"1";
//    }else{
//
//        choicPVC.tireSize = dataCars.rear;
//        choicPVC.fontRearFlag = @"2";
//    }
    
    NewTirePurchaseViewController *newTireVC = [[NewTirePurchaseViewController alloc] init];
    
    if (indexPath.row == 0) {
        
        newTireVC.tireSize = dataCars.font;
        newTireVC.fontRearFlag = @"1";
    }else{
        
        newTireVC.tireSize = dataCars.rear;
        newTireVC.fontRearFlag = @"2";
    }
    newTireVC.service_end_date = self.dataCars.service_end_date;
    newTireVC.service_year = self.dataCars.service_year;
    newTireVC.service_year_length = self.dataCars.service_year_length;
    [self.navigationController pushViewController:newTireVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

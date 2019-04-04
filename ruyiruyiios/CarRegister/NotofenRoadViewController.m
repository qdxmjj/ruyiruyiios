//
//  NotofenRoadViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/22.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "NotofenRoadViewController.h"
#import "RoadConditionTableViewCell.h"
#import "RoadInfo.h"
#import <UIImageView+WebCache.h>
#import "DelegateConfiguration.h"

#import "MyCarInfoViewController.h"
@interface NotofenRoadViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UILabel *pointLabel;
@property(nonatomic, strong)UITableView *notOfenTableV;
@property(nonatomic, strong)UIButton *saveBtn;
@property(nonatomic, strong)NSMutableArray *notofenSelectMutableA;

@end

@implementation NotofenRoadViewController
@synthesize unselectMutableA;
@synthesize selectMutableA;
@synthesize roadMutableArray;

- (UILabel *)pointLabel{
    
    if (_pointLabel == nil) {
        
        _pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, MAINSCREEN.width - 20, 20)];
        _pointLabel.text = @"您偶尔行驶的路况";
        _pointLabel.textColor = [UIColor blackColor];
        _pointLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
    }
    return _pointLabel;
}

- (UITableView *)notOfenTableV{
    
    if (_notOfenTableV == nil) {
        
        _notOfenTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, MAINSCREEN.width, MAINSCREEN.height - SafeDistance - 85) style:UITableViewStylePlain];
        _notOfenTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _notOfenTableV.bounces = NO;
        _notOfenTableV.delegate = self;
        _notOfenTableV.dataSource = self;
    }
    return _notOfenTableV;
}

- (UIButton *)saveBtn{
    
    if (_saveBtn == nil) {
        
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveBtn.frame = CGRectMake(10, MAINSCREEN.height - 35 - SafeDistance, MAINSCREEN.width - 20, 30);
        _saveBtn.layer.cornerRadius = 6.0;
        _saveBtn.layer.masksToBounds = YES;
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(chickSaveBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}

- (NSMutableArray *)notofenSelectMutableA{
    
    if (_notofenSelectMutableA == nil) {
        
        _notofenSelectMutableA = [[NSMutableArray alloc] init];
    }
    return _notofenSelectMutableA;
}

- (void)chickSaveBtn{
    
    DelegateConfiguration *delegateConfiguration = [DelegateConfiguration sharedConfiguration];
    NSMutableString *roadMStr = [[NSMutableString alloc] init];
    NSMutableString *oftenId_Str = [[NSMutableString alloc] init];
    NSMutableString *onceId_Str = [[NSMutableString alloc] init];
    NSMutableString *notId_Str = [[NSMutableString alloc] init];
    NSLog(@"被选中的数组:%@", self.notofenSelectMutableA);
    for (int i = 0; i<self.selectMutableA.count; i++) {
        
        RoadInfo *roadInfo = [self.selectMutableA objectAtIndex:i];
        [roadMStr appendString:[NSString stringWithFormat:@"%@;", roadInfo.name]];
        if (i == self.selectMutableA.count - 1) {
            
            [oftenId_Str appendString:[NSString stringWithFormat:@"%@", roadInfo.road_id]];
        }else{
            
            [oftenId_Str appendString:[NSString stringWithFormat:@"%@,", roadInfo.road_id]];
        }
    }
    for (int j = 0; j<self.notofenSelectMutableA.count; j++) {
        
        RoadInfo *notRoadInfo = [self.notofenSelectMutableA objectAtIndex:j];
        [roadMStr appendString:[NSString stringWithFormat:@"%@;", notRoadInfo.name]];
        if (j == self.notofenSelectMutableA.count - 1) {
            
            [onceId_Str appendString:[NSString stringWithFormat:@"%@", notRoadInfo.road_id]];
        }else{
            
            [onceId_Str appendString:[NSString stringWithFormat:@"%@,", notRoadInfo.road_id]];
        }
    }
    
    [self.roadMutableArray removeObjectsInArray:(NSArray *)self.selectMutableA];
    [self.roadMutableArray removeObjectsInArray:(NSArray *)self.notofenSelectMutableA];
    NSLog(@"删除后的道路状况:%@", self.roadMutableArray);
    
    for (int k = 0; k<self.roadMutableArray.count; k++) {
        
        RoadInfo *notInfo = [self.roadMutableArray objectAtIndex:k];
        if (k == self.roadMutableArray.count - 1) {
            
            [notId_Str appendString:[NSString stringWithFormat:@"%@", notInfo.road_id]];
        }else{
            
            [notId_Str appendString:[NSString stringWithFormat:@"%@,", notInfo.road_id]];
        }
    }
    
    [delegateConfiguration changeRoadStatusName:roadMStr OftenId:oftenId_Str OnceId:onceId_Str NotId:notId_Str];
    for (int i=0; i<self.navigationController.viewControllers.count; i++) {
        
        ;
        if ([[[self.navigationController.viewControllers objectAtIndex:i] class] isEqual:[MyCarInfoViewController class]]) {
            
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:i] animated:YES];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"路况选择";
    
    [self addView];
    // Do any additional setup after loading the view.
}

- (void)addView{
    
    [self.view addSubview:self.pointLabel];
    [self.view addSubview:self.notOfenTableV];
    [self.view addSubview:self.saveBtn];
}

//tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.unselectMutableA count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIndentifier = @"cell";
    RoadConditionTableViewCell *roadCell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (roadCell == nil) {
        
        roadCell = [[RoadConditionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        roadCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    RoadInfo *roadInfo = [self.unselectMutableA objectAtIndex:indexPath.row];
    [roadCell.pictureImageV sd_setImageWithURL:[NSURL URLWithString:roadInfo.img]];
    roadCell.titleLabel.text = roadInfo.name;
    roadCell.detailLabel.text = roadInfo.road_description;
    return roadCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RoadConditionTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.selectImageV.image isEqual:[UIImage imageNamed:@"未选中"]]) {
        
        cell.selectImageV.image = [UIImage imageNamed:@"对号"];
        [self.notofenSelectMutableA addObject:[self.unselectMutableA objectAtIndex:indexPath.row]];
    }else{

        cell.selectImageV.image = [UIImage imageNamed:@"未选中"];
        [self.notofenSelectMutableA removeObject:[self.unselectMutableA objectAtIndex:indexPath.row]];
    }
        NSLog(@"被选中的数组:%@", self.notofenSelectMutableA);
    //    NSLog(@"未选中的数组:%@", self.unselectMutableArray);
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

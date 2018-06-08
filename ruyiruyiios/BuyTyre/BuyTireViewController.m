//
//  BuyTireViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/30.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "BuyTireViewController.h"
#import "DBRecorder.h"
#import "BuyTireData.h"
#import <SDCycleScrollView.h>
#import "NumberSelectView.h"
#import "QualityServiceViewController.h"

@interface BuyTireViewController ()<UIScrollViewDelegate, SDCycleScrollViewDelegate>

@property(nonatomic, strong)UIScrollView *mainScrollV;
@property(nonatomic, strong)SDCycleScrollView *sdcyleScrollV;
@property(nonatomic, strong)UILabel *detailLabel;
@property(nonatomic, strong)UILabel *pointCXWYLabel;
@property(nonatomic, strong)UILabel *priceLabel;
@property(nonatomic, strong)UIView *topView;
@property(nonatomic, strong)UILabel *tireNumberLabel;
@property(nonatomic, strong)NumberSelectView *tireView;
@property(nonatomic, strong)UIView *bottomView;
@property(nonatomic, strong)UIButton *valueAddServiceBtn;
@property(nonatomic, strong)UILabel *freeWorryLabel;
@property(nonatomic, strong)NumberSelectView *cxwyView;
@property(nonatomic, strong)UILabel *forDecribeCXWYLabel;
@property(nonatomic, strong)BuyTireData *buyTireData;
@property(nonatomic, strong)UIButton *nextBtn;

@end

@implementation BuyTireViewController
@synthesize shoeSpeedLoadResult;
@synthesize fontRearFlag;

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
}

- (UIScrollView *)mainScrollV{
    
    if (_mainScrollV == nil) {
        
        _mainScrollV = [[UIScrollView alloc] init];
        _mainScrollV.frame = CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height - 104);
        _mainScrollV.backgroundColor = [PublicClass colorWithHexString:@"#fafafa"];
        _mainScrollV.showsHorizontalScrollIndicator = NO;
        _mainScrollV.showsVerticalScrollIndicator = NO;
        _mainScrollV.bounces = NO;
        _mainScrollV.scrollsToTop = NO;
        _mainScrollV.tag = 1;
        _mainScrollV.delegate = self;
    }
    return _mainScrollV;
}

- (SDCycleScrollView *)sdcyleScrollV{
    
    if (_sdcyleScrollV == nil) {
        
        _sdcyleScrollV = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, MAINSCREEN.width, 120) delegate:self placeholderImage:nil];
        _sdcyleScrollV.autoScrollTimeInterval = 3.0;
        _sdcyleScrollV.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        [SDCycleScrollView clearImagesCache];
    }
    return _sdcyleScrollV;
}

- (UILabel *)detailLabel{
    
    if (_detailLabel == nil) {
        
        _detailLabel = [[UILabel alloc] init];
        [_detailLabel setNumberOfLines:0];
        _detailLabel.text = self.buyTireData.detailStr;
        _detailLabel.textColor = [UIColor blackColor];
        _detailLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:_detailLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        CGSize detailLabelSize = [_detailLabel.text boundingRectWithSize:CGSizeMake(MAINSCREEN.width - 20, MAINSCREEN.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        [_detailLabel setFrame:CGRectMake(20, 130, detailLabelSize.width, detailLabelSize.height)];
    }
    return _detailLabel;
}

- (UILabel *)pointCXWYLabel{
    
    if (_pointCXWYLabel == nil) {
        
        _pointCXWYLabel = [[UILabel alloc] init];
        [_pointCXWYLabel setNumberOfLines:0];
        _pointCXWYLabel.text = @"官方授权 正品保障 免费安装 一次购买四条轮胎赠送畅行无忧";
        _pointCXWYLabel.textColor = LOGINBACKCOLOR;
        _pointCXWYLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:_pointCXWYLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        CGSize pointSize = [_pointCXWYLabel.text boundingRectWithSize:CGSizeMake(MAINSCREEN.width - 20, MAINSCREEN.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        [_pointCXWYLabel setFrame:CGRectMake(20, self.detailLabel.frame.size.height + self.detailLabel.frame.origin.y + 10, pointSize.width, pointSize.height)];
    }
    return _pointCXWYLabel;
}

- (UILabel *)priceLabel{
    
    if (_priceLabel == nil) {
        
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.pointCXWYLabel.frame.size.height+self.pointCXWYLabel.frame.origin.y + 15, MAINSCREEN.width - 20, 24)];
        _priceLabel.text = shoeSpeedLoadResult.price;
        _priceLabel.textColor = [UIColor redColor];
        _priceLabel.font = [UIFont fontWithName:TEXTFONT size:24.0];
    }
    return _priceLabel;
}

- (UIView *)topView{
    
    if (_topView == nil) {
        
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, self.priceLabel.frame.size.height + self.priceLabel.frame.origin.y + 15, MAINSCREEN.width, 2)];
        _topView.backgroundColor = [UIColor lightGrayColor];
    }
    return _topView;
}

- (UILabel *)tireNumberLabel{
    
    if (_tireNumberLabel == nil) {
        
        _tireNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.topView.frame.size.height + self.topView.frame.origin.y + 15, MAINSCREEN.width/2-20, 20)];
        if ([fontRearFlag isEqualToString:@"0"]) {
            
            _tireNumberLabel.text = @"轮胎数量";
        }else if ([fontRearFlag isEqualToString:@"1"]){
            
            _tireNumberLabel.text = @"前轮数量";
        }else{
            
            _tireNumberLabel.text = @"后轮数量";
        }
        _tireNumberLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _tireNumberLabel.textColor = TEXTCOLOR64;
    }
    return _tireNumberLabel;
}

- (NumberSelectView *)tireView{
    
    if (_tireView == nil) {
        
        _tireView = [[NumberSelectView alloc] initWithFrame:CGRectMake(MAINSCREEN.width/2, self.topView.frame.size.height + self.topView.frame.origin.y + 10, MAINSCREEN.width/2, 30)];
    }
    return _tireView;
}

- (UIView *)bottomView{
    
    if (_bottomView == nil) {
        
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.tireView.frame.size.height+self.tireView.frame.origin.y + 10, MAINSCREEN.width, 2)];
        _bottomView.backgroundColor = [UIColor lightGrayColor];
    }
    return _bottomView;
}

- (UIButton *)valueAddServiceBtn{
    
    if (_valueAddServiceBtn == nil) {
        
        _valueAddServiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _valueAddServiceBtn.enabled = YES;
        _valueAddServiceBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _valueAddServiceBtn.frame = CGRectMake(20, self.bottomView.frame.size.height + self.bottomView.frame.origin.y + 15, MAINSCREEN.width/2, 20);
        [_valueAddServiceBtn setTitle:@"增值服务" forState:UIControlStateNormal];
        [_valueAddServiceBtn setTitleColor:TEXTCOLOR64 forState:UIControlStateNormal];
        [_valueAddServiceBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 12, 0, 0)];
        [_valueAddServiceBtn setImage:[UIImage imageNamed:@"ic_plus"] forState:UIControlStateNormal];
        [_valueAddServiceBtn setImage:[UIImage imageNamed:@"ic_plus"] forState:UIControlStateHighlighted];
    }
    return _valueAddServiceBtn;
}

- (UILabel *)freeWorryLabel{
    
    if (_freeWorryLabel == nil) {
        
        _freeWorryLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.valueAddServiceBtn.frame.size.height+self.valueAddServiceBtn.frame.origin.y+20, MAINSCREEN.width/2 - 20, 20)];
        _freeWorryLabel.textColor = TEXTCOLOR64;
        _freeWorryLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _freeWorryLabel.text = [NSString stringWithFormat:@"畅行无忧 | %@", self.buyTireData.cxwyMaxPrice];
    }
    return _freeWorryLabel;
}

- (NumberSelectView *)cxwyView{
    
    if (_cxwyView == nil) {
        
        _cxwyView = [[NumberSelectView alloc] initWithFrame:CGRectMake(MAINSCREEN.width/2, self.valueAddServiceBtn.frame.size.height+self.valueAddServiceBtn.frame.origin.y+15, MAINSCREEN.width/2, 30)];
    }
    return _cxwyView;
}

- (UILabel *)forDecribeCXWYLabel{
    
    if (_forDecribeCXWYLabel == nil) {
        
        _forDecribeCXWYLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.cxwyView.frame.size.height + self.cxwyView.frame.origin.y + 10, MAINSCREEN.width - 20, 20)];
        _forDecribeCXWYLabel.textColor = TEXTCOLOR64;
        _forDecribeCXWYLabel.font = [UIFont fontWithName:TEXTFONT size:15.0];
        _forDecribeCXWYLabel.text = @"此处是对畅行无忧的描述";
    }
    return _forDecribeCXWYLabel;
}

- (BuyTireData *)buyTireData{
    
    if (_buyTireData == nil) {
        
        _buyTireData = [[BuyTireData alloc] init];
    }
    return _buyTireData;
}

- (UIButton *)nextBtn{
    
    if (_nextBtn == nil) {
        
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.frame = CGRectMake(10, MAINSCREEN.height - 104, MAINSCREEN.width - 20, 34);
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _nextBtn.layer.cornerRadius = 4.0;
        _nextBtn.layer.masksToBounds = YES;
        [_nextBtn addTarget:self action:@selector(chickNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}

- (void)chickNextBtn:(UIButton *)button{
    
    if ([self.tireView.numberLabel.text integerValue] <1) {
        
        [PublicClass showHUD:@"请选择轮胎数量" view:self.view];
    }else{
        
        QualityServiceViewController *qualityVC = [[QualityServiceViewController alloc] init];
        qualityVC.shoeSpeedResult = shoeSpeedLoadResult;
        qualityVC.buyTireData = self.buyTireData;
        qualityVC.tireCount = self.tireView.numberLabel.text;
        qualityVC.cxwyCount = self.cxwyView.numberLabel.text;
        qualityVC.fontRearFlag = fontRearFlag;
        [self.navigationController pushViewController:qualityVC animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"轮胎购买";
    [self getDataFromInternet];
    // Do any additional setup after loading the view.
}

- (void)getDataFromInternet{
    
    NSString *shoeIdStr = [NSString stringWithFormat:@"%@", shoeSpeedLoadResult.shoeId];
    NSString *userIdStr = [NSString stringWithFormat:@"%@", [UserConfig user_id]];
    NSDictionary *postDic = @{@"shoeId":shoeIdStr, @"userId":userIdStr};
    NSString *reqJsonStr = [PublicClass convertToJsonData:postDic];
    [JJRequest postRequest:@"getShoeDetailByShoeId" params:@{@"reqJson":reqJsonStr, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
            NSLog(@"getShoeDetailByShoeId:%@", data);
            [self analysizeData:data];
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"根据轮胎id和userId获取轮胎信息和畅行无忧价格的错误:%@", error);
    }];
}

- (void)analysizeData:(NSDictionary *)dic{
    
    if (dic == nil || [dic isKindOfClass:[NSNull class]]) {
        
        [PublicClass showHUD:@"当前轮胎没数据" view:self.view];
    }else{
        
        [self.buyTireData setValuesForKeysWithDictionary:dic];
        NSLog(@"%@", self.buyTireData);
        [self addView];
    }
}

- (void)addView{
    
    [self.view addSubview:self.mainScrollV];
    [_mainScrollV addSubview:self.sdcyleScrollV];
    self.sdcyleScrollV.imageURLStringsGroup = @[self.buyTireData.shoeUpImg, self.buyTireData.shoeDownImg, self.buyTireData.shoeLeftImg, self.buyTireData.shoeRightImg, self.buyTireData.shoeMiddleImg];
    [_mainScrollV addSubview:self.detailLabel];
    [_mainScrollV addSubview:self.pointCXWYLabel];
    [_mainScrollV addSubview:self.priceLabel];
    [_mainScrollV addSubview:self.topView];
    [_mainScrollV addSubview:self.tireNumberLabel];
    [_mainScrollV addSubview:self.tireView];
    [_mainScrollV addSubview:self.bottomView];
    [_mainScrollV addSubview:self.valueAddServiceBtn];
    [_mainScrollV addSubview:self.freeWorryLabel];
    [_mainScrollV addSubview:self.cxwyView];
    [_mainScrollV addSubview:self.forDecribeCXWYLabel];
    [_mainScrollV setContentSize:CGSizeMake(MAINSCREEN.width, (self.forDecribeCXWYLabel.frame.size.height + self.forDecribeCXWYLabel.frame.origin.y))];
    [self.view addSubview:self.nextBtn];
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

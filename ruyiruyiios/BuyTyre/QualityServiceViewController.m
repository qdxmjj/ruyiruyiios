//
//  QualityServiceViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/30.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "QualityServiceViewController.h"
#import "CustomQualityView.h"
#import "PurchaseProcessViewController.h"
#import "SureOrderViewController.h"

@interface QualityServiceViewController ()<UIScrollViewDelegate>

@property(nonatomic, strong)UIScrollView *mainScrollV;
@property(nonatomic, strong)CustomQualityView *qualityView;
@property(nonatomic, strong)UILabel *installLabel;
@property(nonatomic, strong)UILabel *describeForinstallLabel;
@property(nonatomic, strong)UIImageView *imgForinstall;
@property(nonatomic, strong)UILabel *freeServiceLabel;
@property(nonatomic, strong)UILabel *describeForfreeServiceLabel;
@property(nonatomic, strong)UIImageView *imgForfreeServicel;
@property(nonatomic, strong)UILabel *oneLabel;
@property(nonatomic, strong)UILabel *describeForoneLabel;
@property(nonatomic, strong)UIImageView *imgForone;
@property(nonatomic, strong)UIView *underLineView;
@property(nonatomic, strong)UIButton *replaceBtn;
@property(nonatomic, strong)UIImageView *processImageV;
@property(nonatomic, strong)UIButton *nextBtn;

@end

@implementation QualityServiceViewController
@synthesize buyTireData;
@synthesize shoeSpeedResult;
@synthesize cxwyCount;
@synthesize tireCount;
@synthesize fontRearFlag;
@synthesize cxwyAllpriceStr;

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (UIScrollView *)mainScrollV{
    
    if (_mainScrollV == nil) {
        
        _mainScrollV = [[UIScrollView alloc] init];
        _mainScrollV.frame = CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height - 40 - SafeDistance);
        _mainScrollV.backgroundColor = [UIColor clearColor];
        _mainScrollV.showsVerticalScrollIndicator = NO;
        _mainScrollV.showsHorizontalScrollIndicator = NO;
        _mainScrollV.bounces = NO;
        _mainScrollV.scrollsToTop = NO;
        _mainScrollV.tag = 1;
        _mainScrollV.delegate = self;
    }
    return _mainScrollV;
}

- (CustomQualityView *)qualityView{
    
    if (_qualityView == nil) {
        
        _qualityView = [[CustomQualityView alloc] initWithFrame:CGRectMake(0, 20, MAINSCREEN.width, 20)];
    }
    return _qualityView;
}

- (UILabel *)installLabel{
    
    if (_installLabel == nil) {
        
        _installLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.qualityView.frame.size.height+self.qualityView.frame.origin.y + 15, MAINSCREEN.width/3, 20)];
        _installLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _installLabel.textColor = [UIColor blackColor];
        _installLabel.text = @"免费换新";
        _installLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _installLabel;
}

- (UILabel *)describeForinstallLabel{
    
    if (_describeForinstallLabel == nil) {
        
        _describeForinstallLabel = [[UILabel alloc] init];
        [_describeForinstallLabel setNumberOfLines:0];
        _describeForinstallLabel.text = @"轮胎磨损至损耗标线或安装之日起满5年均可免费更换新胎。";
        _describeForinstallLabel.textColor = TEXTCOLOR64;
        _describeForinstallLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:_describeForinstallLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        CGSize describeSize = [_describeForinstallLabel.text boundingRectWithSize:CGSizeMake(MAINSCREEN.width/3 - 5, MAINSCREEN.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        [_describeForinstallLabel setFrame:CGRectMake(5, self.installLabel.frame.size.height+self.installLabel.frame.origin.y + 5, describeSize.width, describeSize.height)];
    }
    return _describeForinstallLabel;
}

- (UIImageView *)imgForinstall{
    
    if (_imgForinstall == nil) {
        
        _imgForinstall = [[UIImageView alloc] init];
        _imgForinstall.frame = CGRectMake(MAINSCREEN.width/3, self.qualityView.frame.size.height+self.qualityView.frame.origin.y + 15, MAINSCREEN.width*2/3, self.describeForinstallLabel.frame.size.height + 25);
        _imgForinstall.image = [UIImage imageNamed:@"ic_install"];
    }
    return _imgForinstall;
}

- (UILabel *)freeServiceLabel{
    
    if (_freeServiceLabel == nil) {
        
        _freeServiceLabel = [[UILabel alloc] initWithFrame:CGRectMake(MAINSCREEN.width*2/3, self.imgForinstall.frame.size.height+self.imgForinstall.frame.origin.y + 15, MAINSCREEN.width/3, 20)];
        _freeServiceLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _freeServiceLabel.textColor = [UIColor blackColor];
        _freeServiceLabel.text = @"免费安装";
        _freeServiceLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _freeServiceLabel;
}

- (UILabel *)describeForfreeServiceLabel{
    
    if (_describeForfreeServiceLabel == nil) {
        
        _describeForfreeServiceLabel = [[UILabel alloc] init];
        [_describeForfreeServiceLabel setNumberOfLines:0];
        _describeForfreeServiceLabel.text = @"可到任意合作门店进行免费安装调试。";
        _describeForfreeServiceLabel.textColor = TEXTCOLOR64;
        _describeForfreeServiceLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:_describeForfreeServiceLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        CGSize describeSize = [_describeForfreeServiceLabel.text boundingRectWithSize:CGSizeMake(MAINSCREEN.width/3 - 5, MAINSCREEN.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        [_describeForfreeServiceLabel setFrame:CGRectMake(MAINSCREEN.width*2/3, self.freeServiceLabel.frame.size.height+self.freeServiceLabel.frame.origin.y + 5, describeSize.width, describeSize.height)];
    }
    return _describeForfreeServiceLabel;
}

- (UIImageView *)imgForfreeServicel{
    
    if (_imgForfreeServicel == nil) {
        
        _imgForfreeServicel = [[UIImageView alloc] init];
        _imgForfreeServicel.frame = CGRectMake(0, self.imgForinstall.frame.size.height+self.imgForinstall.frame.origin.y + 15, MAINSCREEN.width*2/3 - 5, self.describeForinstallLabel.frame.size.height + 25);
        _imgForfreeServicel.image = [UIImage imageNamed:@"ic_free"];
    }
    return _imgForfreeServicel;
}

- (UILabel *)oneLabel{

    if (_oneLabel == nil) {

        _oneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.imgForfreeServicel.frame.size.height+self.imgForfreeServicel.frame.origin.y + 15, MAINSCREEN.width/3, 40)];
        _oneLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _oneLabel.textColor = [UIColor blackColor];
        _oneLabel.text = @"免费服务";
        _oneLabel.numberOfLines = 0;
        _oneLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _oneLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _oneLabel;
}

- (UILabel *)describeForoneLabel{

    if (_describeForoneLabel == nil) {

        _describeForoneLabel = [[UILabel alloc] init];
        [_describeForoneLabel setNumberOfLines:0];
        _describeForoneLabel.text = @"整车换胎，可到任意合作门店免费享受四轮定位、动平衡轮胎换位服务。";
        _describeForoneLabel.textColor = TEXTCOLOR64;
        _describeForoneLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:_describeForoneLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        CGSize describeSize = [_describeForoneLabel.text boundingRectWithSize:CGSizeMake(MAINSCREEN.width/3 - 5, MAINSCREEN.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        [_describeForoneLabel setFrame:CGRectMake(5, self.oneLabel.frame.size.height+self.oneLabel.frame.origin.y + 5, describeSize.width, describeSize.height)];
    }
    return _describeForoneLabel;
}

- (UIImageView *)imgForone{

    if (_imgForone == nil) {

        _imgForone = [[UIImageView alloc] init];
        _imgForone.frame = CGRectMake(MAINSCREEN.width/3, self.imgForfreeServicel.frame.size.height+self.imgForfreeServicel.frame.origin.y + 15, MAINSCREEN.width*2/3, self.describeForoneLabel.frame.size.height + 45);
        _imgForone.image = [UIImage imageNamed:@"ic_change"];
    }
    return _imgForone;
}

- (UIView *)underLineView{
    
    if (_underLineView == nil) {
        
        _underLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.imgForone.frame.size.height + self.imgForone.frame.origin.y + 15, MAINSCREEN.width, 0.5)];
        _underLineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _underLineView;
}

- (UIButton *)replaceBtn{
    
    if (_replaceBtn == nil) {
        
        _replaceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _replaceBtn.frame = CGRectMake(20, self.underLineView.frame.size.height + self.underLineView.frame.origin.y + 10, MAINSCREEN.width - 20, 20);
        _replaceBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _replaceBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_replaceBtn setTitle:@"更换流程" forState:UIControlStateNormal];
        [_replaceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_replaceBtn setImage:[UIImage imageNamed:@"ic_right"] forState:UIControlStateNormal];
        [_replaceBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -_replaceBtn.imageView.frame.size.width, 0, 0)];
        [_replaceBtn setImageEdgeInsets:UIEdgeInsetsMake(0, MAINSCREEN.width - 20 - 40, 0, 0)];
        [_replaceBtn addTarget:self action:@selector(chickReplaceBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _replaceBtn;
}

- (void)chickReplaceBtn:(UIButton *)button{
    
    PurchaseProcessViewController *purchasePVC = [[PurchaseProcessViewController alloc] init];
    [self.navigationController pushViewController:purchasePVC animated:YES];
}

- (UIImageView *)processImageV{
    
    if (_processImageV == nil) {
        
        _processImageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.replaceBtn.frame.size.height + self.replaceBtn.frame.origin.y + 15, MAINSCREEN.width - 20, 60)];
        _processImageV.image = [UIImage imageNamed:@"ic_procedure"];
    }
    return _processImageV;
}

- (UIButton *)nextBtn{
    
    if (_nextBtn == nil) {
        
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.frame = CGRectMake(10, MAINSCREEN.height - 40 - SafeDistance, MAINSCREEN.width - 20, 34);
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
    
    SureOrderViewController *sureVC = [[SureOrderViewController alloc] init];
    sureVC.shoeSpeedLoadResult = shoeSpeedResult;
    sureVC.buyTireData = buyTireData;
    sureVC.cxwyCount = cxwyCount;
    sureVC.tireCount = tireCount;
    sureVC.fontRearFlag = fontRearFlag;
    sureVC.cxwyAllpriceStr = cxwyAllpriceStr;
    [self.navigationController pushViewController:sureVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"品质服务";
    
    [self addView];
    // Do any additional setup after loading the view.
}

- (void)addView{
    
    [self.view addSubview:self.mainScrollV];
    [_mainScrollV addSubview:self.qualityView];
    [_mainScrollV addSubview:self.installLabel];
    [_mainScrollV addSubview:self.describeForinstallLabel];
    [_mainScrollV addSubview:self.imgForinstall];
    [_mainScrollV addSubview:self.freeServiceLabel];
    [_mainScrollV addSubview:self.describeForfreeServiceLabel];
    [_mainScrollV addSubview:self.imgForfreeServicel];
    [_mainScrollV addSubview:self.oneLabel];
    [_mainScrollV addSubview:self.describeForoneLabel];
    [_mainScrollV addSubview:self.imgForone];
    [_mainScrollV addSubview:self.underLineView];
    [_mainScrollV addSubview:self.replaceBtn];
    [_mainScrollV addSubview:self.processImageV];
    [_mainScrollV setContentSize:CGSizeMake(MAINSCREEN.width, self.processImageV.frame.size.height + self.processImageV.frame.origin.y + 10)];
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

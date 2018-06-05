//
//  PurchaseProcessViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/30.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "PurchaseProcessViewController.h"

@interface PurchaseProcessViewController ()<UIScrollViewDelegate>

@property(nonatomic, strong)UIScrollView *mainScrollV;
@property(nonatomic, strong)UIImageView *imgForselectTire;
@property(nonatomic, strong)UIView *s_nView;
@property(nonatomic, strong)UILabel *selectLabel;
@property(nonatomic, strong)UILabel *detailforSelectLabel;
@property(nonatomic, strong)UIImageView *imgFornotWorry;
@property(nonatomic, strong)UIView *n_pView;
@property(nonatomic, strong)UILabel *notworryLabel;
@property(nonatomic, strong)UILabel *detailnotworryLabel;
@property(nonatomic, strong)UIImageView *imgForpay;
@property(nonatomic, strong)UIView *p_uView;
@property(nonatomic, strong)UILabel *payLabel;
@property(nonatomic, strong)UILabel *detailforpayLabel;
@property(nonatomic, strong)UIImageView *imgForupdateTire;
@property(nonatomic, strong)UILabel *updateLabel;
@property(nonatomic, strong)UILabel *detailforupdateLabel;

@end

@implementation PurchaseProcessViewController

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
}

- (UIScrollView *)mainScrollV{
    
    if (_mainScrollV == nil) {
        
        _mainScrollV = [[UIScrollView alloc] init];
        _mainScrollV.frame = CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height - 104);
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

- (UIImageView *)imgForselectTire{
    
    if (_imgForselectTire == nil) {
        
        _imgForselectTire = [[UIImageView alloc] init];
        _imgForselectTire.frame = CGRectMake(20, 20, 30, 30);
        _imgForselectTire.image = [UIImage imageNamed:@"ic_choose"];
    }
    return _imgForselectTire;
}

- (UIView *)s_nView{
    
    if (_s_nView == nil) {
        
        _s_nView = [[UIView alloc] initWithFrame:CGRectMake(34, self.imgForselectTire.frame.size.height + self.imgForselectTire.frame.origin.y, 2, (self.imgFornotWorry.frame.origin.y - (self.imgForselectTire.frame.origin.y + 30)))];
        _s_nView.backgroundColor = [PublicClass colorWithHexString:@"#fd6974"];
    }
    return _s_nView;
}

- (UILabel *)selectLabel{
    
    if (_selectLabel == nil) {
        
        _selectLabel = [[UILabel alloc] init];
        _selectLabel.frame = CGRectMake(60, 20, MAINSCREEN.width - 60, 20);
        _selectLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _selectLabel.text = @"选择轮胎";
        _selectLabel.textColor = [UIColor blackColor];
    }
    return _selectLabel;
}

- (UILabel *)detailforSelectLabel{
    
    if (_detailforSelectLabel == nil) {
        
        _detailforSelectLabel = [[UILabel alloc] init];
        [_detailforSelectLabel setNumberOfLines:0];
        _detailforSelectLabel.text = @"选择您想要更换的轮胎，如果您的爱车前后轮胎规格相同，你无需区分前后轮规格，一次性购买4条轮胎即可";
        _detailforSelectLabel.textColor = TEXTCOLOR64;
        _detailforSelectLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        NSMutableParagraphStyle *paragrephStyle = [[NSMutableParagraphStyle alloc] init];
        paragrephStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:_detailforSelectLabel.font, NSParagraphStyleAttributeName:paragrephStyle.copy};
        CGSize detailSize = [_detailforSelectLabel.text boundingRectWithSize:CGSizeMake(MAINSCREEN.width - 60, MAINSCREEN.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        [_detailforSelectLabel setFrame:CGRectMake(60, 40, detailSize.width, detailSize.height)];
    }
    return _detailforSelectLabel;
}

- (UIImageView *)imgFornotWorry{
    
    if (_imgFornotWorry == nil) {
        
        _imgFornotWorry = [[UIImageView alloc] init];
        _imgFornotWorry.frame = CGRectMake(20, self.detailforSelectLabel.frame.size.height + self.detailforSelectLabel.frame.origin.y + 15, 30, 30);
        _imgFornotWorry.image = [UIImage imageNamed:@"ic_service"];
    }
    return _imgFornotWorry;
}

- (UIView *)n_pView{
    
    if (_n_pView == nil) {
        
        _n_pView = [[UIView alloc] initWithFrame:CGRectMake(34, self.imgFornotWorry.frame.size.height + self.imgFornotWorry.frame.origin.y, 2, (self.imgForpay.frame.origin.y - (self.imgFornotWorry.frame.origin.y + 30)))];
        _n_pView.backgroundColor = [PublicClass colorWithHexString:@"#fd6974"];
    }
    return _n_pView;
}

- (UILabel *)notworryLabel{
    
    if (_notworryLabel == nil) {
        
        _notworryLabel = [[UILabel alloc] init];
        _notworryLabel.frame = CGRectMake(60, self.imgFornotWorry.frame.origin.y, MAINSCREEN.width - 60, 20);
        _notworryLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _notworryLabel.text = @"畅行无忧";
        _notworryLabel.textColor = [UIColor blackColor];
    }
    return _notworryLabel;
}

- (UILabel *)detailnotworryLabel{
    
    if (_detailnotworryLabel == nil) {
        
        _detailnotworryLabel = [[UILabel alloc] init];
        [_detailnotworryLabel setNumberOfLines:0];
        _detailnotworryLabel.text = @"如果您希望您爱车的轮胎无论在任何情况下都享受免费更换服务的话，您可以购买畅行无忧服务";
        _detailnotworryLabel.textColor = TEXTCOLOR64;
        _detailnotworryLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        NSMutableParagraphStyle *paragrephStyle = [[NSMutableParagraphStyle alloc] init];
        paragrephStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:_detailnotworryLabel.font, NSParagraphStyleAttributeName:paragrephStyle.copy};
        CGSize detailSize = [_detailnotworryLabel.text boundingRectWithSize:CGSizeMake(MAINSCREEN.width - 60, MAINSCREEN.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        [_detailnotworryLabel setFrame:CGRectMake(60, self.notworryLabel.frame.origin.y + self.notworryLabel.frame.size.height, detailSize.width, detailSize.height)];
    }
    return _detailnotworryLabel;
}

- (UIImageView *)imgForpay{
    
    if (_imgForpay == nil) {
        
        _imgForpay = [[UIImageView alloc] init];
        _imgForpay.frame = CGRectMake(20, self.detailnotworryLabel.frame.origin.y + self.detailnotworryLabel.frame.size.height + 15, 30, 30);
        _imgForpay.image = [UIImage imageNamed:@"ic_buy"];
    }
    return _imgForpay;
}

- (UIView *)p_uView{
    
    if (_p_uView == nil) {
        
        _p_uView = [[UIView alloc] initWithFrame:CGRectMake(34, self.imgForpay.frame.size.height + self.imgForpay.frame.origin.y, 2, (self.imgForupdateTire.frame.origin.y - (self.imgForpay.frame.origin.y + 30)))];
        _p_uView.backgroundColor = [PublicClass colorWithHexString:@"#fd6974"];
    }
    return _p_uView;
}

- (UILabel *)payLabel{
    
    if (_payLabel == nil) {
        
        _payLabel = [[UILabel alloc] init];
        _payLabel.frame = CGRectMake(60, self.imgForpay.frame.origin.y, MAINSCREEN.width - 60, 20);
        _payLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _payLabel.text = @"下单支付";
        _payLabel.textColor = [UIColor blackColor];
    }
    return _payLabel;
}

- (UILabel *)detailforpayLabel{
    
    if (_detailforpayLabel == nil) {
        
        _detailforpayLabel = [[UILabel alloc] init];
        [_detailforpayLabel setNumberOfLines:0];
        _detailforpayLabel.text = @"选择轮胎后，提交订单支付";
        _detailforpayLabel.textColor = TEXTCOLOR64;
        _detailforpayLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        NSMutableParagraphStyle *paragrephStyle = [[NSMutableParagraphStyle alloc] init];
        paragrephStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:_detailforpayLabel.font, NSParagraphStyleAttributeName:paragrephStyle.copy};
        CGSize detailSize = [_detailforpayLabel.text boundingRectWithSize:CGSizeMake(MAINSCREEN.width - 60, MAINSCREEN.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        [_detailforpayLabel setFrame:CGRectMake(60, self.payLabel.frame.size.height + self.payLabel.frame.origin.y, detailSize.width, detailSize.height)];
    }
    return _detailforpayLabel;
}

- (UIImageView *)imgForupdateTire{
    
    if (_imgForupdateTire == nil) {
        
        _imgForupdateTire = [[UIImageView alloc] init];
        _imgForupdateTire.frame = CGRectMake(20, self.detailforpayLabel.frame.size.height + self.detailforpayLabel.frame.origin.y + 15, 30, 30);
        _imgForupdateTire.image = [UIImage imageNamed:@"ic_wait"];
    }
    return _imgForupdateTire;
}

- (UILabel *)updateLabel{
    
    if (_updateLabel == nil) {
        
        _updateLabel = [[UILabel alloc] init];
        _updateLabel.frame = CGRectMake(60, self.imgForupdateTire.frame.origin.y, MAINSCREEN.width - 60, 20);
        _updateLabel.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _updateLabel.text = @"待更换轮胎";
        _updateLabel.textColor = [UIColor blackColor];
    }
    return _updateLabel;
}

- (UILabel *)detailforupdateLabel{
    
    if (_detailforupdateLabel == nil) {
        
        _detailforupdateLabel = [[UILabel alloc] init];
        [_detailforupdateLabel setNumberOfLines:0];
        _detailforupdateLabel.text = @"支付成功后，您购买的轮胎将进入待更换轮胎页面，您以后可以随时选择轮胎更换";
        _detailforupdateLabel.textColor = TEXTCOLOR64;
        _detailforupdateLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        NSMutableParagraphStyle *paragrephStyle = [[NSMutableParagraphStyle alloc] init];
        paragrephStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:_detailforupdateLabel.font, NSParagraphStyleAttributeName:paragrephStyle.copy};
        CGSize detailSize = [_detailforupdateLabel.text boundingRectWithSize:CGSizeMake(MAINSCREEN.width - 60, MAINSCREEN.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        [_detailforupdateLabel setFrame:CGRectMake(60, self.updateLabel.frame.size.height + self.updateLabel.frame.origin.y, detailSize.width, detailSize.height)];
    }
    return _detailforupdateLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购买流程";
    
    [self addView];
    // Do any additional setup after loading the view.
}

- (void)addView{
    
    [self.view addSubview:self.mainScrollV];
    [_mainScrollV addSubview:self.imgForselectTire];
    [_mainScrollV addSubview:self.selectLabel];
    [_mainScrollV addSubview:self.detailforSelectLabel];
    [_mainScrollV addSubview:self.imgFornotWorry];
    [_mainScrollV addSubview:self.notworryLabel];
    [_mainScrollV addSubview:self.detailnotworryLabel];
    [_mainScrollV addSubview:self.imgForpay];
    [_mainScrollV addSubview:self.payLabel];
    [_mainScrollV addSubview:self.detailforpayLabel];
    [_mainScrollV addSubview:self.imgForupdateTire];
    [_mainScrollV addSubview:self.updateLabel];
    [_mainScrollV addSubview:self.detailforupdateLabel];
    [_mainScrollV addSubview:self.s_nView];
    [_mainScrollV addSubview:self.n_pView];
    [_mainScrollV addSubview:self.p_uView];
    [_mainScrollV setContentSize:CGSizeMake(MAINSCREEN.width, self.detailforupdateLabel.frame.size.height + self.detailforupdateLabel.frame.origin.y + 10)];
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

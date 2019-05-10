//
//  SelectBuyTireInfoViewController.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/8/13.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "SelectBuyTireInfoViewController.h"
#import "SelectBuyTireInfoCell.h"
#import <UIImageView+WebCache.h>
#import "JJSliderView.h"
#import "HYStepper.h"
#import <Masonry.h>
#import "CXWYPriceParamInfo.h"
@interface SelectBuyTireInfoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,valueChangdDelegate>

@property(nonatomic,strong)UIScrollView *mainView;

@property(nonatomic,strong)UIView *backGroupView;

@property(nonatomic,strong)UIImageView *imgView;//轮胎图片

@property(nonatomic,strong)UILabel *priceLab;//轮胎单价

@property(nonatomic,strong)UIButton *dismissBtn;//关闭页面按钮

@property(nonatomic,strong)UILabel *contentLab;//轮胎介绍

@property(nonatomic,strong)UILabel *patternLab;//花纹lab

@property(nonatomic,strong)UILabel *speedLab;//速度级别

@property(nonatomic,strong)UILabel *serviceLab;//服务年限

@property(nonatomic,strong)JJSliderView *jjSliderView;

@property(nonatomic,strong)UILabel *tireNumberLab;//轮胎数量

@property(nonatomic,strong)HYStepper *stepper1;

@property(nonatomic,strong)UIButton *noWorriesBtn;//畅行无忧

@property(nonatomic,strong)UILabel *cxwyPrice;//畅行无忧总价

@property(nonatomic,strong)HYStepper *stepper2;

@property(nonatomic,strong)UICollectionView *collectionView;//花纹块

@property(nonatomic,strong)UICollectionView *collectionView1;//速度块

@property(nonatomic,strong)UILabel *descriptionLab;

@property(nonatomic,strong)UIButton *confirmBtn;

@property(nonatomic,strong)NSArray *shoeSpeedLoadResultList;//速度级别 数组

@property(nonatomic,strong)NSDictionary *priceMap;// 速度级别 对应的 价格字典

@property(nonatomic,strong)NSDictionary *cxwyPriceMap;//速度级别 对应的 价格字典

@property(nonatomic,strong)BuyTireData *buyTireData;//轮胎详情

@property(nonatomic,assign)NSInteger    shoeID;

@property(nonatomic,copy)  NSString     *imgURL;

@end

@implementation SelectBuyTireInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:self.backGroupView];
    [self.backGroupView addSubview:self.mainView];
    [self.backGroupView addSubview:self.confirmBtn];
    [self.mainView addSubview:self.imgView];
    [self.mainView addSubview:self.priceLab];
    [self.mainView addSubview:self.dismissBtn];
    [self.mainView addSubview:self.contentLab];
    [self.mainView addSubview:self.patternLab];
    [self.mainView addSubview:self.collectionView];
    [self.mainView addSubview:self.speedLab];
    [self.mainView addSubview:self.collectionView1];
    [self.mainView addSubview:self.serviceLab];
    [self.mainView addSubview:self.jjSliderView];
    [self.mainView addSubview:self.tireNumberLab];
    [self.mainView addSubview:self.stepper1];
    [self.mainView addSubview:self.noWorriesBtn];
    [self.mainView addSubview:self.cxwyPrice];
    [self.mainView addSubview:self.stepper2];
    [self.mainView addSubview:self.descriptionLab];
    [self setUI];
    
    self.stepper1.value = [self.tireNumber floatValue];
    self.stepper2.value = [self.cxwuNumber floatValue];
    
    self.jjSliderView.maximum = [self.service_year floatValue];
    
    if ([self.service_end_date isEqualToString:@""] || self.service_end_date == nil || [self.service_end_date isEqual:[NSNull null]]) {
        
    }else{
        self.jjSliderView.value = [self.service_year_length floatValue];
    }
}
-(void)setUI{
    
    [self.backGroupView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(.77);
        make.left.and.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.mas_equalTo(self.backGroupView).inset(10);
        make.height.mas_equalTo(@40);
        make.bottom.mas_equalTo(self.backGroupView.mas_bottom).inset(bottom_height);
    }];
    
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.backGroupView.mas_top);
        make.left.and.right.mas_equalTo(self.backGroupView);
//        make.centerX.mas_equalTo(self.backGroupView.mas_centerX);
        make.bottom.mas_equalTo(self.confirmBtn.mas_top);
        make.bottom.mas_equalTo(self.descriptionLab.mas_bottom);
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.backGroupView.mas_top).inset(10);
        make.width.and.height.mas_equalTo(self.mainView.mas_width).multipliedBy(0.3);
        make.left.mas_equalTo(self.backGroupView.mas_left).inset(10);
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.imgView.mas_top);
        make.height.mas_equalTo(20);
        make.left.mas_equalTo(self.imgView.mas_right).inset(5);
    }];
    
    [self.dismissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.backGroupView.mas_right).inset(10);
        make.top.mas_equalTo(self.imgView.mas_top);
        make.width.and.height.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.priceLab.mas_bottom).inset(3);
        make.left.mas_equalTo(self.imgView.mas_right).inset(5);
        make.right.mas_equalTo(self.backGroupView.mas_right).inset(10);
        make.bottom.mas_equalTo(self.imgView.mas_bottom);
    }];
    
    [self.patternLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.imgView.mas_bottom).inset(15);
        make.left.mas_equalTo(self.backGroupView.mas_left).inset(10);
        make.height.mas_equalTo(20);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.backGroupView);
        make.top.mas_equalTo(self.patternLab.mas_bottom).inset(5);
        //        make.height.mas_equalTo(@40);
        
        if (self.patternArr.count%3 != 0) {
            
            make.height.mas_equalTo(40*(self.patternArr.count/3 + 1)+((self.patternArr.count/3)*11));
        }else{
            make.height.mas_equalTo(40*(self.patternArr.count/3)+((self.patternArr.count/3)*11));
        }
    }];
    
    [self.speedLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.collectionView.mas_bottom).inset(5);
        make.left.mas_equalTo(self.backGroupView.mas_left).inset(10);
        make.height.mas_equalTo(@20);
    }];
    
    [self.collectionView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.mas_equalTo(self.backGroupView);
        make.top.mas_equalTo(self.speedLab.mas_bottom).inset(5);
        make.height.mas_equalTo(@40);
    }];
    
    [self.serviceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        if ([self.service_end_date isEqualToString:@""] || self.service_end_date == nil || [self.service_end_date isEqual:[NSNull null]]) {
            
            make.height.mas_equalTo(@20);
        }else{
            make.height.mas_equalTo(@0);
        }
        make.top.mas_equalTo(self.collectionView1.mas_bottom).inset(5);
        make.left.mas_equalTo(self.backGroupView.mas_left).inset(10);
    }];
    
    [self.jjSliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        if ([self.service_end_date isEqualToString:@""] || self.service_end_date == nil || [self.service_end_date isEqual:[NSNull null]]) {
            
            make.height.mas_equalTo(@60);
        }else{
            self.jjSliderView.hidden = YES;
            make.height.mas_equalTo(@0);
        }
        make.leading.and.trailing.mas_equalTo(self.backGroupView).inset(10);
        make.top.mas_equalTo(self.serviceLab.mas_bottom).inset(5);
    }];
    
    [self.tireNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.jjSliderView.mas_bottom).inset(10);
        make.left.mas_equalTo(self.backGroupView.mas_left).inset(10);
        make.height.mas_equalTo(@40);
    }];
    
    [self.stepper1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.backGroupView.mas_right).inset(10);
        make.centerY.mas_equalTo(self.tireNumberLab.mas_centerY);
        make.height.mas_equalTo(@35);
    }];
    
    [self.noWorriesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.backGroupView.mas_left).inset(10);
        make.top.mas_equalTo(self.tireNumberLab.mas_bottom).inset(5);
        make.height.mas_equalTo(@40);
    }];
    
    [self.cxwyPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.noWorriesBtn.mas_right);
        make.centerY.mas_equalTo(self.noWorriesBtn.mas_centerY);
        make.height.mas_equalTo(@40);
    }];
    
    [self.stepper2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.backGroupView.mas_right).inset(10);
        make.centerY.mas_equalTo(self.noWorriesBtn.mas_centerY);
        make.height.mas_equalTo(@35);
    }];
    
    [self.descriptionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.mas_equalTo(self.backGroupView).inset(10);
        make.top.mas_equalTo(self.noWorriesBtn.mas_bottom);
        make.height.mas_equalTo(80);
    }];
    
    [self.view layoutIfNeeded];
}

-(UIView *)backGroupView{
    
    if (!_backGroupView) {
        
        _backGroupView = [[UIView alloc] init];
        _backGroupView.backgroundColor = [UIColor whiteColor];
        _backGroupView.layer.cornerRadius = 5.f;
        _backGroupView.layer.masksToBounds = YES;
    }
    return _backGroupView;
}

-(UIButton *)confirmBtn{
    
    if (!_confirmBtn) {
        
        _confirmBtn = [[UIButton alloc] init];
        [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_confirmBtn setBackgroundColor:LOGINBACKCOLOR];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(confirmTireInfoEvent) forControlEvents:UIControlEventTouchUpInside];
        _confirmBtn.layer.cornerRadius = 5.f;
        _confirmBtn.layer.masksToBounds = YES;
    }
    return _confirmBtn;
}


-(UIScrollView *)mainView{
    
    if (!_mainView) {
        
        _mainView = [[UIScrollView alloc] init];
        _mainView.backgroundColor = [UIColor whiteColor];
        _mainView.showsVerticalScrollIndicator = NO;
        _mainView.showsHorizontalScrollIndicator = NO;
        _mainView.scrollsToTop = NO;
    }
    return _mainView;
}

-(UIImageView *)imgView{
    
    if (!_imgView) {
        
        _imgView = [[UIImageView alloc] init];
        _imgView.backgroundColor = [UIColor lightGrayColor];
    }
    return _imgView;
}

-(UILabel *)priceLab{
    
    if (!_priceLab) {
        
        _priceLab = [[UILabel alloc] init];
        _priceLab.textColor = [UIColor redColor];
    }
    return _priceLab;
}

-(UIButton *)dismissBtn{
    
    if (!_dismissBtn) {
        _dismissBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        [_dismissBtn setImage:[UIImage imageNamed:@"ic_close"] forState:UIControlStateNormal];
        [_dismissBtn addTarget:self action:@selector(dismissViewcontroller:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dismissBtn;
}

-(UILabel *)contentLab{
    
    if (!_contentLab) {
        
        _contentLab = [[UILabel alloc] init];
        _contentLab.textColor = TEXTCOLOR64;
        _contentLab.font = [UIFont systemFontOfSize:15.f];
        _contentLab.numberOfLines = 0;
        _contentLab.textAlignment = NSTextAlignmentLeft;
    }
    return _contentLab;
}

-(UILabel *)patternLab{
    
    if (!_patternLab) {
        
        _patternLab = [[UILabel alloc] init];
        _patternLab.text = @"花纹";
        _patternLab.textColor = TEXTCOLOR64;
    }
    return _patternLab;
}
-(UILabel *)speedLab{
    
    if (!_speedLab) {
        _speedLab = [[UILabel alloc] init];
        _speedLab.text = @"速度级别";
        _speedLab.textColor = TEXTCOLOR64;
        
    }
    return _speedLab;
}
-(UILabel *)serviceLab{
    if (!_serviceLab) {
        
        _serviceLab = [[UILabel alloc] init];
        _serviceLab.text = @"服务年限";
        _serviceLab.textColor = TEXTCOLOR64;
        
    }
    return _serviceLab;
}
-(UILabel *)tireNumberLab{
    if (!_tireNumberLab) {
        
        _tireNumberLab = [[UILabel alloc] init];
        _tireNumberLab.text = @"轮胎数量";
        _tireNumberLab.textColor = TEXTCOLOR64;
        
    }
    return _tireNumberLab;
}

-(HYStepper *)stepper1{
    
    if (!_stepper1) {
        
        _stepper1 = [[HYStepper alloc] init];
        _stepper1.maxValue = 4;
        _stepper1.delagate = self;
    }
    return _stepper1;
}

-(UIButton *)noWorriesBtn{
    
    if (!_noWorriesBtn) {
        
        _noWorriesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_noWorriesBtn setTitle:@" 畅行无忧 |" forState:UIControlStateNormal];
        [_noWorriesBtn setTitleColor:TEXTCOLOR64 forState:UIControlStateNormal];
        [_noWorriesBtn setImage:[UIImage imageNamed:@"ic_changxingwuyou.png"] forState:UIControlStateNormal];
    }
    return _noWorriesBtn;
}

-(UILabel *)cxwyPrice{
    
    if (!_cxwyPrice) {
        
        _cxwyPrice = [[UILabel alloc] init];
        _cxwyPrice.textColor = TEXTCOLOR64;
        _cxwyPrice.font = [UIFont systemFontOfSize:15.f];
    }
    return _cxwyPrice;
}

-(HYStepper *)stepper2{
    
    if (!_stepper2) {
        
        _stepper2 = [[HYStepper alloc] init];
        _stepper2.maxValue = 7;
        _stepper2.delagate = self;
    }
    return _stepper2;
}

-(UICollectionView *)collectionView{
    
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 1;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SelectBuyTireInfoCell class]) bundle:nil] forCellWithReuseIdentifier:@"tireInfoCollectionViewCellID"];
        
    }
    return _collectionView;
}

-(UICollectionView *)collectionView1{
    
    if (!_collectionView1) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 1;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        _collectionView1 = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView1.delegate = self;
        _collectionView1.dataSource = self;
        _collectionView1.backgroundColor = [UIColor whiteColor];
        [_collectionView1 registerNib:[UINib nibWithNibName:NSStringFromClass([SelectBuyTireInfoCell class]) bundle:nil] forCellWithReuseIdentifier:@"tireInfoCollectionViewCellID1"];
    }
    return _collectionView1;
}

-(JJSliderView *)jjSliderView{
    
    if (!_jjSliderView) {
        
        _jjSliderView = [[JJSliderView alloc] init];
        _jjSliderView.backgroundColor = [UIColor whiteColor];
        
        _jjSliderView.minimum = 1.f;
        _jjSliderView.value = 1.f;
    }
    return _jjSliderView;
}

-(UILabel *)descriptionLab{
    
    if (!_descriptionLab) {
        
        _descriptionLab = [[UILabel alloc] init];
        _descriptionLab.text = @"无论何种原因导致的如驿如意轮胎损坏经修补后无法正常使用，只要轮胎还能识别出是如驿如意的轮胎，即可免费更换新轮胎";
        _descriptionLab.font = [UIFont systemFontOfSize:14.f];
        _descriptionLab.textColor = TEXTCOLOR64;
        _descriptionLab.numberOfLines = 0;
        _descriptionLab.textAlignment = NSTextAlignmentLeft;
    }
    return _descriptionLab;
}

-(NSArray *)shoeSpeedLoadResultList{
    
    if (!_shoeSpeedLoadResultList) {
        
        _shoeSpeedLoadResultList = [NSArray array];
    }
    return _shoeSpeedLoadResultList;
}

-(NSDictionary *)priceMap{
    
    if (!_priceMap) {
        
        _priceMap = [NSDictionary dictionary];
    }
    return _priceMap;
}

-(NSDictionary *)cxwyPriceMap{
    
    if (!_cxwyPriceMap) {
        
        _cxwyPriceMap = [NSDictionary dictionary];
    }
    
    return _cxwyPriceMap;
}
-(BuyTireData *)buyTireData{
    
    if (!_buyTireData) {
        
        _buyTireData = [[BuyTireData alloc] init];
    }
    return _buyTireData;
}

-(void)dismissViewcontroller:(UIButton *)btn{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)confirmTireInfoEvent{
    
    NSString *remainYear = @"";
    
    if ([self.service_end_date isEqualToString:@""] || self.service_end_date == nil || [self.service_end_date isEqual:[NSNull null]]) {
        
        remainYear = [NSString stringWithFormat:@"%.0f",self.jjSliderView.currentValue];
        
    }else{
        
        remainYear = [NSString stringWithFormat:@"%@",self.service_year_length];
    }
    
    if (self.shoeID == 0 ||!self.shoeID) {
        
        [PublicClass showHUD:@"请选择速度级别！" view:self.view];
        return;
    }
    
    if (self.stepper1.value <= 0) {
        
        [PublicClass showHUD:@"最少选择一条轮胎！" view:self.view];
        return;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectTireInfoWithPrice:tireInfo:tireNumber:cxwyNumber:cxwyPrice:buyTireData:shoeID:remainYear:imgURL:)]) {
        
        [self.delegate selectTireInfoWithPrice:self.priceLab.text tireInfo:self.contentLab.text tireNumber:[NSString stringWithFormat:@"%.0f",self.stepper1.value] cxwyNumber:[NSString stringWithFormat:@"%.0f",self.stepper2.value] cxwyPrice:self.cxwyPrice.text buyTireData:self.buyTireData shoeID:[NSString stringWithFormat:@"%ld",(long)self.shoeID] remainYear:remainYear imgURL:self.imgURL];
    }

    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setPatternArr:(NSArray *)patternArr{
    
    _patternArr = patternArr;
    
    //设置默认展示图片
    [self.imgView sd_setImageWithURL:[patternArr[0] objectForKey:@"imgMiddleUrl"]];
    
    self.imgURL = [patternArr[0] objectForKey:@"imgMiddleUrl"];
    
    [self.collectionView reloadData];
    
    JJWeakSelf
    self.jjSliderView.numberChangeBlock = ^(NSString *numberStr) {
        
        if (weakSelf.priceMap.count<=0) {
            
            return ;
        }
        //根据服务年限改变 当前样式轮胎！ 的价格!
        weakSelf.priceLab.text = [NSString stringWithFormat:@"¥%@",[weakSelf.priceMap objectForKey:numberStr]];
        
        if (weakSelf.stepper2.value >0) {
            
            //如果存在畅行无忧 修改服务年限 也需要修改畅行无忧价格  仅限于新版本 老版本 不根据服务年限来获取畅行无忧价格
            [weakSelf valueChangedWithValue:weakSelf.stepper2.value stepper:weakSelf.stepper2];
        }
    };
}

//获取畅行无忧价格
-(void)valueChangedWithValue:(CGFloat)value stepper:(HYStepper *)stepper{
    
    if ([stepper isEqual:self.stepper2]) {
        
        if ([[NSString stringWithFormat:@"%.0f",value] integerValue] == 0) {
            
            self.cxwyPrice.text =@"";
            return;
        }
        
        //        //老版本取价格
        //        NSArray *arr = self.buyTireData.cxwyPriceParamList;
        //        for (NSDictionary *dic in arr) {
        //
        //            if ([[dic objectForKey:@"id"] longLongValue] == [[NSString stringWithFormat:@"%.0f",value] integerValue]) {
        //
        //                // rate * shoeBasePrice / 100 == 实际显示价格
        //                NSInteger shoeBasePrice = [self.buyTireData.shoeBasePrice integerValue];
        //                NSInteger cxwyPrice =  [[dic objectForKey:@"rate"] integerValue] * shoeBasePrice /100;
        //                self.cxwyPrice.text = [NSString stringWithFormat:@"¥%ld",cxwyPrice];
        //            }
        //        }
        
        //新版取价格  先取选了多少年的轮胎服务年限 再取选了多少年的畅行无忧
        //        NSDictionary *cxwyPriceMap = self.buyTireData.cxwyPriceMap;
        
        
        //新新版 =.= 重设畅行无忧价格 畅行无忧价格赛选条件: 先根据 速度级别列表 查询畅行无忧价格表 然后 查询对应服务年限 对应畅行无忧数量的价格
        if (self.cxwyPriceMap.count<=0) {
            
            return;
        }
        
        NSString *newCxwyPrice = self.cxwyPriceMap[self.jjSliderView.currentValueStr][[NSString stringWithFormat:@"%.0f",value]];
        NSLog(@"当前的价格：%@",newCxwyPrice);
        self.cxwyPrice.text = newCxwyPrice;
        
    }else{
        
    }
    
    
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if ([collectionView isEqual:self.collectionView]) {
        
        //花纹cell
        SelectBuyTireInfoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tireInfoCollectionViewCellID" forIndexPath:indexPath];
        
        cell.titleLab.text = [[self.patternArr[indexPath.row] objectForKey:@"shoeDetailResult"] objectForKey:@"figure"];
        [self.imgView sd_setImageWithURL:[self.patternArr[indexPath.row] objectForKey:@"imgMiddleUrl"]];
        
        return cell;
        
    }else{
        
        //速度级别cell
        SelectBuyTireInfoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tireInfoCollectionViewCellID1" forIndexPath:indexPath];
        
        NSString *str = [self.shoeSpeedLoadResultList[indexPath.row] objectForKey:@"speedLoadStr"];
        cell.titleLab.text = [str componentsSeparatedByString:@"/￥"][0];
        
        cell.titleLab.textColor = [UIColor blackColor];
        cell.titleLab.layer.borderColor = [UIColor blackColor].CGColor;
        cell.titleLab.backgroundColor = [UIColor whiteColor];
        
        return cell;
    }
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if ([collectionView isEqual:self.collectionView]) {
        
        if (self.patternArr.count>0) {
            
            return self.patternArr.count;
        }
        return 0;
    }else{
        
        if (self.shoeSpeedLoadResultList.count>0) {
            
            return self.shoeSpeedLoadResultList.count;
        }
        return 0;
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return CGSizeMake((self.view.frame.size.width - 40) /3, 30);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([collectionView isEqual:self.collectionView]) {
        
        /*选择花纹item*/
        //重置速度级别数组
        self.shoeSpeedLoadResultList = [_patternArr[indexPath.row] objectForKey:@"shoeSpeedLoadResultList"];
        
        //选择新的花纹 重置畅行无忧价格
        [self.buyTireData setValuesForKeysWithDictionary:[_patternArr[indexPath.row] objectForKey:@"shoeDetailResult"]];
        self.stepper2.value = 0.f;
        
        //重设显示的图片
        [self.imgView sd_setImageWithURL:[_patternArr[indexPath.row] objectForKey:@"imgMiddleUrl"]];
        
        self.imgURL = [_patternArr[indexPath.row] objectForKey:@"imgMiddleUrl"];
        
        //选择花纹重置价格
        self.priceLab.text = @"";
        self.shoeID = 0;
        //重置已选内容
        self.contentLab.text = [NSString stringWithFormat:@"已选 %@",self.buyTireData.detailStr];
        
        //刷新速度级别
        [self.collectionView1 reloadData];
        
        [self.collectionView1 mas_updateConstraints:^(MASConstraintMaker *make) {
            
            if (self.shoeSpeedLoadResultList.count%3 != 0) {
                
                make.height.mas_equalTo(40*(self.shoeSpeedLoadResultList.count/3 + 1)+((self.shoeSpeedLoadResultList.count/3)*11));
            }else{
                make.height.mas_equalTo(40*(self.shoeSpeedLoadResultList.count/3)+((self.shoeSpeedLoadResultList.count/3)*11));
            }
        }];
        
        //清空 畅行无忧价格字典
        self.cxwyPriceMap = @{};
        
        //选中色
        SelectBuyTireInfoCell *cell = (SelectBuyTireInfoCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.titleLab.textColor = LOGINBACKCOLOR;
        cell.titleLab.layer.borderColor = LOGINBACKCOLOR.CGColor;
        cell.titleLab.backgroundColor = [LOGINBACKCOLOR colorWithAlphaComponent:0.1];
        
    }else if([collectionView isEqual:self.collectionView1]){
        
        /*选择速度级别item*/
        
        //设置速度级别对应的价格字典
        self.priceMap = [self.shoeSpeedLoadResultList[indexPath.row] objectForKey:@"priceMap"];
        //设置轮胎ID
        self.shoeID = [[self.shoeSpeedLoadResultList[indexPath.row] objectForKey:@"shoeId"] integerValue];
        
        self.cxwyPriceMap = [self.shoeSpeedLoadResultList[indexPath.row] objectForKey:@"cxwyPriceMap"];
        //重设显示的内容
        NSString *str = [self.shoeSpeedLoadResultList[indexPath.row] objectForKey:@"speedLoadStr"];
        self.contentLab.text = [NSString stringWithFormat:@"已选 %@,%@",self.buyTireData.detailStr,[str componentsSeparatedByString:@"/￥"][0]];
        
        //重设显示的轮胎价格
        if ([self.service_end_date isEqualToString:@""] || self.service_end_date == nil || [self.service_end_date isEqual:[NSNull null]]) {
            
            self.priceLab.text = [NSString stringWithFormat:@"¥%@",[self.priceMap objectForKey:self.jjSliderView.currentValueStr]];
        }else{
            
            //默认年限价格，服务年限不可选
            self.priceLab.text = [NSString stringWithFormat:@"¥%@",[self.priceMap objectForKey:self.service_year_length]];
        }
        
        //重设畅行无忧价格 畅行无忧价格赛选条件: 先根据 速度级别列表 查询畅行无忧价格表 然后 查询对应服务年限 对应畅行无忧数量的价格
        if (self.cxwyPriceMap.count<=0|| self.stepper2.value<=0) {
            
            
        }else{
            NSString *newCxwyPrice = self.cxwyPriceMap[self.jjSliderView.currentValueStr][[NSString stringWithFormat:@"%.0f",self.stepper2.value]];
            self.cxwyPrice.text = newCxwyPrice;
        }
        
        //选中色
        SelectBuyTireInfoCell *cell = (SelectBuyTireInfoCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.titleLab.textColor = LOGINBACKCOLOR;
        cell.titleLab.layer.borderColor = LOGINBACKCOLOR.CGColor;
        cell.titleLab.backgroundColor = [LOGINBACKCOLOR colorWithAlphaComponent:0.1];
    }
    
    
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //取消选中色
    SelectBuyTireInfoCell *cell =   (SelectBuyTireInfoCell *) [collectionView cellForItemAtIndexPath:indexPath];
    cell.titleLab.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.titleLab.textColor = [UIColor blackColor];
    cell.titleLab.backgroundColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  CompleteViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/7/2.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "CompleteViewController.h"
#import "ToDeliveryView.h"
#import "FirstUpdateOrFreeChangeInfo.h"
#import "StoreDetailsViewController.h"
#import "TopayBottomView.h"
#import "ShoeOrderVo.h"
#import "TobepayInfo.h"
#import "ToserviceStoreTableViewCell.h"
#import "ToDeliveryTableViewCell.h"
#import "MyWebViewController.h"
#import <Masonry.h>
#import "JJShare.h"
@interface CompleteViewController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>{
    
    id shareData;//红包分享数据
    BOOL commodityRedBag;
}

@property(nonatomic, strong)UIScrollView *mainScrollV;
@property(nonatomic, strong)ToDeliveryView *todeliveryView;
@property(nonatomic, strong)UITableView *toCompleteTableview;
@property(nonatomic, strong)NSMutableArray *TireNumberOrStoreMutableA;
@property(nonatomic, strong)TopayBottomView *topayBottomView;
@property(nonatomic, strong)UIButton *submitBtn;

@property(nonatomic, strong)UIButton *redEnvelopeBtn;//红包按钮 特定页面显示
//@property(nonatomic, weak)id shareData;//红包分享数据


@property(nonatomic, strong)ShoeOrderVo *shoeOrdervo;
@property(nonatomic, strong)TobepayInfo *tobepayInfo;
@property(nonatomic, strong)FirstUpdateOrFreeChangeInfo *firstUpdateInfo;

@end

@implementation CompleteViewController
@synthesize titleStr;
@synthesize orderTypeStr;
@synthesize orderNoStr;
@synthesize addRightFlageStr;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = titleStr;
    
    if ([addRightFlageStr isEqualToString:@"1"]) {
        
        [self addRightBtn];
    }
    [self addViews];
    [self getUserOrderInfoByNoAndType];
}

- (void)addViews{
    
    [self.view addSubview:self.mainScrollV];
    [self.mainScrollV addSubview:self.todeliveryView];
    
    if ([orderTypeStr isEqualToString:@"0"]) {
        
        [self.mainScrollV addSubview:self.topayBottomView];
    }
    
    [self.view addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.mas_equalTo(self.view).inset(10);
        make.height.mas_equalTo(34);
        if (@available(iOS 11.0, *)) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.view.mas_bottom);
        }
    }];
    
    if ([orderTypeStr isEqualToString:@"2"] && [titleStr isEqualToString:@"交易完成"]) {

        //2018666 测试用订单号
        [self getFirstChangeShareData:orderNoStr];
    }else if ([orderTypeStr isEqualToString:@"1"] && [titleStr isEqualToString:@"交易完成"]){
        
        [self getCommodityOrderShareData:orderNoStr];
    }else{
        
    }
}


- (void)addRightBtn{
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
    rightBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14];
    [rightBtn setTitle:@"退款" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(chickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIView *rightBtnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rightBtn.frame.size.width, rightBtn.frame.size.height)];
    [rightBtnView addSubview:rightBtn];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtnView];
    self.navigationItem.rightBarButtonItem = barButton;
}


#pragma mark ButtonClickEvent
- (void)chickDeliveryStoreNameBtn:(UIButton *)button{
    
    StoreDetailsViewController *storeDetialVC = [[StoreDetailsViewController alloc] init];
    storeDetialVC.storeID = [NSString stringWithFormat:@"%@", self.firstUpdateInfo.storeId];
    [self.navigationController pushViewController:storeDetialVC animated:YES];
}

-(void)shareRedEnvelopeBtnEvent:(UIButton *)sender{
    
    if (shareData && shareData != [NSNull null]) {

        if (commodityRedBag) {
            
            NSDictionary *dic = shareData[@"inviteRegister"];
            NSString *shareURL = [NSString stringWithFormat:@"%@?userId=%@",dic[@"shareUrl"],[UserConfig user_id]];
            
            MyWebViewController *webview = [[MyWebViewController alloc] init];
            
            webview.url = [NSString stringWithFormat:@"%@?userId=%@",dic[@"url"],[UserConfig user_id]];
            
            [webview activityInfoWithShareType:shareStatusAble shareText:dic[@"shareTitle"] shareUrl:shareURL];
            
            [self.navigationController pushViewController:webview animated:YES];
            self.hidesBottomBarWhenPushed = YES;
        }else{
            
            [JJShare ShareDescribe:[shareData objectForKey:@"body"] images:@[[UIImage imageNamed:@"icon"]] url:[shareData objectForKey:@"redpacketUrl"] title:[shareData objectForKey:@"title"] type:SSDKContentTypeAuto];
        }
    }
}

- (void)chickRightBtn:(UIButton *)button{
    
    NSString *hostStr = @"";
    if ([orderTypeStr isEqualToString:@"0"]) {
        
        hostStr = @"refundShoeCxwyOrder";
    }else{
        hostStr = @"refundStockOrder";
    }
    
    NSDictionary *refundPostDic = @{@"orderNo":orderNoStr, @"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]]};
    NSString *reqJson = [PublicClass convertToJsonData:refundPostDic];
    [JJRequest postRequest:hostStr params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
            self.backTobeReplaceBlock(@"update");
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"退款轮胎购买订单或商品订单错误:%@", error);
    }];
}

#pragma mark viewData
-(void)getFirstChangeShareData:(NSString *)orderNO{
    
    NSData *baseOrderNO = [orderNO dataUsingEncoding:NSUTF8StringEncoding];
    NSString *orderNumber = [baseOrderNO base64EncodedStringWithOptions:(NSDataBase64Encoding64CharacterLineLength)];
    [JJRequest interchangeableGetRequest:[NSString stringWithFormat:@"http://activity.qdxmjj.com:8888/wechat/appGetRedPacketInfo?orderInfo=%@",orderNumber] params:nil success:^(id  _Nullable data) {
        
        NSLog(@"%@",data);
        //调用分享集成界面
        
        if (data && data != [NSNull null]) {
            
            if ([[data objectForKey:@"status"] longLongValue] ==1) {
                
                [self.view addSubview:self.redEnvelopeBtn];
                [self.redEnvelopeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.right.mas_equalTo(self.view.mas_right).inset(10);
                    make.width.and.height.mas_equalTo(60);
                    make.bottom.mas_equalTo(self.submitBtn.mas_top).inset(20);
                }];
                
                shareData = data;
            }
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

-(void)getCommodityOrderShareData:(NSString *)orderNO{
    
    [JJRequest interchangeablePostRequestWithIP:SHAREIP path:@"invite/Url" params:nil success:^(id  _Nullable data) {
        
        if (data == NULL || [data isEqual:[NSNull null]] || !data || data == nil) {
            
            return ;
        }
        
        [self.view addSubview:self.redEnvelopeBtn];
        [self.redEnvelopeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(self.view.mas_right).inset(10);
            make.width.and.height.mas_equalTo(60);
            make.bottom.mas_equalTo(self.submitBtn.mas_top).inset(20);
        }];

        shareData = data;
        commodityRedBag = YES;
    } failure:^(NSError * _Nullable error) {
        
    }];
    
}
- (void)getUserOrderInfoByNoAndType{
    
    NSDictionary *postDic = @{@"orderNo":orderNoStr, @"orderType":orderTypeStr, @"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]]};
    NSString *reqJson = [PublicClass convertToJsonData:postDic];
    [JJRequest postRequest:@"getUserOrderInfoByNoAndType" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
            NSLog(@"%@", data);
            [self analySizeData:data];
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } failure:^(NSError * _Nullable error) {
        
        NSLog(@"所有订单详情中查询用户订单详情错误:%@", error);
    }];
}

- (void)analySizeData:(NSDictionary *)dataDic{
    
    [self.firstUpdateInfo setValuesForKeysWithDictionary:dataDic];
    [self.tobepayInfo setValuesForKeysWithDictionary:dataDic];
    if (![self.firstUpdateInfo.shoeOrderVoList isEqual:@[]]) {
        
        [self.shoeOrdervo setValuesForKeysWithDictionary:[[dataDic objectForKey:@"shoeOrderVoList"] objectAtIndex:0]];
    }
    
    if (self.firstUpdateInfo.firstChangeOrderVoList != NULL) {
        
        NSArray *dataArray = [dataDic objectForKey:@"firstChangeOrderVoList"];
        for (int i = 0; i<dataArray.count; i++) {
            
            NSDictionary *dic = [dataArray objectAtIndex:i];
            TireChaneOrderInfo *tireInfo = [[TireChaneOrderInfo alloc] init];
            [tireInfo setValuesForKeysWithDictionary:dic];
            [self.TireNumberOrStoreMutableA addObject:tireInfo];
        }
    }
    
    if (self.firstUpdateInfo.freeChangeOrderVoList != NULL) {
        
        NSArray *dataArray = [dataDic objectForKey:@"freeChangeOrderVoList"];
        for (int i = 0; i<dataArray.count; i++) {
            
            NSDictionary *dic = [dataArray objectAtIndex:i];
            TireChaneOrderInfo *tireInfo = [[TireChaneOrderInfo alloc] init];
            [tireInfo setValuesForKeysWithDictionary:dic];
            [self.TireNumberOrStoreMutableA addObject:tireInfo];
        }
    }
    
    if (![self.firstUpdateInfo.stockOrderVoList isEqual:@[]]) {
        
        NSArray *stockArray = [dataDic objectForKey:@"stockOrderVoList"];
        for (int p = 0; p<stockArray.count; p++) {
            
            NSDictionary *dic = [stockArray objectAtIndex:p];
            StockOrderVoInfo *stockVoInfo = [[StockOrderVoInfo alloc] init];
            [stockVoInfo setValuesForKeysWithDictionary:dic];
            [self.TireNumberOrStoreMutableA addObject:stockVoInfo];
        }
    }
    
    if (![orderTypeStr isEqualToString:@"0"]) {
        
        [_mainScrollV addSubview:self.toCompleteTableview];
        [_mainScrollV setContentSize:CGSizeMake(MAINSCREEN.width, self.toCompleteTableview.frame.size.height + self.toCompleteTableview.frame.origin.y)];
    }else{
        
        [_mainScrollV setContentSize:CGSizeMake(MAINSCREEN.width, self.topayBottomView.frame.size.height + self.topayBottomView.frame.origin.y)];
    }
    
    [self setdatatoViews];
}

- (void)setdatatoViews{
    
    [_todeliveryView setDatatoDeliveryViews:self.firstUpdateInfo];
    [_topayBottomView setTopayBottomViewData:self.shoeOrdervo tobePayinfo:self.tobepayInfo];
}

#pragma mark UITableViewDelegate and UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.TireNumberOrStoreMutableA.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.firstUpdateInfo.firstChangeOrderVoList == NULL && self.firstUpdateInfo.freeChangeOrderVoList == NULL) {
        
        static NSString *reuseIndentifier = @"storeCell";
        ToserviceStoreTableViewCell *storeCell = [tableView dequeueReusableCellWithIdentifier:reuseIndentifier];
        if (storeCell == nil) {
            
            storeCell = [[ToserviceStoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIndentifier];
            storeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        StockOrderVoInfo *stockOrderInfo = [self.TireNumberOrStoreMutableA objectAtIndex:indexPath.row];
        [storeCell setdatatoCellViews:stockOrderInfo];
        return storeCell;
    }else{
        
        static NSString *reuseIndentifier = @"cell";
        ToDeliveryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIndentifier];
        if (cell == nil) {
            
            cell = [[ToDeliveryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIndentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        TireChaneOrderInfo *tireInfo = [self.TireNumberOrStoreMutableA objectAtIndex:indexPath.row];
        [cell setdatatoCellViews:tireInfo img:self.firstUpdateInfo.orderImg];
        return cell;
    }
}


#pragma mark SetUIFrame
- (UIScrollView *)mainScrollV{
    
    if (_mainScrollV == nil) {
        
        _mainScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height - SafeDistance - 40)];
        _mainScrollV.bounces = NO;
        _mainScrollV.showsVerticalScrollIndicator = NO;
        _mainScrollV.showsHorizontalScrollIndicator = NO;
        _mainScrollV.delegate = self;
        _mainScrollV.scrollsToTop = NO;
        _mainScrollV.tag = 2;
    }
    return _mainScrollV;
}

- (ToDeliveryView *)todeliveryView{
    
    if (_todeliveryView == nil) {
        
        _todeliveryView = [[ToDeliveryView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, 190)];
        [_todeliveryView.storeNameBtn addTarget:self action:@selector(chickDeliveryStoreNameBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _todeliveryView;
}
- (UITableView *)toCompleteTableview{
    
    if (_toCompleteTableview == nil) {
        
        _toCompleteTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 190, MAINSCREEN.width, self.TireNumberOrStoreMutableA.count*150) style:UITableViewStylePlain];
        _toCompleteTableview.delegate = self;
        _toCompleteTableview.dataSource = self;
        _toCompleteTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _toCompleteTableview.bounces = NO;
    }
    return _toCompleteTableview;
}

- (TopayBottomView *)topayBottomView{
    
    if (_topayBottomView == nil) {
        
        _topayBottomView = [[TopayBottomView alloc] initWithFrame:CGRectMake(0, 190, MAINSCREEN.width, 200)];
    }
    return _topayBottomView;
}

- (ShoeOrderVo *)shoeOrdervo{
    
    if (_shoeOrdervo == nil) {
        
        _shoeOrdervo = [[ShoeOrderVo alloc] init];
    }
    return _shoeOrdervo;
}

- (TobepayInfo *)tobepayInfo{
    
    if (_tobepayInfo == nil) {
        
        _tobepayInfo = [[TobepayInfo alloc] init];
    }
    return _tobepayInfo;
}

- (UIButton *)submitBtn{
    
    if (_submitBtn == nil) {
        
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.userInteractionEnabled = NO;
        _submitBtn.layer.cornerRadius = 17.f;
        _submitBtn.layer.masksToBounds = YES;
        [_submitBtn setTitle:titleStr forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    return _submitBtn;
}

-(UIButton *)redEnvelopeBtn{
    
    if (!_redEnvelopeBtn) {
        
        _redEnvelopeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_redEnvelopeBtn setBackgroundImage:[UIImage imageNamed:@"ic_hb"] forState:UIControlStateNormal];
        [_redEnvelopeBtn addTarget:self action:@selector(shareRedEnvelopeBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _redEnvelopeBtn;
}

- (FirstUpdateOrFreeChangeInfo *)firstUpdateInfo{
    
    if (_firstUpdateInfo == nil) {
        
        _firstUpdateInfo = [[FirstUpdateOrFreeChangeInfo alloc] init];
    }
    return _firstUpdateInfo;
}

- (NSMutableArray *)TireNumberOrStoreMutableA{
    
    if (_TireNumberOrStoreMutableA == nil) {
        
        _TireNumberOrStoreMutableA = [[NSMutableArray alloc] init];
    }
    return _TireNumberOrStoreMutableA;
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

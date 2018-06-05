//
//  StoreDetailsViewController.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/4.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "StoreDetailsViewController.h"
#import "StoreDetailsRequest.h"
#import "StoreHeadView.h"
#import <SDCycleScrollView.h>
#import <Masonry.h>
#import "UIView+extension.h"
@interface StoreDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSDictionary *dataDic;

@property(nonatomic,strong)UIScrollView *mainScrollView;

@property(nonatomic,strong)UILabel *contactPhone;

@property(nonatomic,strong)SDCycleScrollView *CycleView;

@property(nonatomic,strong)StoreHeadView *storeHeadView;

@property(nonatomic,strong)UILabel *storeTitle;

@property(nonatomic,strong)UILabel *storeContent;

@property(nonatomic,strong)UITableView *assessTableView;

@end

@implementation StoreDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"门店首页";
    
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.contactPhone];
    [self.mainScrollView addSubview:self.CycleView];
    [self.mainScrollView addSubview:self.storeHeadView];
    [self.mainScrollView addSubview:self.storeTitle];
    [self.mainScrollView addSubview:self.storeContent];
    
    [self setFrame];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"assessCellID" forIndexPath:indexPath];
    
    
    return cell;
}

-(void)setFrame{
    
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.bottom.mas_equalTo(self.view);
    }];
    
    [self.storeHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.CycleView.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(@100);
        
    }];

    [self.contactPhone mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.storeHeadView.mas_bottom).inset(2);
        make.height.mas_equalTo(@50);
        
    }];
    
    [self.storeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.contactPhone.mas_bottom).inset(2);
        make.height.mas_equalTo(@45);
        
    }];
    
    [self.storeContent mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.storeTitle.mas_bottom);
        make.height.mas_equalTo(@45);
        
    }];

    [self.assessTableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.storeContent.mas_bottom).inset(2);
        make.left.and.right.mas_equalTo(self.view);
        make.height.mas_equalTo(@200);
        
    }];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    CGFloat h = self.CycleView.height+self.storeHeadView.height+self.contactPhone.height+2+self.storeTitle.height+self.storeContent.height+2+self.assessTableView.height+2;
    
    self.mainScrollView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), h);
    
}


-(UIScrollView *)mainScrollView{
    
    if (!_mainScrollView) {
        
        _mainScrollView = [[UIScrollView alloc] init];
        _mainScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)*1.5);
        _mainScrollView.alwaysBounceVertical = YES;
        _mainScrollView.showsVerticalScrollIndicator=NO;
        _mainScrollView.showsHorizontalScrollIndicator=NO;

        _mainScrollView.backgroundColor = [UIColor colorWithRed:230.f/255.f green:230.f/255.f blue:230.f/255.f alpha:1.f];
    }
    
    return _mainScrollView;
}

-(SDCycleScrollView*)CycleView{
    if (_CycleView==nil) {
        
        _CycleView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 150) shouldInfiniteLoop:YES imageNamesGroup:@[@"ic_banner_2",@"ic_banner"]];
        _CycleView.infiniteLoop=YES;
        _CycleView.autoScroll=YES;
        _CycleView.showPageControl=YES;
        
        _CycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _CycleView.pageControlStyle=SDCycleScrollViewPageContolStyleAnimated;
    }

    return _CycleView;
}

-(StoreHeadView *)storeHeadView{
    
    if (!_storeHeadView) {
        
        _storeHeadView = [[StoreHeadView alloc] init];
        _storeHeadView.backgroundColor = [UIColor whiteColor];
    }
    
    
    return _storeHeadView;
}

-(UILabel *)contactPhone{
    
    if (!_contactPhone) {
        
        _contactPhone = [[UILabel alloc] init];
        _contactPhone.backgroundColor = [UIColor whiteColor];
        _contactPhone.text = @"联系电话";
        _contactPhone.textColor = [UIColor blackColor];
    }
    return _contactPhone;
}

-(UILabel *)storeTitle{
    
    if (!_storeTitle) {
        
        _storeTitle = [[UILabel alloc] init];
        _storeTitle.backgroundColor = [UIColor whiteColor];
        _storeTitle.text = @"门店概况";
        _storeTitle.textColor = [UIColor blackColor];
        _storeTitle.font = [UIFont systemFontOfSize:18.f];
    }
    return _storeTitle;
}

-(UILabel *)storeContent{
    
    if (!_storeContent) {
        
        _storeContent = [[UILabel alloc] init];
        _storeContent.backgroundColor = [UIColor whiteColor];
        _storeContent.text = @"123456789";
        _storeContent.font = [UIFont systemFontOfSize:14.f];
    }
    return _storeContent;
}

-(UITableView *)assessTableView{
    
    if (!_assessTableView) {
        
        _assessTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _assessTableView.delegate = self;
        _assessTableView.dataSource = self;
        [_assessTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"assessCellID"];
    }
    
    
    return _assessTableView;
}


-(void)setStoreID:(NSString *)storeID{
    
    if (storeID == nil ||storeID.length<=0) {
        return;
    }
    
    [StoreDetailsRequest getStoreInfoByStoreIdWithInfo:@{@"storeId":storeID} succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if ([data isKindOfClass:[NSDictionary class]]) {
            
            self.dataDic = data;
        }
        
        NSLog(@"%@",data);
        
    } failure:^(NSError * _Nullable error) {
                                                                                                                                                  
    }];
}

-(NSDictionary *)dataDic{
    
    if (!_dataDic) {
        
        _dataDic = [NSDictionary dictionary];
    }
    
    return _dataDic;
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

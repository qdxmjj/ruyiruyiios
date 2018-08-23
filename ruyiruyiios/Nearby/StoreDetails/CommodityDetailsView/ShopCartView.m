//
//  ShopCartView.m
//  TestCommodityInfo
//
//  Created by 小马驾驾 on 2018/5/31.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "ShopCartView.h"
#import <Masonry.h>
#import "ShopCartTableViewCell.h"
@interface ShopCartView ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIButton *removeMptyBtn;

@end

@implementation ShopCartView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:.3f];
        
        [self addSubview:self.tableView];
        [self addSubview:self.removeMptyBtn];

        [self.removeMptyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.mas_equalTo(self.tableView.mas_right).inset(10);
            make.bottom.mas_equalTo(self.tableView.mas_top).inset(3);
            make.height.mas_equalTo(@20);
            make.width.mas_equalTo(@20);
        }];
        
    }
    return self;
}

-(void)reloadTableView{
    
    [self.tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.commodityList.count>0) {
        
        return self.commodityList.count;
        
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShopCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shopCartCellID" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CommodityModel *model = [[CommodityModel alloc] init];
    
    [model setValuesForKeysWithDictionary:self.commodityList[indexPath.row]];
    
    [cell setShopCartModel:model];
 
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    return UITableViewAutomaticDimension;
}



-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.estimatedRowHeight = 55;
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ShopCartTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"shopCartCellID"];;
    }
    return _tableView;
}

-(UIButton *)removeMptyBtn{
    
    if (!_removeMptyBtn) {
        
        _removeMptyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_removeMptyBtn setImage:[UIImage imageNamed:@"ic_delete"] forState:UIControlStateNormal];
        [_removeMptyBtn setBackgroundColor:[UIColor whiteColor]];
        [_removeMptyBtn addTarget:self action:@selector(removeShopCartContentWithAll) forControlEvents:UIControlEventTouchUpInside];
    }
    return _removeMptyBtn;
}

-(void)removeShopCartContentWithAll{
    
    self.removeBlock(YES);
}

-(void)setCommodityList:(NSArray *)commodityList{
    
    _commodityList = commodityList;
    if (_commodityList.count<=5) {
        
        self.tableView.frame = CGRectMake(0, self.frame.size.height-_commodityList.count*44, self.frame.size.width, _commodityList.count*44);
    }else{
        
        self.tableView.frame = CGRectMake(0, self.frame.size.height-5*44, self.frame.size.width, 5*44);
    }
    

    [self.tableView reloadData];
}

@end

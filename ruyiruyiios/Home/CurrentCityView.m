//
//  CurrentCityView.m
//  ruyiruyiios
//
//  Created by 姚永敏 on 2018/10/24.
//  Copyright © 2018 ruyiruyi. All rights reserved.
//

#import "CurrentCityView.h"
#import "PopularCityCell.h"
#import <Masonry.h>
#import "FMDBPosition.h"
@interface CurrentCityView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong)UILabel *cityLab;
@property(nonatomic, strong)UIButton *switchBtn;
@property(nonatomic, strong)UICollectionView *countyCollectionView;//热门城市列表
@end
@implementation CurrentCityView

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {

        [self addSubview:self.cityLab];
        [self addSubview:self.switchBtn];
        [self addSubview:self.countyCollectionView];

        [self setSubViewsFrame];
    }
    return self;
}

-(void)setDataList:(NSArray *)dataList{
    _dataList = dataList;
    
    [self.countyCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo((dataList.count/3 + (dataList.count % 3 == 0? 0 :1))*50);
    }];
    
    [self.countyCollectionView reloadData];
}

-(void)setSelectCityStr:(NSString *)selectCityStr{
    
    self.cityLab.text = [NSString stringWithFormat:@"当前选择城市：%@",selectCityStr];
}

-(void)setSubViewsFrame{
    
    [self.cityLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.mas_top).inset(5);
        make.left.mas_equalTo(self.mas_left).inset(16);
        make.height.mas_equalTo(25);
    }];
    
    [self.switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.mas_top).inset(5);
        make.right.mas_equalTo(self.mas_right).inset(16);
        make.height.mas_equalTo(25);
    }];
    
    [self.countyCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.cityLab.mas_bottom).inset(5);
        make.left.and.right.mas_equalTo(self).inset(16);
        make.height.mas_equalTo(0);
    }];
    
}

-(UILabel *)cityLab{
    if (!_cityLab) {
        
        _cityLab = [[UILabel alloc] init];
        _cityLab.text = [NSString stringWithFormat:@"当前选择城市：%@",[UserConfig selectCityName]];
    }
    return _cityLab;
}

-(UIButton *)switchBtn{
    if (!_switchBtn) {
        
        _switchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_switchBtn setTitle:@"切换县区" forState:UIControlStateNormal];
        [_switchBtn.titleLabel setFont:[UIFont systemFontOfSize:13.f]];
        [_switchBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_switchBtn addTarget:self action:@selector(foldCountyListEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _switchBtn;
}

-(UICollectionView *)countyCollectionView{
    
    if (!_countyCollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _countyCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _countyCollectionView.delegate = self;
        _countyCollectionView.dataSource = self;
        _countyCollectionView.backgroundColor = [UIColor whiteColor];
        [_countyCollectionView registerClass:[PopularCityCell class] forCellWithReuseIdentifier:@"CurrentCityCellID"];
    }
    return _countyCollectionView;
}

-(void)foldCountyListEvent:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    
    self.viewStatus = !self.viewStatus;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(refreshSuperViewFrameWithStatus:)]) {
        
        [self.delegate refreshSuperViewFrameWithStatus:self.viewStatus];
    }else{
        NSLog(@"错误");
    }
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    PopularCityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentCityCellID" forIndexPath:indexPath];
    
    FMDBPosition *position = _dataList[indexPath.row];
    
    cell.cityNameLab.text = position.name;
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (self.dataList.count>0) {
        
        return self.dataList.count;
    }
    return 0;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(collectionView.frame.size.width/3 - 10, 40);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    //间距5 collectionView高度50 cell 高度40
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FMDBPosition *position = _dataList[indexPath.row];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectCurrentWithName:)]) {
        
        [self.delegate selectCurrentWithName:position.name];
    }else{
        NSLog(@"错误");
    }
    
    
}


@end

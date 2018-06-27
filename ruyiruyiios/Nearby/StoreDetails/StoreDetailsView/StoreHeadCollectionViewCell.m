//
//  StoreHeadCollectionViewCell.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/6.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "StoreHeadCollectionViewCell.h"
#import <Masonry.h>
@implementation StoreHeadCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _itemLab = [[UILabel alloc] init];
        _itemLab.layer.cornerRadius = 5;
        _itemLab.layer.masksToBounds = YES;
        [self.contentView addSubview:_itemLab];
    
        [_itemLab mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.bottom.mas_equalTo(self.contentView);
            make.left.right.mas_equalTo(self.contentView);
            
        }];
        
    }
    
    return self;
}

-(UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    CGSize size = [self.contentView systemLayoutSizeFittingSize:layoutAttributes.size];
    
    CGRect cellFrame = layoutAttributes.frame;
    
    
    cellFrame.size.height = size.height;
    
    layoutAttributes.frame = cellFrame;
    
    
    return layoutAttributes;
}

@end

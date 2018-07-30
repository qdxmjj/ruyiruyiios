//
//  HeadView.m
//  TestCommodityInfo
//
//  Created by 小马驾驾 on 2018/5/30.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "HeadView.h"
#import "UIView+extension.h"
@interface HeadView ()

@end

@implementation HeadView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRed:255.f/255.f green:102.f/255.f blue:35.f/255.f alpha:1.f];
        
        [self addSubview:self.backBtn];
        [self addSubview:self.storeImg];
        [self addSubview:self.storeName];
        [self addSubview:self.itemBtn];
    }
    return self;
}

-(UIButton *)backBtn{
    
    if (!_backBtn) {
        
        
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"ic_back"] forState:UIControlStateNormal];
        [_backBtn setFrame:CGRectMake(10, 20, 30, 50)];
    }
    
    
    return _backBtn;
}

#pragma mark 这就是屎一样的代码，有时间一定要修改
-(void)setServiceTypeList:(NSArray *)serviceTypeList{
    
    if (serviceTypeList.count>0) {
        
        for (int i=0; i<serviceTypeList.count; i++) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [btn setTitle:[[serviceTypeList[i] objectForKey:@"service"]objectForKey:@"name"] forState:UIControlStateNormal];
            
            [btn setTitleColor:[PublicClass colorWithHexString:[[serviceTypeList[i] objectForKey:@"service"]objectForKey:@"color"]] forState:UIControlStateNormal];
            
            [btn setBackgroundColor:[UIColor whiteColor]];
            
            CGFloat btnY ;
            CGFloat btnX;
            if (i<3) {
                
                btnY = self.storeName.bottom+10;
                btnX = ((self.width - self.storeImg.right-10)/3)*i+self.storeImg.right+10;
                
            }else{
                
                btnY = self.storeName.bottom+10+20+5;
                int n = i-3;
                btnX = ((self.width - self.storeImg.right-10)/3)*n+self.storeImg.right+10;
            }
            
            [btn setFrame:CGRectMake(btnX, btnY, (self.width-self.storeImg.right-40)/3, 20)];
            
            [btn.titleLabel setFont:[UIFont systemFontOfSize:13.f]];
            btn.layer.cornerRadius = 3;
            btn.layer.masksToBounds = YES;
            [self addSubview:btn];
        }
    }
}


-(UIImageView *)storeImg{
    
    if (!_storeImg) {
        
        
        _storeImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.backBtn.bottom+5, self.frame.size.width/5, self.frame.size.width/5)];
        _storeImg.backgroundColor = [UIColor orangeColor];
        
    }
    
    return _storeImg;
}

-(UILabel *)storeName{
    
    if (!_storeName) {
        
        _storeName = [[UILabel alloc] initWithFrame:CGRectMake(self.storeImg.right+10, self.storeImg.top, self.frame.size.width-self.storeImg.right-10-50, self.storeImg.height/3-10)];
        _storeName.textColor = [UIColor whiteColor];
        
    }
    return _storeName;
}

-(UIButton *)itemBtn{
    
    if (!_itemBtn) {
        
        _itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_itemBtn setImage:[UIImage imageNamed:@"ic_bai"] forState:UIControlStateNormal];
        [_itemBtn setFrame:CGRectMake(self.width-40-10, self.storeImg.top-10, 40, 30)];
    }
    return _itemBtn;
}
@end

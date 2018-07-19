//
//  FreeChangHeaderView.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/7/4.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "FreeChangHeaderView.h"
#import <Masonry.h>
@interface FreeChangHeaderView ()

@property(nonatomic,strong)UILabel *promptLab;

@property(nonatomic,strong)UILabel *titleLab;

@property(nonatomic,strong)UIImageView *img1;

@property(nonatomic,strong)UILabel *contentLab1;

@property(nonatomic,strong)UIImageView *img2;

@property(nonatomic,strong)UILabel *contentLab2;

@end

@implementation FreeChangHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    self.backgroundColor = [UIColor whiteColor];
//    [self addSubview:self.promptLab];
    [self addSubview:self.titleLab];
    [self addSubview:self.contentLab1];
    [self addSubview:self.contentLab2];
    [self addSubview:self.img1];
    [self addSubview:self.img2];

    [self setupLayout];
}

-(void)setupLayout{
    
//    [self.promptLab mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.mas_equalTo(self.mas_top);
//        make.left.and.right.mas_equalTo(self);
//        make.height.mas_equalTo(self.mas_height).multipliedBy(0.3);
//    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.mas_left).inset(16);
        make.height.mas_equalTo(@20);
        make.top.mas_equalTo(self.mas_top).inset(10);
    }];
    
    [self.img1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.mas_left).inset(16);
        make.width.and.height.mas_equalTo(CGSizeMake(20, 20));
        make.top.mas_equalTo(self.titleLab.mas_bottom).inset(10);
    }];
    
    [self.contentLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.img1.mas_right).inset(5);
        make.centerY.mas_equalTo(self.img1.mas_centerY);
        make.height.mas_equalTo(@20);
    }];
    
    [self.img2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.mas_left).inset(16);
        make.width.and.height.mas_equalTo(CGSizeMake(20, 20));
        make.top.mas_equalTo(self.img1.mas_bottom).inset(10);
        
    }];
    
    [self.contentLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.img2.mas_right).inset(5);
        make.centerY.mas_equalTo(self.img2.mas_centerY);
        make.height.mas_equalTo(@20);
    }];
}

-(UILabel *)promptLab{
    
    if (!_promptLab) {
        
        _promptLab = [[UILabel alloc] init];
        
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        // 对齐方式
        style.alignment = NSTextAlignmentJustified;
        // 首行缩进
        style.firstLineHeadIndent = 10.0f;
        // 头部缩进
        style.headIndent = 10.0f;
        // 尾部缩进
        style.tailIndent = -10.0f;
        NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:@"温馨提示：以下更换轮胎的规则请您认真阅读，可以帮助您更好的使用我们的产品与服务" attributes:@{ NSParagraphStyleAttributeName : style}];
        _promptLab.attributedText = attrText;
        _promptLab.backgroundColor = [PublicClass colorWithHexString:@"#ececec"];
        _promptLab.font = [UIFont systemFontOfSize:15.f];
        _promptLab.textAlignment = NSTextAlignmentLeft;
        _promptLab.font = [UIFont fontWithName:TEXTFONT size:12.0];
        _promptLab.textColor = TEXTCOLOR64;
        _promptLab.numberOfLines = 0;
    }
    return _promptLab;
}

-(UILabel *)titleLab{
    
    if (!_titleLab) {
        
        _titleLab = [[UILabel alloc] init];
        _titleLab.text = @"免费再换标准";
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _titleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab;
}

-(UIImageView *)img1{
    
    if (!_img1) {
        
        _img1 = [[UIImageView alloc] init];
        _img1.image = [UIImage imageNamed:@"ic_check"];
    }
    return _img1;
}

-(UIImageView *)img2{
    
    if (!_img2) {
        
        _img2 = [[UIImageView alloc] init];
        _img2.image = [UIImage imageNamed:@"ic_check"];
    }
    return _img2;
}

-(UILabel *)contentLab1{
    
    if (!_contentLab1) {
        
        _contentLab1 = [[UILabel alloc] init];
        _contentLab1.text = @"轮胎花纹均匀磨损到磨耗标志";
        _contentLab1.textColor = TEXTCOLOR64;
        _contentLab1.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _contentLab1.textAlignment = NSTextAlignmentLeft;
    }
    return _contentLab1;
}

-(UILabel *)contentLab2{
    
    if (!_contentLab2) {
        
        _contentLab2 = [[UILabel alloc] init];
        _contentLab2.text = @"安装之日起，使用时间达到五年";
        _contentLab2.textColor = TEXTCOLOR64;
        _contentLab2.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _contentLab2.textAlignment = NSTextAlignmentLeft;
    }
    return _contentLab2;
}
@end

//
//  MyCodeView.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/21.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "MyCodeView.h"
#import <UIImageView+WebCache.h>

@implementation MyCodeView

- (UIImageView *)headImageV{
    
    if (_headImageV == nil) {
        
        _headImageV = [[UIImageView alloc] init];
    }
    return _headImageV;
}

- (UILabel *)nameLabel{
    
    if (_nameLabel == nil) {
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _nameLabel.textColor = TEXTCOLOR64;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}

- (UIImageView *)sexImageV{
    
    if (_sexImageV == nil) {
        
        _sexImageV = [[UIImageView alloc] init];
    }
    return _sexImageV;
}

- (UILabel *)phoneLabel{
    
    if (_phoneLabel == nil) {
        
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        _phoneLabel.textColor = TEXTCOLOR64;
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _phoneLabel;
}

- (UIImageView *)codeImageV{
    
    if (_codeImageV == nil) {
        
        _codeImageV = [[UIImageView alloc] init];
    }
    return _codeImageV;
}

- (UIImageView *)midImageV{
    
    if (_midImageV == nil) {
        
        _midImageV = [[UIImageView alloc] init];
    }
    return _midImageV;
}

- (UILabel *)contentLabel{
    
    if (_contentLabel == nil) {
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont fontWithName:TEXTFONT size:10.0];
        _contentLabel.textColor = TEXTCOLOR64;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _contentLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addViews];
    }
    return self;
}

- (void)addViews{
    
    [self addSubview:self.headImageV];
    [self addSubview:self.nameLabel];
    [self addSubview:self.sexImageV];
    [self addSubview:self.phoneLabel];
    [self addSubview:self.codeImageV];
    [self addSubview:self.midImageV];
    [self addSubview:self.contentLabel];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.headImageV.frame = CGRectMake(20, 20, 60, 60);
    self.nameLabel.frame = CGRectMake(90, 25, 60, 20);
    self.sexImageV.frame = CGRectMake(self.nameLabel.frame.size.width + self.nameLabel.frame.origin.x, 22, 25, 25);
    self.phoneLabel.frame = CGRectMake(self.nameLabel.frame.origin.x, 50, MAINSCREEN.width - self.nameLabel.frame.origin.x - 10, 20);
    self.codeImageV.frame = CGRectMake((self.frame.size.width - 180)/2, 140, 180, 180);
    self.midImageV.frame = CGRectMake((self.frame.size.width - 40)/2, self.codeImageV.frame.origin.y+(self.codeImageV.frame.size.width - 40)/2, 40, 40);
    self.contentLabel.frame = CGRectMake(0, self.frame.size.height - 50, self.frame.size.width, 20);
}

- (void)setdatatoViews:(ExtensionInfo *)extensionInfo{
    
    [self.headImageV sd_setImageWithURL:[NSURL URLWithString:[UserConfig headimgurl]]];
    self.nameLabel.text = [UserConfig nick];
    self.phoneLabel.text = [NSString stringWithFormat:@"tel：%@", [UserConfig phone]];
    self.codeImageV.image = [self getCode:extensionInfo.url];
    [self.midImageV sd_setImageWithURL:[NSURL URLWithString:[UserConfig headimgurl]]];
    if ([[UserConfig gender] isEqualToNumber:[NSNumber numberWithInt:1]]) {
        
        self.sexImageV.image = [UIImage imageNamed:@"ic_qr_man"];
    }else{
        
        self.sexImageV.image = [UIImage imageNamed:@"ic_qr_woman"];
    }
    self.contentLabel.text = extensionInfo.content;
}

- (UIImage *)getCode:(NSString *)urlStr{
    
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *data = [urlStr dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    CIImage *outputImage = [filter outputImage];
    UIImage *codeImage = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:200];
    return codeImage;
}

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

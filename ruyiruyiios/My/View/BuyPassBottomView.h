//
//  BuyPassBottomView.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/12.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ClickProtocolEventBlock)(BOOL isClick);

@interface BuyPassBottomView : UIView <UITextViewDelegate>

@property(nonatomic, strong)UIButton *selectBtn;
@property(nonatomic, strong)UIButton *sureBuyBtn;
@property(nonatomic, strong)UILabel *passPriceLabel;
@property(nonatomic, strong)UITextView *agreementTextView;

- (void)setdatatoViews:(NSString *)priceStr;

@property(nonatomic,copy)ClickProtocolEventBlock eventBlock;

@end

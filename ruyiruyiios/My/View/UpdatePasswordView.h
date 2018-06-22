//
//  UpdatePasswordView.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/19.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdatePasswordView : UIView<UITextFieldDelegate>

@property(nonatomic, strong)UITextField *originalTF;
@property(nonatomic, strong)UITextField *newTF;
@property(nonatomic, strong)UITextField *sureNewTF;
@property(nonatomic, strong)NSArray *imgArray;

@end

//
//  TopCarInfoTableViewCell.h
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/18.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopCarInfoTableViewCell : UITableViewCell

@property(nonatomic, strong)UIButton *typeBtn;
@property(nonatomic, strong)UISwitch *ison;
@property(nonatomic, strong)UIButton *platenumBtn;
@property(nonatomic, strong)UIButton *frontBtn;
@property(nonatomic, strong)UIButton *rearBtn;
@property(nonatomic, strong)UIButton *drivingBtn;
@property(nonatomic, strong)UIButton *serviceBtn;
@property(nonatomic, strong)UIView *topView;
@property(nonatomic, strong)UIView *bottomView;
@property(nonatomic, strong)UIButton *selectImgBtn;
@property(nonatomic, strong)UIButton *viceBtn;
@property(nonatomic, strong)UIButton *deleteBtn;
@property(nonatomic, strong)UIButton *residentAreaBtn;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end

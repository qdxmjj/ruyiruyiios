//
//  AboutUsViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/6/19.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "AboutUsViewController.h"
#import "AboutUsHeadView.h"

@interface AboutUsViewController ()<UIScrollViewDelegate>

@property(nonatomic, strong)UIScrollView *mainScrollV;
@property(nonatomic, strong)AboutUsHeadView *aboutUsHeadView;
//@property(nonatomic, strong)UILabel *detailLabel;
@property(nonatomic, strong)UILabel *bottomLabel;

@end

@implementation AboutUsViewController

- (UIScrollView *)mainScrollV{
    
    if (_mainScrollV == nil) {
        
        _mainScrollV = [[UIScrollView alloc] init];
        _mainScrollV.frame = CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height - SafeDistance - 30);
        _mainScrollV.showsVerticalScrollIndicator = NO;
        _mainScrollV.showsHorizontalScrollIndicator = NO;
        _mainScrollV.bounces = NO;
        _mainScrollV.delegate = self;
        _mainScrollV.tag = 2;
        _mainScrollV.scrollsToTop = NO;
        _mainScrollV.backgroundColor = [UIColor whiteColor];
    }
    return _mainScrollV;
}

- (AboutUsHeadView *)aboutUsHeadView{
    
    if (_aboutUsHeadView == nil) {
        
        _aboutUsHeadView = [[AboutUsHeadView alloc] initWithFrame:CGRectMake(0, (MAINSCREEN.height - 170 - SafeDistance)/2, MAINSCREEN.width, 170)];
        _aboutUsHeadView.backgroundColor = [UIColor whiteColor];
    }
    return _aboutUsHeadView;
}

//- (UILabel *)detailLabel{
//
//    if (_detailLabel == nil) {
//
//        _detailLabel = [[UILabel alloc] init];
//        [_detailLabel setNumberOfLines:0];
//        _detailLabel.text = @"\t如驿如意“一次换轮胎 终身免费开”，自此车主再也不用担心爱车轮胎\n\t我们立志于将高性价比且符合中国车主习惯的轮胎推荐给广大车主，从而解决困扰车主的“轮胎贵 换轮胎难”问题；同时，如驿如意用户可以享受免费动平衡、免费四轮定位、免费洗车、免费轮胎换位、免费补贴等超级VIP服务。我们将联合上游供应商和终端服务门店，继续提高实惠、全面的汽车养护服务。\n\t在繁重的生活压力下，我们不仅仅希望能给车主解决轮胎问题！我们更想让车主养车更省钱省心省时间\n\t最后，我们的征途是星辰大海！！！";
//        _detailLabel.textColor = TEXTCOLOR64;
//        _detailLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
//        NSMutableParagraphStyle *paragrephStyle = [[NSMutableParagraphStyle alloc] init];
//        paragrephStyle.lineBreakMode = NSLineBreakByWordWrapping;
//        NSDictionary *attributes = @{NSFontAttributeName:_detailLabel.font, NSParagraphStyleAttributeName:paragrephStyle.copy};
//        CGSize detailSize = [_detailLabel.text boundingRectWithSize:CGSizeMake(MAINSCREEN.width - 40, MAINSCREEN.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
//        [_detailLabel setFrame:CGRectMake(20, 190, detailSize.width, detailSize.height)];
//    }
//    return _detailLabel;
//}

- (UILabel *)bottomLabel{

    if (_bottomLabel == nil) {
        
        _bottomLabel = [[UILabel alloc] init];
        _bottomLabel.frame = CGRectMake(0, MAINSCREEN.height - SafeDistance - 30, MAINSCREEN.width, 20);
        _bottomLabel.text = @"青岛小马驾驾信息科技有限公司 版权所有";
        _bottomLabel.font = [UIFont fontWithName:TEXTFONT size:12.0];
        _bottomLabel.textColor = TEXTCOLOR64;
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _bottomLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
//    self.view.backgroundColor = [PublicClass colorWithHexString:@"#f1f1f1"];
    
    [self.view addSubview:self.mainScrollV];
    [self.view addSubview:self.bottomLabel];
    [self mainScrollAddsubviews];
    // Do any additional setup after loading the view.
}

- (void)mainScrollAddsubviews{
    
    [_mainScrollV addSubview:self.aboutUsHeadView];
//    [_aboutUsHeadView setversionLabelText:@"版本号: V1.0.0" imgStr:@"ic_icon"];
//    [_mainScrollV addSubview:self.detailLabel];
//    if ((self.detailLabel.frame.origin.y+self.detailLabel.frame.size.height)>(MAINSCREEN.height - SafeDistance - 30)) {
//        
//        _mainScrollV.frame = CGRectMake(0, 0, MAINSCREEN.width, MAINSCREEN.height - SafeDistance-30);
//    }else{
//
//    }
//    [_mainScrollV setContentSize:CGSizeMake(MAINSCREEN.width, self.detailLabel.frame.origin.y+self.detailLabel.frame.size.height+20)];
    [self setdatatoViews];
}

- (void)setdatatoViews{

    [self.aboutUsHeadView setversionLabelText:@"版本号: V1.0.0" imgStr:@"ic_icon"];
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

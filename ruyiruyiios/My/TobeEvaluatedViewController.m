//
//  TobeEvaluatedViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/7/2.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "TobeEvaluatedViewController.h"
#import "TobeEvaluateHeadView.h"
#import "HXPhotoView.h"

@interface TobeEvaluatedViewController ()<UITextViewDelegate, HXPhotoViewDelegate>

@property(nonatomic, strong)TobeEvaluateHeadView *tobeHeadView;
@property(nonatomic, strong)UITextView *inputTextV;
@property (strong, nonatomic) HXPhotoManager *manager;
@property(nonatomic, strong)HXPhotoView *photoView;
@property(nonatomic, strong)NSMutableArray *imageMutableA;
@property(nonatomic, strong)UIButton *submitBtn;

@end

@implementation TobeEvaluatedViewController
@synthesize orderNo;
@synthesize storeIdStr;

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
}

- (TobeEvaluateHeadView *)tobeHeadView{
    
    if (_tobeHeadView == nil) {
        
        _tobeHeadView = [[TobeEvaluateHeadView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN.width, 110)];
        [_tobeHeadView setdatatoViews];
    }
    return _tobeHeadView;
}

- (UITextView *)inputTextV{
    
    if (_inputTextV == nil) {
        
        _inputTextV = [[UITextView alloc] initWithFrame:CGRectMake(10, 122, MAINSCREEN.width - 20, (MAINSCREEN.height - SafeDistance - 40 - 122)/3)];
        _inputTextV.editable = YES;
        _inputTextV.font = [UIFont fontWithName:TEXTFONT size:16.0];
        _inputTextV.textColor = TEXTCOLOR64;
        _inputTextV.text = @"快点来进行评论";
        _inputTextV.delegate = self;
        _inputTextV.backgroundColor = [PublicClass colorWithHexString:@"#ececec"];
    }
    return _inputTextV;
}

- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _manager.configuration.openCamera = YES;
        _manager.configuration.photoMaxNum = 5;
    }
    return _manager;
}

- (HXPhotoView *)photoView{
    
    if (_photoView == nil) {
        
        _photoView = [[HXPhotoView alloc] initWithFrame:CGRectMake(10, self.inputTextV.frame.size.height + self.inputTextV.frame.origin.y + 15, MAINSCREEN.width - 20, 0) manager:self.manager];
        _photoView.delegate = self;
        [_photoView refreshView];
    }
    return _photoView;
}

- (NSMutableArray *)imageMutableA{
    
    if (_imageMutableA == nil) {
        
        _imageMutableA = [[NSMutableArray alloc] init];
    }
    return _imageMutableA;
}

- (UIButton *)submitBtn{
    
    if (_submitBtn == nil) {
        
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.frame = CGRectMake(10, MAINSCREEN.height - SafeDistance - 40, MAINSCREEN.width - 20, 34);
        _submitBtn.layer.cornerRadius = 6.0;
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.titleLabel.font = [UIFont fontWithName:TEXTFONT size:14.0];
        [_submitBtn setBackgroundColor:LOGINBACKCOLOR forState:UIControlStateNormal];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(chickSubmitBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"评价";
    [self addViews];
    // Do any additional setup after loading the view.
}

- (void)addViews{
    
    [self.view addSubview:self.tobeHeadView];
    [self.view addSubview:self.inputTextV];
    [self.view addSubview:self.photoView];
    [self.view addSubview:self.submitBtn];
}

- (void)chickSubmitBtn:(UIButton *)button{
    
    NSDictionary *postDic = @{@"orderNo":orderNo, @"userId":[NSString stringWithFormat:@"%@", [UserConfig user_id]], @"storeId":storeIdStr, @"content":self.inputTextV.text, @"starNo":[NSString stringWithFormat:@"%ld", (_tobeHeadView.startMutableA.count + 1)]};
    NSString *reqJson = [PublicClass convertToJsonData:postDic];
    float imgCompressionQuality = 0.3;//图片压缩比例
    NSMutableArray <JJFileParam *> *fileArray = [[NSMutableArray alloc] init];
    for (int i = 0; i<self.imageMutableA.count; i++) {
        
        UIImage *image = self.imageMutableA[i];
        NSData *mainData=UIImageJPEGRepresentation(image, imgCompressionQuality);
        JJFileParam *jjfileParam = [JJFileParam fileConfigWithfileData:mainData name:[NSString stringWithFormat:@"img%d", i] fileName:[NSString stringWithFormat:@"img%d.png", i] mimeType:@"image/jpg/png/jpeg"];
        [fileArray addObject:jjfileParam];
    }
//    fileArray = @[[JJFileParam fileConfigWithfileData:mainData name:@"jiashizhengzhuye" fileName:@"jiashizhengzhuye.png" mimeType:@"image/jpg/png/jpeg"]];
    [JJRequest updateRequest:@"userCommitComment" params:@{@"reqJson":reqJson, @"token":[UserConfig token]} fileConfig:(NSArray *)fileArray progress:^(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        
    } success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
            [PublicClass showHUD:messageStr view:self.view];
        }
    } complete:^(id  _Nullable dataObj, NSError * _Nullable error) {
        
    }];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@""]){
        textView.text = @"快点来进行评论";
        textView.textColor = [UIColor grayColor];
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"快点来进行评论"]){
        textView.text=@"";
        textView.textColor=[UIColor blackColor];
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text{
    
    if ([text isEqualToString:@"\n"]) { 
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark HXPhotoViewDelegate
- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
    
    [self.imageMutableA removeAllObjects];
    for (int i = 0; i<photos.count; i++) {
        
        HXPhotoModel *hxPhotoModel = [photos objectAtIndex:i];
        [self.imageMutableA addObject:hxPhotoModel.thumbPhoto];
    }
    NSLog(@"%@", self.imageMutableA);
}

- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame {
//    NSSLog(@"%@",NSStringFromCGRect(frame));
//    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, CGRectGetMaxY(frame) + kPhotoViewMargin);
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

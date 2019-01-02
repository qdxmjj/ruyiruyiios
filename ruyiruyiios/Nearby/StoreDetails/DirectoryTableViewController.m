//
//  DirectoryTableViewController.m
//  TestCommodityInfo
//
//  Created by 小马驾驾 on 2018/5/30.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "DirectoryTableViewController.h"
#import "DirectoryTableViewCell.h"

#define backgroundLightGrayColor [UIColor colorWithRed:240.f/255.f green:240.f/255.f blue:240.f/255.f alpha:1.f]

@interface DirectoryTableViewController ()

@property(nonatomic,strong)NSIndexPath *indexpath;


@property(nonatomic,assign)NSInteger index;

@property(nonatomic,strong)NSIndexPath *cellPath;
@end

@implementation DirectoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DirectoryTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"directoryCellID"];
    self.tableView.showsVerticalScrollIndicator = NO;

    self.automaticallyAdjustsScrollViewInsets = NO;
    
#ifdef __IPHONE_11_0

    self.tableView.estimatedRowHeight = 40;
    
#endif

}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //防止push到别的页面 再回到此页面 cell选中状态丢失
    if (self.indexpath) {
        
        [self.tableView selectRowAtIndexPath:self.indexpath animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
    
}
/**
   * pramer 页面数据处理流程
   *  sevrviceGroup 接收到四个大类所有的商品
   * sevrviceGroup 服务项目组，内包含四个服务小类数组，在小类数组最后一位拼接一个字符，用来记录当前选中的商品
   * 根据self.index 取出对应大类的商品数组
   * 填充数据到商品目录
   * 每次点击服务大类，就根据数据来刷新当前商品目录 sevrviceGroup
   * 每次点击商品目录cell  就修改一次当前选中的商品 sevrviceGroup
 */
-(void)setSubScript:(NSInteger)subScript{
    
    _subScript = subScript;
    
    self.index = _subScript;
    
    [self.tableView reloadData];//填充数据
    
    
    //设置选中
    if (self.sevrviceGroup.count>0) {
        
        __block NSInteger row; //要滚动到哪一行
        __block BOOL isError = NO; //异常错误 如 有商品id 无商品目录id
        
        if (self.defaultSelectedIndex) {
            
            [self.sevrviceGroup[_subScript] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    
                    if ([[obj objectForKey:@"serviceId"] integerValue] == self.defaultSelectedIndex) {
                        
                        row = idx;
                        *stop = YES;
                    }
                }else{
                    
                    isError = YES;
                }
            }];
        }else{
            
            row = [[self.sevrviceGroup[_subScript] lastObject] integerValue];
        }
        
        if (isError == YES) {
            
            [PublicClass showHUD:@"查询商品目录失败!" view:self.view];
            return;
        }
        
        self.defaultSelectedIndex = 0;//每次使用后清0 防止手动点击后造成点击超出小类个数
        
        [self.sevrviceGroup[_subScript] replaceObjectAtIndex:[self.sevrviceGroup[_subScript] count]-1 withObject:[NSString stringWithFormat:@"%ld",row]];//修改源数据
        
        if ([self.sevrviceGroup[_subScript] count]<=1) {
            
            //如果没有商品目录，要刷新一下商品页面内容，传空
            self.refreshBlock(10086, @"");
            return;
        }
        
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];//默认选中效果
    }
}


-(NSMutableArray *)sevrviceGroup{
    
    if (!_sevrviceGroup) {
        
        _sevrviceGroup = [NSMutableArray array];
    }
    
    return _sevrviceGroup;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.sevrviceGroup.count>0) {
        
        NSArray *arr = self.sevrviceGroup[self.index];
        
        return arr.count-1;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DirectoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"directoryCellID" forIndexPath:indexPath];
    
    NSArray *currentPageData = self.sevrviceGroup[self.index];//取出大类对应的小类数组

    cell.titleLab.text = [currentPageData[indexPath.row] objectForKey:@"serviceName"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.orangeLable.hidden = YES;

    NSInteger badge = [[currentPageData[indexPath.row] objectForKey:@"badgeNumber"] integerValue];

    if (badge >0) {

        cell.badgeLab.hidden = NO;
        cell.badgeLab.text = [NSString stringWithFormat:@"%@",[currentPageData[indexPath.row] objectForKey:@"badgeNumber"]];//设置角标
    }else{

        cell.badgeLab.hidden = YES;
    }
    
    if (indexPath.row == [[currentPageData lastObject] integerValue]) {
        //默认选中哪一个
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.orangeLable.hidden = NO;
        self.refreshBlock(indexPath.row,[currentPageData[indexPath.row] objectForKey:@"serviceId"]);
        self.indexpath = indexPath;//记录选中的cell
    } else {
        
        cell.contentView.backgroundColor = backgroundLightGrayColor;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DirectoryTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.orangeLable.hidden = NO;
    NSInteger rows = [self.sevrviceGroup[self.index] count];
    
    [self.sevrviceGroup[self.index] replaceObjectAtIndex:rows-1 withObject:[NSString stringWithFormat:@"%ld",indexPath.row]];

    self.indexpath = indexPath;//记录选中的cell
    NSArray *currentPage = self.sevrviceGroup[self.index];

    self.refreshBlock(indexPath.row,[currentPage[indexPath.row] objectForKey:@"serviceId"]);
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{

    DirectoryTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    cell.contentView.backgroundColor = backgroundLightGrayColor;
    cell.orangeLable.hidden = YES;
    if (indexPath.row == 0) {
        
        cell.backgroundColor =  backgroundLightGrayColor;
    }
    //bug push到另一个页面再回到此页面 选择状态就没了
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //计算后高度
    return UITableViewAutomaticDimension;
}


-(void)refreshBadgeNumberWithserviceID:(NSInteger )serviceID{

    NSArray *currentPage = self.sevrviceGroup[self.index];

    [currentPage enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (![obj isKindOfClass:[NSDictionary class]]) {
            
            *stop = YES;
            return ;
        }
        
        if ([[obj objectForKey:@"serviceId"] longLongValue] == serviceID) {
            
            DirectoryTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]];
            
            cell.badgeLab.text = [NSString stringWithFormat:@"%@",[obj objectForKey:@"badgeNumber"]];
            
            if ([[obj objectForKey:@"badgeNumber"] integerValue] ==0) {
                
                cell.badgeLab.hidden = YES;
            }else{
                cell.badgeLab.hidden = NO;
            }
            *stop = YES;
        }
       
    }];
    
}
@end

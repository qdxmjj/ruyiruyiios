//
//  SearchRecord.m
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/11.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "SearchRecord.h"
@interface SearchRecord ()

@property(nonatomic,copy)NSString *filePatch;

@end
@implementation SearchRecord

-(void)addSearchReacord:(NSString *)searchContent{

    
    if (!self.filePatch) {
        
        self.filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"city.plist"];
    }
    
    NSMutableArray *dataDictionary = [self getSearchReacord].mutableCopy;

    [dataDictionary addObject:searchContent];
    
    BOOL ifSave = [dataDictionary writeToFile:self.filePatch atomically:YES];

    
    if (ifSave) {
        
        NSLog(@"存储成功");
    }
}

-(BOOL)emptySearchRecord{
    
    BOOL ifSave = [@[] writeToFile:self.filePatch atomically:YES];

    if (ifSave) {
        
        NSLog(@"清空成功");
        
    }
    return ifSave;
}

-(NSArray *)getSearchReacord{

    if (!self.filePatch) {
        
        return @[];
    }
    
    NSMutableArray *searchReacordAry = [[NSMutableArray alloc] initWithContentsOfFile:self.filePatch];
    
    if (!searchReacordAry) {
        
        searchReacordAry = [NSMutableArray array];
    }
    
    return searchReacordAry;
}

-(NSString *)filePatch{
    if (!_filePatch) {
        _filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"searchRecord.plist"];
    }
    return _filePatch;
}
@end

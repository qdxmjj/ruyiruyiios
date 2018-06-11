//
//  SearchRecord.h
//  ruyiruyiios
//
//  Created by 小马驾驾 on 2018/6/11.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchRecord : NSObject

-(void)addSearchReacord:(NSString *)searchContent;

-(BOOL)emptySearchRecord;

-(NSArray *)getSearchReacord;

@end

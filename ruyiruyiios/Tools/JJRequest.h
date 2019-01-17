//
//  JJRequest.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/4/26.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JJFileParam.h"
/**
 请求成功block
 */
typedef void (^requestSuccessBlock)( NSString * _Nullable code, NSString * _Nullable message, _Nullable id data);

/**
 请求失败block
 */
typedef void (^requestFailureBlock) (NSError * _Nullable error);

/**
 请求响应block
 */
typedef void (^responseBlock)(_Nullable id dataObj, NSError * _Nullable error);

typedef void (^interchangeableRequestSuccessBlock)(id _Nullable data);

typedef void (^GL_requestSuccessBlock)( id _Nullable rows, _Nullable id total);

/**
 监听进度响应block
 */
typedef void (^progressBlock)(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite);
/**
 下载文件的路径响应block
 */
typedef void (^destinationBlock)(NSURL * _Nonnull documentUrl);

@interface JJRequest : NSObject


+ (BOOL)checkNetworkStatus;

/**
 GET请求
 */
+ (void)getRequest:(nonnull NSString *)url params:(NSDictionary * _Nullable)params success:(_Nullable requestSuccessBlock)successHandler failure:(_Nullable requestFailureBlock)failureHandler;

/**
 POST请求
 */
+ (void)postRequest:(nonnull NSString *)url params:(NSDictionary *_Nullable )params success:(_Nullable requestSuccessBlock)successHandler failure:(_Nullable requestFailureBlock)failureHandler;

/**
 PUT请求
 */
+ (void)putRequestWithIP:(nonnull NSString *)IP path:(NSString *)path params:(NSDictionary *_Nullable )params success:(_Nullable  requestSuccessBlock)successHandler failure:(_Nullable  requestFailureBlock)failureHandler;

/**
 DELETE请求
 */
+ (void)deleteRequestWithIP:(nonnull NSString *)IP path:(NSString *)path params:(NSDictionary *_Nullable )params success:(_Nullable requestSuccessBlock)successHandler failure:(_Nullable requestFailureBlock)failureHandler;

/**
 下载文件，监听下载进度
 */
+ (void)downloadRequest:(nonnull NSString *)url successAndProgress:(_Nullable progressBlock)progressHandler destination:(_Nullable destinationBlock)destinationHandler complete:(_Nullable responseBlock)completionHandler;

/**
 文件上传，监听上传进度
 */
+ (void)updateRequest:(NSString * _Nullable )url params:( NSDictionary * _Nullable )params fileConfig:( NSArray<JJFileParam*> * _Nullable )fileArray progress:(_Nullable progressBlock)progressHandler success:(_Nullable requestSuccessBlock)successHandler complete:(_Nullable responseBlock)completionHandler;

+ (void)commonPostRequest:(NSString *)url params:(NSDictionary *)params hostNameStr:(NSString *)hostStr success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler;

+ (void)testPostRequest:(NSString *)url params:(NSDictionary *)params serviceAddress:(NSString *)hostAddress success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler;

//通用get
+ (void)interchangeableGetRequest:(nonnull NSString *)url params:(NSDictionary * _Nullable)params success:(_Nullable interchangeableRequestSuccessBlock)successHandler failure:(_Nullable requestFailureBlock)failureHandler;

//通用post
+ (void)interchangeablePostRequestWithIP:(nonnull NSString *)IP path:(NSString *)path params:(NSDictionary * _Nullable)params success:(_Nullable interchangeableRequestSuccessBlock)successHandler failure:(_Nullable requestFailureBlock)failureHandler;

//龚琳 post
+ (void)GL_PostRequest:(NSString *_Nullable)url params:(NSDictionary *_Nullable)params success:(GL_requestSuccessBlock _Nullable )successHandler failure:(requestFailureBlock _Nullable )failureHandler;


@end

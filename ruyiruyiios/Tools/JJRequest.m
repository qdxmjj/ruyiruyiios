//
//  JJRequest.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/4/26.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "JJRequest.h"
#import <AFNetworking.h>
#import "MBProgressHUD+YYM_category.h"
#import "CodeLoginViewController.h"

@implementation JJRequest
//单列 防止AF内存泄漏
+ (AFHTTPSessionManager *)sharedHTTPSession{
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
    });
    return manager;
}

//无单列 存在内存泄漏
+ (AFHTTPSessionManager *)getRequestManager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    /**
     *  可以接受的类型
     */
    //        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    /**
     *  请求队列的最大并发数
     */
    //        manager.operationQueue.maxConcurrentOperationCount = 5;
    /**
     *  请求超时的时间
     */
    manager.requestSerializer.timeoutInterval = 20;
    /**
     *  Content-Type
     */
    //    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //    manager.requestSerializer.HTTPMethodsEncodingParametersInURI=[NSSet setWithObjects:@"GET", @"HEAD", @"DELETE", nil];
//    manager.responseSerializer.acceptableContentTypes= [NSSet setWithObject:@"text/plain",@"text/html"];
    
    
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    //    [securityPolicy setAllowInvalidCertificates:YES];
    //    [manager setSecurityPolicy:securityPolicy];
    return manager;
}


+ (void)getRequest:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler {
    
    //网络不可用
    if ([self checkNetworkStatus] == NO) {
        successHandler(nil,nil,nil);
        failureHandler(nil);
        return;
    }
    
    AFHTTPSessionManager *manager = [self getRequestManager];
    
    [manager GET:url parameters:params progress: nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
             

             
             NSString *code = [responseObject objectForKey:@"status"];
             NSString *message = [responseObject objectForKey:@"msg"];
             id data = [responseObject objectForKey:@"data"];
             successHandler(code,message,data);
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"------请求失败-------%@",error);
             failureHandler(error);
         }];
    
}

+ (void)commonPostRequest:(NSString *)url params:(NSDictionary *)params hostNameStr:(NSString *)hostStr success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler {
    
    if ([self checkNetworkStatus] == NO) {
        successHandler(nil,nil,nil);
        failureHandler(nil);
        return;
    }
    
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    if (!reachabilityManager.isReachableViaWiFi) {

        
    }
    
    AFHTTPSessionManager *manager = [self getRequestManager];
    
    [manager POST:[NSString stringWithFormat:@"%@/%@",hostStr,url] parameters:params progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
            
//              NSLog(@"%@", responseObject);
              NSString *code = [responseObject objectForKey:@"status"];
              NSString *message = [responseObject objectForKey:@"msg"];
              id data = [responseObject objectForKey:@"data"];
              
              successHandler(code,message,data);
              
          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"------请求失败-------%@",error);
              
              [self requestErrorCode:error.code];
              
              failureHandler(error);
          }];
}

+ (void)postRequest:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler {
    
    if ([self checkNetworkStatus] == NO) {
        successHandler(nil,nil,nil);
        failureHandler(nil);
        return;
    }
    
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    if (!reachabilityManager.isReachableViaWiFi) {
        
    }
    
    AFHTTPSessionManager *manager = [self getRequestManager];
    
    [manager POST:[NSString stringWithFormat:@"%@/%@",SERVERPREFIX,url] parameters:params progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
              
              //              NSLog(@"%@", responseObject);
              NSString *code = [responseObject objectForKey:@"status"];
              NSString *message = [responseObject objectForKey:@"msg"];
              id data = [responseObject objectForKey:@"data"];
              
              successHandler(code,message,data);
              
          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"------请求失败-------%@",error);
              
              [self requestErrorCode:error.code];
              
              failureHandler(error);
          }];
}

+ (void)testPostRequest:(NSString *)url params:(NSDictionary *)params serviceAddress:(NSString *)hostAddress success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler {
    
    if ([self checkNetworkStatus] == NO) {
        successHandler(nil,nil,nil);
        failureHandler(nil);
        return;
    }
    
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    if (!reachabilityManager.isReachableViaWiFi) {
        
        
    }
    
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    AFHTTPSessionManager *manager = [self sharedHTTPSession];
    [manager setSecurityPolicy:securityPolicy];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:[NSString stringWithFormat:@"%@/%@",hostAddress,url] parameters:params progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
              
              NSLog(@"%@", responseObject);
              NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
              successHandler(@"",responseStr,@"");
          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"------请求失败-------%@",error);
              
              [self requestErrorCode:error.code];
              
              failureHandler(error);
          }];
}
+ (void)interchangeableGetRequest:(nonnull NSString *)url params:(NSDictionary * _Nullable)params success:(_Nullable interchangeableRequestSuccessBlock)successHandler failure:(_Nullable requestFailureBlock)failureHandler{
    
    //网络不可用
    if ([self checkNetworkStatus] == NO) {
        successHandler(nil);
        failureHandler(nil);
        return;
    }
    
    AFHTTPSessionManager *manager = [self getRequestManager];
    
    [manager GET:url parameters:params progress: nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
             
             
             
             successHandler(responseObject);
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"------请求失败-------%@",error);
             failureHandler(error);
         }];
}
+(void)interchangeablePostRequest:(NSString *)url params:(NSDictionary *)params success:(interchangeableRequestSuccessBlock )successHandler failure:(requestFailureBlock)failureHandler{
    
    if ([self checkNetworkStatus] == NO) {
        successHandler(nil);
        failureHandler(nil);
        return;
    }
    
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    if (!reachabilityManager.isReachableViaWiFi) {
        
    }
    
    AFHTTPSessionManager *manager = [self getRequestManager];
    
    [manager POST:[NSString stringWithFormat:@"%@/%@",GL_RuYiRuYiIP,url] parameters:params progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
              
              
              successHandler(responseObject);
              
          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"------请求失败-------%@",error);
              
              [self requestErrorCode:error.code];
              
              failureHandler(error);
          }];
    
    
}
+ (void)GL_PostRequest:(NSString *)url params:(NSDictionary *)params success:(GL_requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler{
    
    if ([self checkNetworkStatus] == NO) {
        successHandler(nil,nil);
        failureHandler(nil);
        return;
    }
    
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    if (!reachabilityManager.isReachableViaWiFi) {
        
    }
    
    AFHTTPSessionManager *manager = [self getRequestManager];
    
    [manager POST:[NSString stringWithFormat:@"%@/%@",GL_RuYiRuYiIP,url] parameters:params progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
              
              NSString *total = [responseObject objectForKey:@"total"];
              id rows = [responseObject objectForKey:@"rows"];
              
              successHandler(rows,total);
              
          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"------请求失败-------%@",error);
              
              [self requestErrorCode:error.code];
              
              failureHandler(error);
          }];
}

+ (void)putRequest:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler {
    
    if ([self checkNetworkStatus] == NO) {
        successHandler(nil,nil,nil);
        failureHandler(nil);
        return;
    }
    
    AFHTTPSessionManager *manager = [self getRequestManager];
    [manager PUT:url parameters:params
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             NSString *code = [responseObject objectForKey:@"status"];
             NSString *message = [responseObject objectForKey:@"msg"];
             id data = [responseObject objectForKey:@"data"];
             successHandler(code,message,data);
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"------请求失败-------%@",error);
             failureHandler(error);
         }];
}

+ (void)deleteRequest:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler {
    
    if ([self checkNetworkStatus] == NO) {
        successHandler(nil,nil,nil);
        failureHandler(nil);
        return;
    }
    
    AFHTTPSessionManager *manager = [self getRequestManager];
    [manager DELETE:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *code = [responseObject objectForKey:@"status"];
        NSString *message = [responseObject objectForKey:@"msg"];
        id data = [responseObject objectForKey:@"data"];
        successHandler(code,message,data);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"------请求失败-------%@",error);
        failureHandler(error);
    }];
}


/**
 下载文件，监听下载进度
 */
+ (void)downloadRequest:(NSString *)url successAndProgress:(progressBlock)progressHandler destination:(destinationBlock _Nullable)destinationHandler complete:(responseBlock _Nullable)completionHandler {
    
    if ([self checkNetworkStatus] == NO) {
        progressHandler(0, 0, 0);
        completionHandler(nil, nil);
        return;
    }
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:sessionConfiguration];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    __block  NSProgress *kProgress = nil;
    
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        kProgress = downloadProgress;
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSURL *documentUrl = [[NSFileManager defaultManager] URLForDirectory :NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        documentUrl = [documentUrl URLByAppendingPathComponent:[response suggestedFilename]];
        destinationHandler(documentUrl);
        return documentUrl;
        
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nonnull filePath, NSError * _Nonnull error){
        if (error) {
            NSLog(@"------下载失败-------%@",error);
        }
        completionHandler(response, error);
    }];
    
    [manager setDownloadTaskDidWriteDataBlock:^(NSURLSession * _Nonnull session, NSURLSessionDownloadTask * _Nonnull downloadTask, int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        
        progressHandler(bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
        
    }];
    [downloadTask resume];
}

/**
 *
 *   上传文件，监听上传进度
 */
+ (void)updateRequest:(NSString *)url params:(NSDictionary *)params fileConfig:(NSArray<JJFileParam*> *)fileArray progress:(progressBlock)progressHandler success:(requestSuccessBlock)successHandler complete:(responseBlock)completionHandler  {
    
    if ([self checkNetworkStatus] == NO) {
        progressHandler(0, 0, 0);
        completionHandler(nil, nil);
        return;
    }
    
    AFHTTPSessionManager *manager = [self getRequestManager];
    
    //上传图片延长 上传时间
    manager.requestSerializer.timeoutInterval = 40;
    
    [manager POST:[NSString stringWithFormat:@"%@/%@",SERVERPREFIX,url] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  formData) {
        
        for (JJFileParam *upload in fileArray) {
            
            [formData appendPartWithFileData:upload.fileData name:upload.name fileName:upload.fileName mimeType:upload.mimeType];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress){
        progressHandler(0,0,0);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *code = [responseObject objectForKey:@"status"];
        NSString *message = [responseObject objectForKey:@"msg"];
        id data = [responseObject objectForKey:@"data"];
        
    
        
        successHandler(code,message,data);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      
        
        [self requestErrorCode:error.code];

        completionHandler(task,error);
    }];
}

/**
 监控网络状态
 */
+ (BOOL)checkNetworkStatus{
    //废弃  返回值始终都是yes
    
//    __block BOOL isNetworkUse = YES;
//
//    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
//    [reachabilityManager startMonitoring];
//    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        if (status == AFNetworkReachabilityStatusUnknown) {
//            isNetworkUse = YES;
//            NSLog(@"未知网络");
//        } else if (status == AFNetworkReachabilityStatusReachableViaWiFi){
//            isNetworkUse = YES;
//            NSLog(@"当前网络为wifi");
//        } else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
//            isNetworkUse = YES;
//            NSLog(@"当前网络为蜂窝数据");
//        } else if (status == AFNetworkReachabilityStatusNotReachable){
//            // 网络异常操作
//            isNetworkUse = NO;
//            [MBProgressHUD showTextMessage:@"网络异常,请检查网络是否可用！"];
//        }else{
//            isNetworkUse = NO;
//        }
//    }];

    return YES;
}

+(void)requestErrorCode:(NSUInteger )errorCode{
    
    switch (errorCode) {
        case -1001:
            [MBProgressHUD showError:@"网络请求超时！" integer:errorCode];
            break;
        case -1004:
        
            [MBProgressHUD showError:@"无法连接服务器！" integer:errorCode];
            break;
        case -1009:
            
            [MBProgressHUD showError:@"无网络连接，请检查网络！" integer:errorCode];
            break;
        default:
            
            [MBProgressHUD showError:@"网络错误，请稍后再试！" integer:errorCode];
            break;
    }
}
@end

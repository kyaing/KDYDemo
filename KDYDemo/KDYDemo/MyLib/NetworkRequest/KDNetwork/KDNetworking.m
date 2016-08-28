//
//  KDNetworking.m
//  KDYDemo
//
//  Created by zhongye on 16/2/22.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDNetworking.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"

static NSString *networkBaseUrl = nil;
static NSDictionary *httpHeaders = nil;

#define timeoutIntervalRequest  13
#define maxOperationCountReuque  3

@implementation KDNetworking

#pragma mark - Private
+ (AFHTTPSessionManager *)manager {
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    AFHTTPSessionManager *manager = nil;
    if ([self baseUrl] != nil) {
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[self baseUrl]]];
    } else {
        manager = [AFHTTPSessionManager manager];
    }
    
    //确定请求和返回的数据为JSON格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    
    //配置请求头
    for (NSString *key in httpHeaders.allKeys) {
        if (httpHeaders[key] != nil) {
            [manager.requestSerializer setValue:httpHeaders[key] forHTTPHeaderField:key];
        }
    }
    
    //设置允许的最大并发数
    manager.operationQueue.maxConcurrentOperationCount = maxOperationCountReuque;
    manager.requestSerializer.timeoutInterval = timeoutIntervalRequest;
    
    return manager;
}

+ (KDURLSessionTask *)requestWithUrl:(NSString *)url
                          httpMethod:(NSInteger)httpMethod
                              params:(NSDictionary *)params
                            progress:(KDDownloadProgress)progress
                             success:(KDResponseSucess)success
                                fail:(KDResponseFail)fail {
    //创建AFHTTPSessionManager
    AFHTTPSessionManager *manager = [self manager];
    
    if ([self baseUrl] == nil) {
        if ([NSURL URLWithString:url] == nil) {
            return nil;
        }
    } else {
        if ([NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [self baseUrl], url]] == nil) {
            return nil;
        }
    }
    
    KDURLSessionTask *session = nil;
    if (httpMethod == 1) {  //GET
        session = [manager GET:url parameters:params progress:^(NSProgress *downloadProgress) {
            if (progress) {
                progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
            }
            
        } success:^(NSURLSessionDataTask *task, id responseObject) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    success(responseObject);
                }
            });
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (fail) {
                fail(error);
            }
        }];
        
    } else if (httpMethod == 2) {  //POST
        session = [manager POST:url parameters:params progress:^(NSProgress *uploadProgress) {
            if (progress) {
                progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
            }
            
        } success:^(NSURLSessionDataTask *task, id responseObject) {
            if (success) {
                success(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (fail) {
                fail(error);
            }
        }];
    }
    
    return session;
}

#pragma mark - Url
+ (NSString *)baseUrl {
    return networkBaseUrl;
}

+ (void)updateBaseUrl:(NSString *)baseUrl {
    networkBaseUrl = baseUrl;
}

+ (void)configCommonHttpHeaders:(NSDictionary *)headers {
    httpHeaders = headers;
}

#pragma mark - Get
+ (KDURLSessionTask *)getWithUrl:(NSString *)url
                         success:(KDResponseSucess)success
                            fail:(KDResponseFail)fail {
    return [self getWithUrl:url
                     params:nil
                    success:success
                       fail:fail];
}

+ (KDURLSessionTask *)getWithUrl:(NSString *)url
                          params:(NSDictionary *)params
                         success:(KDResponseSucess)success
                            fail:(KDResponseFail)fail {
    return [self getWithUrl:url
                     params:params
                   progress:nil
                    success:success
                       fail:fail];
}

+ (KDURLSessionTask *)getWithUrl:(NSString *)url
                          params:(NSDictionary *)params
                        progress:(KDGetProgress)progress
                         success:(KDResponseSucess)success
                            fail:(KDResponseFail)fail {
    return [self requestWithUrl:url
                     httpMethod:1
                         params:params
                       progress:progress
                        success:success
                           fail:fail];
}

#pragma mark - Post
+ (KDURLSessionTask *)postWithUrl:(NSString *)url
                           params:(NSDictionary *)params
                          success:(KDResponseSucess)success
                             fail:(KDResponseFail)fail {
    return [self postWithUrl:url
                      params:params
                    progress:nil
                     success:success
                        fail:fail];
}

+ (KDURLSessionTask *)postWithUrl:(NSString *)url
                           params:(NSDictionary *)params
                         progress:(KDPostProgress)progress
                          success:(KDResponseSucess)success
                             fail:(KDResponseFail)fail {
    return [self requestWithUrl:url
                     httpMethod:2
                         params:params
                       progress:progress
                        success:success
                           fail:fail];
}

#pragma mark - Download
+ (KDURLSessionTask *)downloadWithUrl:(NSString *)url
                           saveToPath:(NSString *)path
                             progress:(KDDownloadProgress)progress
                               sucess:(KDResponseSucess)sucess
                                 fail:(KDResponseFail)fail {
    if ([self baseUrl] == nil) {
        if ([NSURL URLWithString:url] == nil) {
            return nil;
        }
    } else {
        if ([NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [self baseUrl], url]] == nil) {
            return nil;
        }
    }
    
    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFHTTPSessionManager *manager = [self manager];
    
    KDURLSessionTask *session = [manager downloadTaskWithRequest:downloadRequest progress:^(NSProgress *downloadProgress) {
        if (progress) {
            progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
        }
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        return [NSURL URLWithString:path];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (sucess) {
            sucess(filePath.absoluteString);
        } else {
            fail(error);
        }
    }];
    
    return session;
}

@end


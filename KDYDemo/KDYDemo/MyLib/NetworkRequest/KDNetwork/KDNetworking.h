//
//  KDNetworking.h
//  KDYDemo
//
//  Created by zhongye on 16/2/22.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSURLSessionTask KDURLSessionTask;

/**
 *  下载进度
 *
 *  @param bytesRead  已经下载的大小
 *  @param totalBytes 需要下载的总大小
 */
typedef void (^KDDownloadProgress) (int64_t bytesRead, int64_t totalBytes);

typedef KDDownloadProgress KDGetProgress;
typedef KDDownloadProgress KDPostProgress;

/**
 *  网络请求成功的回调
 *
 *  @param response 成功请求的数据
 */
typedef void (^KDResponseSucess) (id response);

/**
 *  网络请求失败的回调
 *
 *  @param error 返回的错误信息
 */
typedef void (^KDResponseFail) (NSError *error);

@interface KDNetworking : NSObject

#pragma mark - Url
+ (void)updateBaseUrl:(NSString *)baseUrl;

+ (NSString *)baseUrl;

/**
 *  配置公共的请求头
 *
 *  @param headers 请求头的参数
 */
+ (void)configCommonHttpHeaders:(NSDictionary *)headers;

#pragma mark - Get
/**
 *  GET请求接口
 *
 *  @param url     接口路径
 *  @param success 请求成功回调
 *  @param fail    请求失败回调
 *
 *  @return 返回的对象中有可取消请求的API
 */
+ (KDURLSessionTask *)getWithUrl:(NSString *)url
                         success:(KDResponseSucess)success
                            fail:(KDResponseFail)fail;

/**
 *  GET请求接口
 *
 *  @param url     接口路径
 *  @param params  需要拼接的参数
 *  @param success 请求成功回调
 *  @param fail    请求失败回调
 *
 *  @return 返回的对象中有可取消请求的API
 */
+ (KDURLSessionTask *)getWithUrl:(NSString *)url
                          params:(NSDictionary *)params
                         success:(KDResponseSucess)success
                            fail:(KDResponseFail)fail;

/**
 *  GET请求接口
 *
 *  @param url      接口路径
 *  @param params   需要拼接的参数
 *  @param progress 下载的进度
 *  @param success  请求成功回调
 *  @param fail     请求失败回调
 *
 *  @return 返回的对象中有可取消请求的API
 */
+ (KDURLSessionTask *)getWithUrl:(NSString *)url
                          params:(NSDictionary *)params
                        progress:(KDGetProgress)progress
                         success:(KDResponseSucess)success
                            fail:(KDResponseFail)fail;

#pragma mark - Post
/**
 *  POST请求接口
 *
 *  @param url     接口路径
 *  @param params  请求的参数
 *  @param success 请求成功回调
 *  @param fail    请求失败回调
 *
 *  @return 返回的对象中有可取消请求的API
 */
+ (KDURLSessionTask *)postWithUrl:(NSString *)url
                          params:(NSDictionary *)params
                         success:(KDResponseSucess)success
                            fail:(KDResponseFail)fail;

/**
 *  POST请求接口
 *
 *  @param url      接口路径
 *  @param params   请求的参数
 *  @param progress 下载的进度
 *  @param success  请求成功回调
 *  @param fail     请求失败回调
 *
 *  @return 返回的对象中有可取消请求的API
 */
+ (KDURLSessionTask *)postWithUrl:(NSString *)url
                            params:(NSDictionary *)params
                          progress:(KDPostProgress)progress
                           success:(KDResponseSucess)success
                              fail:(KDResponseFail)fail;

#pragma mark - Download
/**
 *  下载文件
 *
 *  @param url      下载的url
 *  @param path     指定要下载的路径
 *  @param progress 下载的进度
 *  @param sucess   下载成功的回调
 *  @param fail     下载失败的回调
 *
 *  @return 返回的对象中有可取消请求的API
 */
+ (KDURLSessionTask *)downloadWithUrl:(NSString *)url
                           saveToPath:(NSString *)path
                             progress:(KDDownloadProgress)progress
                               sucess:(KDResponseSucess)sucess
                                 fail:(KDResponseFail)fail;

#pragma mark - Upload

@end


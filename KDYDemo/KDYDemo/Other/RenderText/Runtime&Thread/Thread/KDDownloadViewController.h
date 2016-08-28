//
//  KDDownloadViewController.h
//  KDYDemo
//
//  Created by zhongye on 16/1/18.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//
//  描述：文件下载

#import <UIKit/UIKit.h>

@interface KDDownLoadViewController : UIViewController

@end

/**
 思路：
 文件的下载分为小文件和大文件的下载方式：
 - 小文件：一般是对不需要等待太久就能下载好的文件，如加载的图片。
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSURL *url = [NSURL URLWithString:@""];
    NSData *data = [NSData dataWithContentOfURL:url];
 
    dispatch_async(dispatch_main_queue, ^{
 
    });
 });
 
 - 大文件：
    以上返回的数据data都是在内存中，所以不适应大文件的下载，内存会爆。
    NSURLConnection、NSURLSession(iOS7后推出，目的为了取代NSURLConnecton)
    它们都可以发送Get和Post请求，来实现文件的下载和上传。
 
    NSURLSession中，任何请求都可以被看作是一个任务，其中有三个任务：
        - NSURLSessionDataTask：普通的get/post请求。
          NSURLSession *session = [NSURLSession sharedSession];
          NSURL *url = [NSURL URLWithString:@""];
          NSURLSessionDataTask *task = [sesstion dataTaskWithURL:url complectionHandle:^{ //返回数据 }];
          [task resume];
 
        - NSURLSessionDownloadTask：文件下载。
        - NSURLSessionUploadTask：文件上传(一般很少用到，服务器会不支持)
 */


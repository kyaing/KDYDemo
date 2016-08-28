//
//  KDDownloadViewController.m
//  KDYDemo
//
//  Created by zhongye on 16/1/18.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDDownLoadViewController.h"

@interface KDDownLoadViewController () <NSURLSessionDownloadDelegate> {
    UIButton *_downloadBtn;
    UIProgressView *_progressView;
    UILabel *_progressLabel;
}

@property (nonatomic, strong) NSURLSession *session;  //会话管理
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;  //下载任务
@property (nonatomic, strong) NSData *resumeData;  //记录暂停时的数据

@end

@implementation KDDownLoadViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"Download";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建视图
    [self setupViews];
}

- (NSURLSession *)session {
    if (!_session) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        //这里不用NSURLSession中的sharedSesion创建，原因是要用代理才能监测下载时的进度
        _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    
    return _session;
}

- (void)setupViews {
    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake((kScreenWidth-300)/2, 200, 300, 10)];
    [self.view addSubview:_progressView];
    
    _progressLabel = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth-150)/2, 220, 150, 30)];
    _progressLabel.font = [UIFont systemFontOfSize:15];
    _progressLabel.textAlignment = NSTextAlignmentCenter;
    _progressLabel.textColor = [UIColor blackColor];
    _progressLabel.text = @"当前下载进度：";
    [self.view addSubview:_progressLabel];
    
    _downloadBtn = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth-100)/2, 300, 100, 100)];
    [_downloadBtn setImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
    [_downloadBtn setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateSelected];
    [_downloadBtn addTarget:self action:@selector(downloadAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_downloadBtn];
}

#pragma mark - Download
- (void)downloadAction:(UIButton *)sender {
    //按钮状态取反
    sender.selected = !sender.isSelected;
    
    if (!self.downloadTask) {  //开始(继续)下载
        if (self.resumeData) {
            [self resumeDownload];
        } else {
            [self startDownload];
        }
    } else {
        //暂停下载
        [self pauseDownload];
    }
}

- (void)startDownload {
    NSURL *url = [NSURL URLWithString:@"http://dlsw.baidu.com/sw-search-sp/soft/9d/25765/sogou_mac_32c_V3.2.0.1437101586.dmg"];
    
    //创建任务
    self.downloadTask = [self.session downloadTaskWithURL:url];
    
    //开始下载
    [self.downloadTask resume];
}

- (void)pauseDownload {
    __weak typeof(self) weakSelf = self;
    
    //NSURLSessionDownloadTask中的方法
    [self.downloadTask cancelByProducingResumeData:^(NSData *resumeData) {
        //block中的resumeData包含了取消下载时的数据(包括url及下载的数据位置)
        weakSelf.resumeData = resumeData;
        
        //暂停下载将下载任务置空
        weakSelf.downloadTask = nil;
    }];
}

- (void)resumeDownload {
    //通过保存的self.resumeData来断点下载
    self.downloadTask = [self.session downloadTaskWithResumeData:self.resumeData];
    [self.downloadTask resume];
    
    //将之前保存的断点置空
    self.resumeData = nil;
}

#pragma mark - NSURLSessionDownloadDelegate
/**
 *  下载完毕会调用
 *  @param location  文件临时地址，就是下载好的文件写入沙盒的地址(tmp目录)
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    //caches目录路径
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [caches stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    
    //将临时文件夹剪切或复制到缓存目录下，临时文件夹会在下载完成后立即消失
    //AtPath : 剪切前的文件路径
    //ToPath : 剪切后的文件路径
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager moveItemAtPath:location.path toPath:file error:nil];
    
    //最终提示下载完成
    [[[UIAlertView alloc] initWithTitle:@"下载完成" message:downloadTask.response.suggestedFilename delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil] show];
}

/**
 *  每次写入沙盒完毕调用
 *  在这里面监听下载进度，totalBytesWritten/totalBytesExpectedToWrite
 *
 *  @param bytesWritten              这次写入的大小
 *  @param totalBytesWritten         已经写入沙盒的大小
 *  @param totalBytesExpectedToWrite 文件总大小
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    _progressView.progress = (double)totalBytesWritten/totalBytesExpectedToWrite;
    _progressLabel.text = [NSString stringWithFormat:@"当前下载进度：%0.f%%", ((double)totalBytesWritten/totalBytesExpectedToWrite) * 100];
}

/**
 *  恢复下载后调用
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes {
    
}


@end


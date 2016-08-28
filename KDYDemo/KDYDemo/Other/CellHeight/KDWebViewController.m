//
//  KDWebViewController.m
//  KDYDemo
//
//  Created by zhongye on 16/3/16.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDWebViewController.h"

@interface KDWebViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSURL *url;

@end

@implementation KDWebViewController

- (instancetype)initWithURL:(NSURL *)url {
    self = [super init];
    if (self) {
        _url = url;
        _webView = [UIWebView new];
        _webView.delegate = self;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webView.frame = self.view.bounds;
    [_webView loadRequest:[NSURLRequest requestWithURL:_url]];
    [self.view addSubview:_webView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

@end

